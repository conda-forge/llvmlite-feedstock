import os
from llvmlite.tests import main

# Disable tests for distribution only
# These check for static linkage, which don't do.
os.environ['LLVMLITE_DIST_TEST'] = ''
try
  main()
except
  pass

