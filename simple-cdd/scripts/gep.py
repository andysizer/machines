#!/usr/bin/env python3
#coding: utf-8

# Simple script to get a (close) approximation of manually installed packages in the current system for use
# by simple-cdd.

import os

def get_packages(cmd):
    packages = set()
    pipe = os.popen(cmd)
    lines = pipe.readlines()
    pipe.close()

    for l in lines:
        packages.add(l.strip())

    return packages

def get_installed_packages():
    cmd = "aptitude search '?installed' | cut -d ' ' -f 3"
    return get_packages(cmd)

def get_automatic_packages():
    cmd = "aptitude search '?automatic' | cut -d ' ' -f 3"
    return get_packages(cmd)


def get_available_packages():
    cmd = "apt-cache dumpavail | grep Package: | cut -d ' ' -f 2"
    return get_packages(cmd)

installed_packages = get_installed_packages()
available_packages = get_available_packages()
automatic_packages = get_automatic_packages()
required_packages = installed_packages - automatic_packages
missing_packages = required_packages - available_packages
extra_packages = required_packages - missing_packages

print("#")
print("# Output from machine/simple-cdd/scripts/gep.py.")
print("#")
print("# installed_packages = %d" % len(installed_packages))
print("# required_packages = %d" % len(required_packages))
print("# automatic_packages = %d" % len(automatic_packages))
print("# extra_packages = %d" % len(extra_packages))
print("# missing_packages = %d" % len(missing_packages))

print("\n############## REQUIRED ################################\n")
for p in sorted(required_packages):
    print("%s" % p)

print("\n############## AUTOMATIC ################################\n")
for p in sorted(automatic_packages):
    print("%s" % p)

print("\n############# EXTRAS #################################\n")
for p in sorted(extra_packages):
    print("%s" % p)

print("\n################### MISSING ###########################\n")
for m in sorted(missing_packages):
    p = m.strip()
    print("# %s" % m)


