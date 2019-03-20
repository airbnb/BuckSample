// Created by Michael Bachand on 3/20/19.
// 

#ifndef PMKCallVariadicBlock_h
#define PMKCallVariadicBlock_h

@interface PMKArray : NSObject {
@public
  id objs[3];
  NSUInteger count;
} @end

id PMKCallVariadicBlock(id frock, id result);

#endif /* PMKCallVariadicBlock_h */
