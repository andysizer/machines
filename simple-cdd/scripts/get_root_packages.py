#!/usr/bin/env python3
#coding: utf-8

import os
import logging
import shlex
import io
import curses
import glob
from simple_cdd.env import Environment
from simple_cdd.variables import VARIABLES
from simple_cdd_base_packages import SIMPLE_CDD_BASE_PACKAGES


def get_installed_packages():
    packages = set()
    dpkg_list_pipe = os.popen("apt list")
    dpkg_list_lines = dpkg_list_pipe.readlines()
    dpkg_list_pipe.close()

    # skip first line ('Listing..')
    for l in dpkg_list_lines[1:]:
        pkg = l[0:l.index("/")]
        packages.add(pkg)

    return packages

def get_implicit_packages(installed_packages):
    implicit_packages = set(SIMPLE_CDD_BASE_PACKAGES)

    for e in installed_packages:
        print("checking %s" % e)
        depends_cmd = "apt-cache --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances depends %s"
        apt_cache_depends_pipe = os.popen(depends_cmd % e)
        apt_cache_depends_lines = apt_cache_depends_pipe.readlines()
        apt_cache_depends_pipe.close()
        for l in apt_cache_depends_lines[1:]:
            l = l.strip()
            #print("1. line = %s" % l)
            token1 = "Depends: "
            token2 = "|Depends: "
            token3 = "PreDepends: "
            token = ""
            
            if l.startswith(token1):
                token = token1
            elif l.startswith(token2):
                token = token2
            elif l.startswith(token3):
                token = token3

            dependee = ""
    
            if token:
                dependee = l[len(token):].rstrip()
                #print("2. dependee = %s line = %s" % (dependee, l))
                if dependee.startswith("<"):
                    dependee = dependee[1:-1]
                    #print("3. dependee = %s line = %s" % (dependee, l))
                    if ":" in dependee:
                        dependee = dependee[:dependee.index(":")]
                        #print("4. dependee = %s line = %s" % (dependee, l))

            else:
                dependee = l.strip()
                #print("5. dependee = %s line = %s" % (dependee, l))

            print("dependee = %s line = %s" % (dependee, l))
            implicit_packages.add(dependee)
    return implicit_packages

installed_packages = get_installed_packages()
implicit_packages = get_implicit_packages(installed_packages)
explicit_packages = installed_packages.difference(implicit_packages)

print("#implicit packages = %d" % len(implicit_packages))
print("#explicit packages = %d" % len(explicit_packages))
