from subprocess import check_call
import sys

BUILD_NAME = sys.argv[1]

if BUILD_NAME == "ACCEPTANCE":
    check_call('python run.py', shell=True)
else:
    raise ValueError(BUILD_NAME)
