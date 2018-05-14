#!/usr/bin/env python3

import sys
import shutil

param1 = ''
param2 = ''

if len(sys.argv) > 1:
    param1 = sys.argv[1]

if len(sys.argv) > 2:
    param2 = sys.argv[2]

if param1 == '--list':
    with open("inventory.json", "r") as f:
        shutil.copyfileobj(f, sys.stdout)

elif param1 == '--host':
    if param2:
        print ("{}")
    else:
        print("Specify name of the host.")

else:
    print("--list - show inventory")
    print("--host %hostname% - show host vars for specific host")
