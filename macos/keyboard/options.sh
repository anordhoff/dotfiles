#!/bin/bash

# to run at startup, execute:
# sudo defaults write com.apple.loginwindow LoginHook `pwd`/options.sh

# map caps lock to backspace,
# ...tilde to escape;
# swap left-control and left-command,
# ...right-command and right-option
hidutil property --set '{"UserKeyMapping":[
        {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x70000002A},
        {"HIDKeyboardModifierMappingSrc":0x700000035, "HIDKeyboardModifierMappingDst":0x700000029},
        {"HIDKeyboardModifierMappingSrc":0x7000000e0, "HIDKeyboardModifierMappingDst":0x7000000e3},
        {"HIDKeyboardModifierMappingSrc":0x7000000e3, "HIDKeyboardModifierMappingDst":0x7000000e0},
        {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e6},
        {"HIDKeyboardModifierMappingSrc":0x7000000e6, "HIDKeyboardModifierMappingDst":0x7000000e7}
]}'
