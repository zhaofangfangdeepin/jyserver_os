#!/usr/bin/env python
# -*- coding:utf-8 -*-
import os
import sys

def mkdir(dir,depth):
    if  os.path.isdir(dir):
        os.chdir(dir)
        if os.path.isdir('1'):
            os.system('rm -rf 1')
    else :
        os.mkdir(dir)
        os.chdir(dir)
    for i in range(1,int(depth)):
        os.mkdir(str(i))
        os.chdir(str(i))
    os.chdir(dir)

def check_dir(dir):
    OK=True
    n=1
    while OK:
        try:
            os.chdir(str(n))
            n+=1
        except:
            OK=False
    return n;

if __name__ == '__main__':
    mkdir(os.getcwd(),sys.argv[1])
    if check_dir(os.getcwd()) == int(sys.argv[1]):
        print("Test PASS!\n")
    else :
        print("Test FAIL!\n")
