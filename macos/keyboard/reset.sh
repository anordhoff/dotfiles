#!/bin/bash

# reset keyboard mappings to default values
hidutil property --set '{"UserKeyMapping":[
        {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x700000039},
        {"HIDKeyboardModifierMappingSrc":0x700000035, "HIDKeyboardModifierMappingDst":0x700000035},
        {"HIDKeyboardModifierMappingSrc":0x7000000e0, "HIDKeyboardModifierMappingDst":0x7000000e0},
        {"HIDKeyboardModifierMappingSrc":0x7000000e3, "HIDKeyboardModifierMappingDst":0x7000000e3},
        {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e7},
        {"HIDKeyboardModifierMappingSrc":0x7000000e6, "HIDKeyboardModifierMappingDst":0x7000000e6}
]}'
