#!/usr/bin/env python3

# if multiple screens are connected
# set the biggest as primary screen and disable all others

import os
import re
import sys

MODE_RESOLUTION = '2560x1440'

xrandrOutput = os.popen('xrandr').read()
if xrandrOutput.count(' connected') == 1:
  exit

# find connected monitors with resolution
resolutions = [ (index, size) for index, size in enumerate(re.findall("^.*?(\d+x\d+).*\*.*$", xrandrOutput, re.MULTILINE))]
biggest = sorted(resolutions, key=lambda indexSize: int(indexSize[1].split('x')[0]), reverse=True)[0]
outputNames = re.findall('^(.*)? connected', xrandrOutput, re.MULTILINE)

command = ''
for outputName in outputNames:
  if outputName is outputNames[biggest[0]]:
    command += f' --output {outputName} --primary --mode {MODE_RESOLUTION}'
  else:
    command += f' --output {outputName} --off'

os.system(f'xrandr {command}')
