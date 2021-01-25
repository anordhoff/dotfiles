#!/bin/bash

# to run at startup, execute:
# sudo defaults write com.apple.loginwindow LoginHook `pwd`/options.sh

# capslock -> backspace
# right-option -> right-command
# right-control -> right-option
hidutil property --set '{"UserKeyMapping":[
        {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x70000002A},
        {"HIDKeyboardModifierMappingSrc":0x7000000e6, "HIDKeyboardModifierMappingDst":0x7000000e7},
        {"HIDKeyboardModifierMappingSrc":0x7000000e4, "HIDKeyboardModifierMappingDst":0x7000000e6}
]}'
