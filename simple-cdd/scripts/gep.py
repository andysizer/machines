

import os
from simple_cdd_base_packages import SIMPLE_CDD_DEFAULT_PACKAGES

def get_packages(cmd):
    packages = set()
    cmd = "dpkg -l | grep -e '^ii' | cut -d ' ' -f 3 | cut -d ':' -f 1 | sort | uniq -u"
    pipe = os.popen(cmd)
    lines = pipe.readlines()
    pipe.close()

    for pkg in lines:
        packages.add(pkg.strip())

    return packages

def get_installed_packages():
    cmd = "dpkg -l | grep -e '^ii' | cut -d ' ' -f 3 | cut -d ':' -f 1 | sort | uniq -u"
    return get_packages(cmd)

def get_default_packages():
    return set(SIMPLE_CDD_DEFAULT_PACKAGES)

def get_dependee_packages():
    cmd = "apt-cache dump | grep Depends: | cut -d ' ' -f 4 | sort | uniq -u"
    return get_packages(cmd)

def get_available_packages():
    cmd = "apt-cache dumpavail | grep Package: | cut -d ' ' -f 2"
    return get_packages(cmd)

def get_root_packages(i , d):
    root_packages = set()
    for p in i:
        if not p in d:
            root_packages.add(p)
    return root_packages   

installed_packages = get_installed_packages()
default_packages = get_default_packages()
available_packages = get_available_packages()
required_packages = installed_packages - default_packages
dependee_packages = get_dependee_packages()
root_packages = get_root_packages(required_packages, dependee_packages)
#common_packages = installed_packages.intersection(default_packages)
#missing = default_packages - common_packages
missing_packages = root_packages - available_packages
extra_packages = root_packages - missing_packages

print("#")
print("# Output from machine/simple-cdd/scripts/gep.py.")
print("#")
print("#installed_packages = %d" % len(installed_packages))
print("#default_packages = %d" % len(default_packages))
print("#required_packages = %d" % len(required_packages))
print("#dependee_packages = %d" % len(dependee_packages))
print("#root_packages = %d" % len(root_packages))
#print("#common_packages = %d" % len(common_packages))
#print("#missing = %d" % len(missing))
print("#extra_packages = %d" % len(extra_packages))
print("#missing_packages = %d" % len(missing_packages))
print("##############################################\n\n")

for p in sorted(extra_packages):
    print("%s" % p)

print("\n##############################################\n\n")

for p in sorted(missing_packages):
    print("#%s" % p)

