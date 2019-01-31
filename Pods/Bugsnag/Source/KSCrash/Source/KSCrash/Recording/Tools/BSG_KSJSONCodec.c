//
// BSG_KSJSONCodec.c
//
//  Created by Karl Stenerud on 2012-01-07.
//
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#include "BSG_KSJSONCodec.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

// ============================================================================
#pragma mark - Configuration -
// ============================================================================

/** Set to 1 if you're also compiling BSG_KSLogger and want to use it here */
#ifndef BSG_KSJSONCODEC_UseKSLogger
#define BSG_KSJSONCODEC_UseKSLogger 1
#endif

#if BSG_KSJSONCODEC_UseKSLogger
#include "BSG_KSLogger.h"
#else
#define BSG_KSLOG_ERROR(FMT, ...)
#endif


/** The work buffer size to use when escaping string values.
 * There's little reason to change this since nothing ever gets truncated.
 */
#ifndef BSG_KSJSONCODEC_WorkBufferSize
#define BSG_KSJSONCODEC_WorkBufferSize 512
#endif

// ============================================================================
#pragma mark - Helpers -
// ============================================================================

// Compiler hints for "if" statements
#define likely_if(x) if (__builtin_expect(x, 1))
#define unlikely_if(x) if (__builtin_expect(x, 0))

/** Used for writing hex string values. */
static char bsg_g_hexNybbles[] = {'0', '1', '2', '3', '4', '5', '6', '7',
                                  '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

const char *bsg_ksjsonstringForError(const int error) {
    switch (error) {
    case BSG_KSJSON_ERROR_INVALID_CHARACTER:
        return "Invalid character";
    case BSG_KSJSON_ERROR_CANNOT_ADD_DATA:
        return "Cannot add data";
    case BSG_KSJSON_ERROR_INCOMPLETE:
        return "Incomplete data";
    case BSG_KSJSON_ERROR_INVALID_DATA:
        return "Invalid data";
    default:
        return "(unknown error)";
    }
}

// ============================================================================
#pragma mark - Encode -
// ============================================================================

// Avoiding static functions due to linker issues.

/** Add JSON encoded data to an external handler.
 * The external handler will decide how to handle the data (store/transmit/etc).
 *
 * @param context The encoding context.
 *
 * @param data The encoded data.
 *
 * @param length The length of the data.
 *
 * @return true if the data was handled successfully.
 */
#define addJSONData(CONTEXT, DATA, LENGTH)                                     \
    (CONTEXT)->addJSONData(DATA, LENGTH, (CONTEXT)->userData)

/** Escape a string portion for use with JSON and send to data handler.
 *
 * @param context The JSON context.
 *
 * @param string The string to escape and write.
 *
 * @param length The length of the string.
 *
 * @return true if the data was handled successfully.
 */
int bsg_ksjsoncodec_i_appendEscapedString(
    BSG_KSJSONEncodeContext *const context, const char *restrict const string,
    size_t length) {
    char workBuffer[BSG_KSJSONCODEC_WorkBufferSize];
    const char *const srcEnd = string + length;

    const char *restrict src = string;
    char *restrict dst = workBuffer;

    // Simple case (no escape or special characters)
    for (; src < srcEnd && *src != '\\' && *src != '\"' &&
           (unsigned char)*src >= ' ';
         src++) {
        *dst++ = *src;
    }
    
    // Deal with complicated case (if any)
    for (; src < srcEnd; src++) {
        switch (*src) {
        case '\\':
        case '\"':
            *dst++ = '\\';
            *dst++ = *src;
            break;
        case '\b':
            *dst++ = '\\';
            *dst++ = 'b';
            break;
        case '\f':
            *dst++ = '\\';
            *dst++ = 'f';
            break;
        case '\n':
            *dst++ = '\\';
            *dst++ = 'n';
            break;
        case '\r':
            *dst++ = '\\';
            *dst++ = 'r';
            break;
        case '\t':
            *dst++ = '\\';
            *dst++ = 't';
            break;
        default:
                
            // escape control chars (U+0000 - U+001F)
            // see https://www.ietf.org/rfc/rfc4627.txt
                
            if ((unsigned char)*src < ' ') {
                unsigned int last = *src % 16;
                unsigned int first = (*src - last) / 16;
                
                *dst++ = '\\';
                *dst++ = 'u';
                *dst++ = '0';
                *dst++ = '0';
                *dst++ = bsg_g_hexNybbles[first];
                *dst++ = bsg_g_hexNybbles[last];
            } else {
                *dst++ = *src;
            }
        }
    }
    size_t encLength = (size_t)(dst - workBuffer);
    dst -= encLength;
    return addJSONData(context, dst, encLength);
}

/** Escape a string for use with JSON and send to data handler.
 *
 * @param context The JSON context.
 *
 * @param string The string to escape and write.
 *
 * @param length The length of the string.
 *
 * @return true if the data was handled successfully.
 */
int bsg_ksjsoncodec_i_addEscapedString(BSG_KSJSONEncodeContext *const context,
                                       const char *restrict const string,
                                       size_t length) {
    int result = BSG_KSJSON_OK;

    // Keep adding portions until the whole string has been processed.
    size_t offset = 0;
    while (offset < length) {
        size_t toAdd = length - offset;
        unlikely_if(toAdd > BSG_KSJSONCODEC_WorkBufferSize / 2) {
            toAdd = BSG_KSJSONCODEC_WorkBufferSize / 2;
        }
        result = bsg_ksjsoncodec_i_appendEscapedString(context, string + offset,
                                                       toAdd);
        unlikely_if(result != BSG_KSJSON_OK) { break; }
        offset += toAdd;
    }
    return result;
}

/** Escape and quote a string for use with JSON and send to data handler.
 *
 * @param context The JSON context.
 *
 * @param string The string to escape and write.
 *
 * @param length The length of the string.
 *
 * @return true if the data was handled successfully.
 */
int bsg_ksjsoncodec_i_addQuotedEscapedString(
    BSG_KSJSONEncodeContext *const context, const char *restrict const string,
    size_t length) {
    int result;
    unlikely_if((result = addJSONData(context, "\"", 1)) != BSG_KSJSON_OK) {
        return result;
    }
    unlikely_if((result = bsg_ksjsoncodec_i_addEscapedString(
                     context, string, length)) != BSG_KSJSON_OK) {
        return result;
    }
    return addJSONData(context, "\"", 1);
}

int bsg_ksjsonbeginElement(BSG_KSJSONEncodeContext *const context,
                           const char *const name) {
    int result = BSG_KSJSON_OK;

    // Decide if a comma is warranted.
    unlikely_if(context->containerFirstEntry) {
        context->containerFirstEntry = false;
    }
    else {
        unlikely_if((result = addJSONData(context, ",", 1)) != BSG_KSJSON_OK) {
            return result;
        }
    }

    // Pretty printing
    unlikely_if(context->prettyPrint && context->containerLevel > 0) {
        unlikely_if((result = addJSONData(context, "\n", 1)) != BSG_KSJSON_OK) {
            return result;
        }
        for (int i = 0; i < context->containerLevel; i++) {
            unlikely_if((result = addJSONData(context, "    ", 4)) !=
                        BSG_KSJSON_OK) {
                return result;
            }
        }
    }

    // Add a name field if we're in an object.
    if (context->isObject[context->containerLevel]) {
        unlikely_if(name == NULL) {
            BSG_KSLOG_ERROR("Name was null inside an object");
            return BSG_KSJSON_ERROR_INVALID_DATA;
        }
        unlikely_if((result = bsg_ksjsoncodec_i_addQuotedEscapedString(
                         context, name, strlen(name))) != BSG_KSJSON_OK) {
            return result;
        }
        unlikely_if(context->prettyPrint) {
            unlikely_if((result = addJSONData(context, ": ", 2)) !=
                        BSG_KSJSON_OK) {
                return result;
            }
        }
        else {
            unlikely_if((result = addJSONData(context, ":", 1)) !=
                        BSG_KSJSON_OK) {
                return result;
            }
        }
    }
    return result;
}

int bsg_ksjsonaddRawJSONData(BSG_KSJSONEncodeContext *const context,
                             const char *const data, const size_t length) {
    return addJSONData(context, data, length);
}

int bsg_ksjsonaddBooleanElement(BSG_KSJSONEncodeContext *const context,
                                const char *const name, const bool value) {
    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    if (value) {
        return addJSONData(context, "true", 4);
    } else {
        return addJSONData(context, "false", 5);
    }
}

int bsg_ksjsonaddFloatingPointElement(BSG_KSJSONEncodeContext *const context,
                                      const char *const name, double value) {
    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    char buff[30];
    sprintf(buff, "%lg", value);
    return addJSONData(context, buff, strlen(buff));
}

int bsg_ksjsonaddIntegerElement(BSG_KSJSONEncodeContext *const context,
                                const char *const name, long long value) {
    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    char buff[30];
    sprintf(buff, "%lld", value);
    return addJSONData(context, buff, strlen(buff));
}

int bsg_ksjsonaddJSONElement(BSG_KSJSONEncodeContext *const context,
                             const char *restrict const name,
                             const char *restrict const element,
                             size_t length) {
    unlikely_if(element == NULL) {
        return bsg_ksjsonaddNullElement(context, name);
    }
    size_t idx = 0;
    while (idx < length && (element[idx] == ' ' || element[idx] == '\r' ||
                            element[idx] == '\n' || element[idx] == '\t' ||
                            element[idx] == '\f')) {
        idx++;
    }
    unlikely_if(idx >= length) {
        BSG_KSLOG_ERROR("JSON element contained no JSON data: %s", element);
        return BSG_KSJSON_ERROR_INVALID_DATA;
    }
    switch (element[idx]) {
    case '[':
    case '{':
    case '\"':
    case 'f':
    case 't':
    case 'n':
    case '-':
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
        break;
    default:
        BSG_KSLOG_ERROR("Invalid character '%c' in: ", element[idx], element);
        return BSG_KSJSON_ERROR_INVALID_DATA;
    }

    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    return addJSONData(context, element, length);
}

int bsg_ksjsonaddNullElement(BSG_KSJSONEncodeContext *const context,
                             const char *const name) {
    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    return addJSONData(context, "null", 4);
}

int bsg_ksjsonaddStringElement(BSG_KSJSONEncodeContext *const context,
                               const char *const name, const char *const value,
                               size_t length) {
    unlikely_if(value == NULL) {
        return bsg_ksjsonaddNullElement(context, name);
    }
    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    if (length == BSG_KSJSON_SIZE_AUTOMATIC) {
        length = strlen(value);
    }
    return bsg_ksjsoncodec_i_addQuotedEscapedString(context, value, length);
}

int bsg_ksjsonbeginStringElement(BSG_KSJSONEncodeContext *const context,
                                 const char *const name) {
    int result = bsg_ksjsonbeginElement(context, name);
    unlikely_if(result != BSG_KSJSON_OK) { return result; }
    return addJSONData(context, "\"", 1);
}

int bsg_ksjsonappendStringElement(BSG_KSJSONEncodeContext *const context,
                                  const char *const value, size_t length) {
    return bsg_ksjsoncodec_i_addEscapedString(context, value, length);
}

int bsg_ksjsonendStringElement(BSG_KSJSONEncodeContext *const context) {
    return addJSONData(context, "\"", 1);
}

int bsg_ksjsonaddDataElement(BSG_KSJSONEncodeContext *const context,
                             const char *name, const char *value,
                             size_t length) {
    int result = BSG_KSJSON_OK;
    result = bsg_ksjsonbeginDataElement(context, name);
    if (result == BSG_KSJSON_OK) {
        result = bsg_ksjsonappendDataElement(context, value, length);
    }
    if (result == BSG_KSJSON_OK) {
        result = bsg_ksjsonendDataElement(context);
    }
    return result;
}

int bsg_ksjsonbeginDataElement(BSG_KSJSONEncodeContext *const context,
                               const char *const name) {
    return bsg_ksjsonbeginStringElement(context, name);
}

int bsg_ksjsonappendDataElement(BSG_KSJSONEncodeContext *const context,
                                const char *const value, size_t length) {
    unsigned char *currentByte = (unsigned char *)value;
    unsigned char *end = currentByte + length;
    char chars[2];
    int result = BSG_KSJSON_OK;
    while (currentByte < end) {
        chars[0] = bsg_g_hexNybbles[(*currentByte >> 4) & 15];
        chars[1] = bsg_g_hexNybbles[*currentByte & 15];
        result = addJSONData(context, chars, sizeof(chars));
        if (result != BSG_KSJSON_OK) {
            break;
        }
        currentByte++;
    }
    return result;
}

int bsg_ksjsonendDataElement(BSG_KSJSONEncodeContext *const context) {
    return bsg_ksjsonendStringElement(context);
}

int bsg_ksjsonbeginArray(BSG_KSJSONEncodeContext *const context,
                         const char *const name) {
    likely_if(context->containerLevel >= 0) {
        int result = bsg_ksjsonbeginElement(context, name);
        unlikely_if(result != BSG_KSJSON_OK) { return result; }
    }

    context->containerLevel++;
    context->isObject[context->containerLevel] = false;
    context->containerFirstEntry = true;

    return addJSONData(context, "[", 1);
}

int bsg_ksjsonbeginObject(BSG_KSJSONEncodeContext *const context,
                          const char *const name) {
    likely_if(context->containerLevel >= 0) {
        int result = bsg_ksjsonbeginElement(context, name);
        unlikely_if(result != BSG_KSJSON_OK) { return result; }
    }

    context->containerLevel++;
    context->isObject[context->containerLevel] = true;
    context->containerFirstEntry = true;

    return addJSONData(context, "{", 1);
}

int bsg_ksjsonendContainer(BSG_KSJSONEncodeContext *const context) {
    unlikely_if(context->containerLevel <= 0) { return BSG_KSJSON_OK; }

    bool isObject = context->isObject[context->containerLevel];
    context->containerLevel--;

    // Pretty printing
    unlikely_if(context->prettyPrint && !context->containerFirstEntry) {
        int result;
        unlikely_if((result = addJSONData(context, "\n", 1)) != BSG_KSJSON_OK) {
            return result;
        }
        for (int i = 0; i < context->containerLevel; i++) {
            unlikely_if((result = addJSONData(context, "    ", 4)) !=
                        BSG_KSJSON_OK) {
                return result;
            }
        }
    }
    context->containerFirstEntry = false;
    return addJSONData(context, isObject ? "}" : "]", 1);
}

void bsg_ksjsonbeginEncode(BSG_KSJSONEncodeContext *const context,
                           bool prettyPrint,
                           BSG_KSJSONAddDataFunc addJSONDataFunc,
                           void *const userData) {
    memset(context, 0, sizeof(*context));
    context->addJSONData = addJSONDataFunc;
    context->userData = userData;
    context->prettyPrint = prettyPrint;
    context->containerFirstEntry = true;
}

int bsg_ksjsonendEncode(BSG_KSJSONEncodeContext *const context) {
    int result = BSG_KSJSON_OK;
    while (context->containerLevel > 0) {
        unlikely_if((result = bsg_ksjsonendContainer(context)) !=
                    BSG_KSJSON_OK) {
            return result;
        }
    }
    return result;
}

// ============================================================================
#pragma mark - Decode -
// ============================================================================

#define INV 0x11111

/** Lookup table for converting hex values to integers.
 * INV (0x11111) is used to mark invalid characters so that any attempted
 * invalid nybble conversion is always > 0xffff.
 */
static const unsigned int bsg_g_hexConversion[] = {
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, INV, INV,
    INV, INV, INV, INV, INV, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV, INV,
    INV,
};

/** Encode a UTF-16 character to UTF-8. The dest pointer gets incremented
 * by however many bytes were needed for the conversion (1-4).
 *
 * @param character The UTF-16 character.
 *
 * @param dst Where to write the UTF-8 character.
 *
 * @return BSG_KSJSON_OK if the encoding was successful.
 */
int bsg_ksjsoncodec_i_writeUTF8(unsigned int character, char **dst);

/** Decode a string value. The newly allocated string is stored in dstString
 * (only if parsing was successful) and it is the responsibility of the caller
 * to free() it. Do not call free() on *dstString if parsing fails.
 *
 * @param ptr Pointer-to-pointer to the input data (will be modified).
 *
 * @param end Marks the end of the input data.
 *
 * @param dstString Stores the newly allocated string pointer (if successful).
 *                  If parsing fails, nothing is written here.
 *
 * @return BSG_KSJSON_OK if successful.
 */
int bsg_ksjsoncodec_i_decodeString(const char **ptr, const char *const end,
                                   char **dstString);

/** Decode a JSON element.
 *
 * @param ptr Pointer-to-pointer to the input data (will be modified).
 *
 * @param end Marks the end of the input data.
 *
 * @param name This element's name (or NULL if it has none).
 *
 * @param callbacks The callbacks to call while decoding.
 *
 * @param userData Data that was specified when calling bsg_ksjsondecode().
 *
 * @return BSG_KSJSON_OK if successful.
 */
int bsg_ksjsoncodec_i_decodeElement(const char **ptr, const char *const end,
                                    const char *const name,
                                    BSG_KSJSONDecodeCallbacks *const callbacks,
                                    void *const userData);

/** Skip past any whitespace.
 *
 * @param ptr pointer to the pointer to the characters. On exit, *ptr will
 *            point past any whitespace found.
 *
 * @param end Marks the end of the characters.
 */
static inline void skipWhitespace(const char **ptr, const char *const end) {
    while (*ptr < end && isspace(**ptr)) {
        (*ptr)++;
    }
}

/** Check if a character is valid for representing part of a floating point
 * number.
 *
 * @param ch The character to test.
 *
 * @return true if the character is valid for floating point.
 */
static inline bool isFPChar(char ch) {
    switch (ch) {
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
    case '.':
    case 'e':
    case 'E':
    case '+':
    case '-':
        return true;
    default:
        return false;
    }
}

int bsg_ksjsoncodec_i_writeUTF8(unsigned int character, char **dst) {
    likely_if(character <= 0x7f) {
        **dst = (char)character;
        (*dst)++;
        return BSG_KSJSON_OK;
    }
    if (character <= 0x7ff) {
        (*dst)[0] = (char)(0xc0 | (character >> 6));
        (*dst)[1] = (char)(0x80 | (character & 0x3f));
        *dst += 2;
        return BSG_KSJSON_OK;
    }
    if (character <= 0xffff) {
        (*dst)[0] = (char)(0xe0 | (character >> 12));
        (*dst)[1] = (char)(0x80 | ((character >> 6) & 0x3f));
        (*dst)[2] = (char)(0x80 | (character & 0x3f));
        *dst += 3;
        return BSG_KSJSON_OK;
    }
    // RFC3629 restricts UTF-8 to end at 0x10ffff.
    if (character <= 0x10ffff) {
        (*dst)[0] = (char)(0xf0 | (character >> 18));
        (*dst)[1] = (char)(0x80 | ((character >> 12) & 0x3f));
        (*dst)[2] = (char)(0x80 | ((character >> 6) & 0x3f));
        (*dst)[3] = (char)(0x80 | (character & 0x3f));
        *dst += 4;
        return BSG_KSJSON_OK;
    }

    // If we get here, the character cannot be converted to valid UTF-8.
    BSG_KSLOG_ERROR("Invalid unicode: 0x%04x", character);
    return BSG_KSJSON_ERROR_INVALID_CHARACTER;
}

int bsg_ksjsoncodec_i_decodeString(const char **ptr, const char *const end,
                                   char **dstString) {
    unlikely_if(**ptr != '\"') {
        BSG_KSLOG_ERROR("Expected '\"' but got '%c'", **ptr);
        return BSG_KSJSON_ERROR_INVALID_CHARACTER;
    }

    const char *src = *ptr + 1;
    bool fastCopy = true;

    for (; src < end && *src != '\"'; src++) {
        unlikely_if(*src == '\\') {
            fastCopy = false;
            src++;
        }
    }
    unlikely_if(src >= end) {
        BSG_KSLOG_ERROR("Premature end of data");
        return BSG_KSJSON_ERROR_INCOMPLETE;
    }
    const char *const srcEnd = src;
    src = *ptr + 1;
    size_t length = (size_t)(srcEnd - src);

    int result = BSG_KSJSON_OK;
    char *string = malloc(length + 1);

    // If no escape characters were encountered, we can fast copy.
    likely_if(fastCopy) {
        memcpy(string, src, length);
        string[length] = 0;
        *dstString = string;
        *ptr += length + 2;
        return BSG_KSJSON_OK;
    }

    char *dst = string;

    for (; src < srcEnd; src++) {
        likely_if(*src != '\\') { *dst++ = *src; }
        else {
            src++;
            switch (*src) {
            case '"':
                *dst++ = '\"';
                continue;
            case '\\':
                *dst++ = '\\';
                continue;
            case 'n':
                *dst++ = '\n';
                continue;
            case 'r':
                *dst++ = '\r';
                continue;
            case '/':
                *dst++ = '/';
                continue;
            case 't':
                *dst++ = '\t';
                continue;
            case 'b':
                *dst++ = '\b';
                continue;
            case 'f':
                *dst++ = '\f';
                continue;
            case 'u': {
                unlikely_if(src + 5 > srcEnd) {
                    BSG_KSLOG_ERROR("Premature end of data");
                    result = BSG_KSJSON_ERROR_INCOMPLETE;
                    goto failed;
                }
                unsigned int accum = bsg_g_hexConversion[src[1]] << 12 |
                                     bsg_g_hexConversion[src[2]] << 8 |
                                     bsg_g_hexConversion[src[3]] << 4 |
                                     bsg_g_hexConversion[src[4]];
                unlikely_if(accum > 0xffff) {
                    BSG_KSLOG_ERROR("Invalid unicode sequence: %c%c%c%c",
                                    src[1], src[2], src[3], src[4]);
                    result = BSG_KSJSON_ERROR_INVALID_CHARACTER;
                    goto failed;
                }

                // UTF-16 Trail surrogate on its own.
                unlikely_if(accum >= 0xdc00 && accum <= 0xdfff) {
                    BSG_KSLOG_ERROR("Unexpected trail surrogate: 0x%04x",
                                    accum);
                    result = BSG_KSJSON_ERROR_INVALID_CHARACTER;
                    goto failed;
                }

                // UTF-16 Lead surrogate.
                unlikely_if(accum >= 0xd800 && accum <= 0xdbff) {
                    // Fetch trail surrogate.
                    unlikely_if(src + 11 > srcEnd) {
                        BSG_KSLOG_ERROR("Premature end of data");
                        result = BSG_KSJSON_ERROR_INCOMPLETE;
                        goto failed;
                    }
                    unlikely_if(src[5] != '\\' || src[6] != 'u') {
                        BSG_KSLOG_ERROR("Expected \"\\u\" but got: \"%c%c\"",
                                        src[5], src[6]);
                        result = BSG_KSJSON_ERROR_INVALID_CHARACTER;
                        goto failed;
                    }
                    src += 6;
                    unsigned int accum2 = bsg_g_hexConversion[src[1]] << 12 |
                                          bsg_g_hexConversion[src[2]] << 8 |
                                          bsg_g_hexConversion[src[3]] << 4 |
                                          bsg_g_hexConversion[src[4]];
                    unlikely_if(accum2 < 0xdc00 || accum2 > 0xdfff) {
                        BSG_KSLOG_ERROR("Invalid trail surrogate: 0x%04x",
                                        accum2);
                        result = BSG_KSJSON_ERROR_INVALID_CHARACTER;
                        goto failed;
                    }
                    // And combine 20 bit result.
                    accum = ((accum - 0xd800) << 10) | (accum2 - 0xdc00);
                }

                result = bsg_ksjsoncodec_i_writeUTF8(accum, &dst);
                unlikely_if(result != BSG_KSJSON_OK) { goto failed; }
                src += 4;
                continue;
            }
            default:
                BSG_KSLOG_ERROR("Invalid control character '%c'", *src);
                result = BSG_KSJSON_ERROR_INVALID_CHARACTER;
                goto failed;
            }
        }
    }

    *dst = 0;
    *dstString = string;
    *ptr = src + 1;
    return BSG_KSJSON_OK;

failed:
    free(string);
    *ptr = src;
    return result;
}

int bsg_ksjsoncodec_i_decodeElement(const char **ptr, const char *const end,
                                    const char *const name,
                                    BSG_KSJSONDecodeCallbacks *const callbacks,
                                    void *const userData) {
    skipWhitespace(ptr, end);
    unlikely_if(*ptr >= end) {
        BSG_KSLOG_ERROR("Premature end of data");
        return BSG_KSJSON_ERROR_INCOMPLETE;
    }

    int sign = 1;
    int result;

    switch (**ptr) {
    case '[': {
        (*ptr)++;
        result = callbacks->onBeginArray(name, userData);
        unlikely_if(result != BSG_KSJSON_OK) return result;
        while (*ptr < end) {
            skipWhitespace(ptr, end);
            unlikely_if(*ptr >= end) { break; }
            unlikely_if(**ptr == ']') {
                (*ptr)++;
                return callbacks->onEndContainer(userData);
            }
            result = bsg_ksjsoncodec_i_decodeElement(ptr, end, NULL, callbacks,
                                                     userData);
            unlikely_if(result != BSG_KSJSON_OK) return result;
            skipWhitespace(ptr, end);
            unlikely_if(*ptr >= end) { break; }
            likely_if(**ptr == ',') { (*ptr)++; }
        }
        BSG_KSLOG_ERROR("Premature end of data");
        return BSG_KSJSON_ERROR_INCOMPLETE;
    }
    case '{': {
        (*ptr)++;
        result = callbacks->onBeginObject(name, userData);
        unlikely_if(result != BSG_KSJSON_OK) return result;
        while (*ptr < end) {
            skipWhitespace(ptr, end);
            unlikely_if(*ptr >= end) { break; }
            unlikely_if(**ptr == '}') {
                (*ptr)++;
                return callbacks->onEndContainer(userData);
            }
            char *key;
            result = bsg_ksjsoncodec_i_decodeString(ptr, end, &key);
            unlikely_if(result != BSG_KSJSON_OK) return result;
            skipWhitespace(ptr, end);
            unlikely_if(*ptr >= end) {
                free(key);
                break;
            }
            unlikely_if(**ptr != ':') {
                free(key);
                BSG_KSLOG_ERROR("Expected ':' but got '%c'", **ptr);
                return BSG_KSJSON_ERROR_INVALID_CHARACTER;
            }
            (*ptr)++;
            skipWhitespace(ptr, end);
            result = bsg_ksjsoncodec_i_decodeElement(ptr, end, key, callbacks,
                                                     userData);
            free(key);
            unlikely_if(result != BSG_KSJSON_OK) return result;
            skipWhitespace(ptr, end);
            unlikely_if(*ptr >= end) { break; }
            likely_if(**ptr == ',') { (*ptr)++; }
        }
        BSG_KSLOG_ERROR("Premature end of data");
        return BSG_KSJSON_ERROR_INCOMPLETE;
    }
    case '\"': {
        char *string;
        result = bsg_ksjsoncodec_i_decodeString(ptr, end, &string);
        unlikely_if(result != BSG_KSJSON_OK) return result;
        result = callbacks->onStringElement(name, string, userData);
        free(string);
        return result;
    }
    case 'f': {
        unlikely_if(end - *ptr < 5) {
            BSG_KSLOG_ERROR("Premature end of data");
            return BSG_KSJSON_ERROR_INCOMPLETE;
        }
        unlikely_if(!((*ptr)[1] == 'a' && (*ptr)[2] == 'l' &&
                      (*ptr)[3] == 's' && (*ptr)[4] == 'e')) {
            BSG_KSLOG_ERROR("Expected \"false\" but got \"f%c%c%c%c\"",
                            (*ptr)[1], (*ptr)[2], (*ptr)[3], (*ptr)[4]);
            return BSG_KSJSON_ERROR_INVALID_CHARACTER;
        }
        *ptr += 5;
        return callbacks->onBooleanElement(name, false, userData);
    }
    case 't': {
        unlikely_if(end - *ptr < 4) {
            BSG_KSLOG_ERROR("Premature end of data");
            return BSG_KSJSON_ERROR_INCOMPLETE;
        }
        unlikely_if(
            !((*ptr)[1] == 'r' && (*ptr)[2] == 'u' && (*ptr)[3] == 'e')) {
            BSG_KSLOG_ERROR("Expected \"true\" but got \"t%c%c%c\"", (*ptr)[1],
                            (*ptr)[2], (*ptr)[3]);
            return BSG_KSJSON_ERROR_INVALID_CHARACTER;
        }
        *ptr += 4;
        return callbacks->onBooleanElement(name, true, userData);
    }
    case 'n': {
        unlikely_if(end - *ptr < 4) {
            BSG_KSLOG_ERROR("Premature end of data");
            return BSG_KSJSON_ERROR_INCOMPLETE;
        }
        unlikely_if(
            !((*ptr)[1] == 'u' && (*ptr)[2] == 'l' && (*ptr)[3] == 'l')) {
            BSG_KSLOG_ERROR("Expected \"null\" but got \"n%c%c%c\"", (*ptr)[1],
                            (*ptr)[2], (*ptr)[3]);
            return BSG_KSJSON_ERROR_INVALID_CHARACTER;
        }
        *ptr += 4;
        return callbacks->onNullElement(name, userData);
    }
    case '-':
        sign = -1;
        (*ptr)++;
        unlikely_if(!isdigit(**ptr)) {
            BSG_KSLOG_ERROR("Not a digit: '%c'", **ptr);
            return BSG_KSJSON_ERROR_INVALID_CHARACTER;
        }
    // Fall through
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9': {
        // Try integer conversion.
        long long accum = 0;
        const char *const start = *ptr;

        for (; *ptr < end && isdigit(**ptr); (*ptr)++) {
            accum = accum * 10 + (**ptr - '0');
            unlikely_if(accum < 0) {
                // Overflow
                break;
            }
        }

        unlikely_if(*ptr >= end) {
            BSG_KSLOG_ERROR("Premature end of data");
            return BSG_KSJSON_ERROR_INCOMPLETE;
        }

        if (!isFPChar(**ptr) && accum >= 0) {
            if (name == NULL) {
                return BSG_KSJSON_ERROR_INCOMPLETE;
            }
            accum *= sign;
            return callbacks->onIntegerElement(name, accum, userData);
        }

        while (*ptr < end && isFPChar(**ptr)) {
            (*ptr)++;
        }

        unlikely_if(*ptr >= end) {
            BSG_KSLOG_ERROR("Premature end of data");
            return BSG_KSJSON_ERROR_INCOMPLETE;
        }

        // our buffer is not necessarily NULL-terminated, so
        // it would be undefined to call sscanf/sttod etc. directly.
        // instead we create a temporary string.
        double value;
        size_t len = (size_t)(*ptr - start);
        char *buf = malloc(len + 1);
        strncpy(buf, start, len);
        buf[len] = '\0';

        sscanf(buf, "%lg", &value);

        free(buf);

        value *= sign;
        return callbacks->onFloatingPointElement(name, value, userData);
    }
    }
    BSG_KSLOG_ERROR("Invalid character '%c'", **ptr);
    return BSG_KSJSON_ERROR_INVALID_CHARACTER;
}

int bsg_ksjsondecode(const char *const data, size_t length,
                     BSG_KSJSONDecodeCallbacks *const callbacks,
                     void *const userData, size_t *const errorOffset) {
    const char *ptr = data;

    int result = bsg_ksjsoncodec_i_decodeElement(&ptr, ptr + length, NULL,
                                                 callbacks, userData);
    likely_if(result == BSG_KSJSON_OK) {
        result = callbacks->onEndData(userData);
    }

    unlikely_if(result != BSG_KSJSON_OK && errorOffset != NULL) {
        *errorOffset = (size_t)(ptr - data);
    }
    return result;
}
