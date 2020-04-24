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

dpkg_list_pipe = os.popen("apt list")
dpkg_list_lines = dpkg_list_pipe.readlines()
dpkg_list_pipe.close()

non_roots = set(SIMPLE_CDD_BASE_PACKAGES)
installed_packages = set()

# skip first line ('Listing..')
for l in dpkg_list_lines[1:]:
    pkg = l[0:l.index("/")]
    installed_packages.add(pkg)

for e in installed_packages:
    print("checking %s" % e)
    depends_cmd = "apt-cache --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances depends %s"
    apt_cache_depends_pipe = os.popen(depends_cmd % e)
    apt_cache_depends_lines = apt_cache_depends_pipe.readlines()
    apt_cache_depends_pipe.close()
    for l in apt_cache_depends_lines[1:]:
        print(l)
        token1 = "  Depends: "
        token2 = " |Depends: "
        dependee = ""
        if l.startswith(token1) or l.startswith(token2): 
            dependee = l[len(token1):].rstrip()
            if dependee.startswith("<"):
                dependee = dependee[1:-1]
        else:
            print("!!! %s" % l)
            dependee = l.strip()

        print(dependee)

