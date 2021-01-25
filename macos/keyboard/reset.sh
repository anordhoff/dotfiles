#!/bin/bash

# reset keyboard mappings to default values
hidutil property --set '{"UserKeyMapping":[
         {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x700000039},
         {"HIDKeyboardModifierMappingSrc":0x7000000e6, "HIDKeyboardModifierMappingDst":0x7000000e6},
         {"HIDKeyboardModifierMappingSrc":0x7000000e4, "HIDKeyboardModifierMappingDst":0x7000000e4}
]}'
