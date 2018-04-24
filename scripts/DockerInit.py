#! /usr/bin/python3

import sys, os

name = "Default"
SHEBANG_BASH = "#!/bin/bash"

def __handleArgs():
    howManyArgs = len(sys.argv)
    print("{} argument(s) passed".format(howManyArgs))
    if howManyArgs == 1:
        return False
    global name
    name = sys.argv[1]
    return True

def __buildScript(name,proxy=True):
    os.chdir(name)
    script = open('build.sh', 'w')
    script.write(SHEBANG_BASH + "\n")
    command = "docker build"
    if proxy:
        command += "--build-arg http_proxy=" + os.environ['PROXY'] + " --build-arg http_proxy=" + os.environ['PROXY']
    command += " -t " + name
    script.write(command)
    script.close()

def __setupDirs():
    global name
    dirs = os.listdir()
    if name not in dirs:
        os.mkdir(name)

def __main__():
    global name
    if __handleArgs():
        print("Correctly read {} as name...".format(name))
        __setupDirs()
        __buildScript(name)
    else:
        print("No name passed. Exiting now...")

__main__()