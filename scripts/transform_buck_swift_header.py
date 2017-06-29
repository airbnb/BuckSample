#!/usr/bin/python

import os
import sys
import tempfile

from shutil import copyfile

if len(sys.argv) <= 1:
  print "usage transform_buck_swift_header.py file"
  exit(-1)

input_file = sys.argv[1]
file_basename = os.path.basename(input_file)

tmp_file = tempfile.NamedTemporaryFile(delete=True)

def convert_import(row):
  INTENRAL_MODULE = [
    'Airbnb',
  ]

  # get library name
  lib = row.split()[1][:-1]
  for module in INTENRAL_MODULE:
    if module not in lib:
      continue
    return '#import <%s/%s-Swift.h>\n' % (lib, lib)
  return row

def getReplaceRow(file_name, row):
  if '@import' in row:
    return convert_import(row)
  return row

with open(input_file) as fin:
  with open(tmp_file.name, 'w') as fout:
    for row in fin.readlines():
      row = getReplaceRow(file_basename, row)
      if row:
        print >> fout, row,

copyfile(tmp_file.name, input_file)
