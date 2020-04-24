import os
from simple_cdd_base_packages import SIMPLE_CDD_DEFAULT_PACKAGES


def get_installed_packages():
    packages = set()
    cmd = "dpkg -l | grep -e '^ii' | cut -d ' ' -f 3 | cut -d ':' -f 1 | sort | uniq -u"
    dpkg_list_pipe = os.popen(cmd)
    dpkg_list_lines = dpkg_list_pipe.readlines()
    dpkg_list_pipe.close()

    for pkg in dpkg_list_lines:
        packages.add(pkg.strip())

    return packages

def get_default_packages():
    return set(SIMPLE_CDD_DEFAULT_PACKAGES)

def get_required_packages(i , d):
    required_packages = set()
    for p in i:
        if not p in d:
            required_packages.add(p)
    return required_packages


installed_packages = get_installed_packages()
default_packages = get_default_packages()
required_packages = installed_packages - default_packages
common_packages = installed_packages.intersection(default_packages)
missing = default_packages - common_packages


print("#installed_packages = %d" % len(installed_packages))
print("#default_packages = %d" % len(default_packages))
print("#required_packages = %d" % len(required_packages))
print("#common_packages = %d" % len(common_packages))
print("#missing = %d" % len(missing))
