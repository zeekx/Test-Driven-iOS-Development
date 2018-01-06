#!/usr/bin/env python
# -*- coding:utf-8 -*-

import argparse
import subprocess
import os

#configuration for iOS test setting
def test():
        scheme = 'BrowseOverflow'
        destination = 'platform=iOS Simulator,name=iPad Air 2,OS=11.2'
        _test('11.2')

def _test(iOSVersion):
        testCommand = 'xcodebuild -workspace BrowseOverflow.xcworkspace -scheme BrowseOverflow -destination \'platform=iOS Simulator,name=iPad Air 2,OS=%s\' -configuration Debug test' %(iOSVersion)
        process = subprocess.Popen(testCommand, shell=True)
        process.wait()


def main():
        test()

if __name__ == '__main__':
        main()
