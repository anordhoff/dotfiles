// base layer overrides
const key_override_t colemak_comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_DOT, 1 << _COLEMAK);
const key_override_t game_comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_DOT, 1 << _GAME);
const key_override_t game_lessthan_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LT, KC_GT, 1 << _GAME);

// symbol layer overrides
const key_override_t symbol_layer_grave_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_GRV, KC_GRV, 1 << _SYMBOL);
const key_override_t symbol_layer_equal_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_EQL, KC_EQL, 1 << _SYMBOL);
const key_override_t symbol_layer_left_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LBRC, KC_LBRC, 1 << _SYMBOL);
const key_override_t symbol_layer_right_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RBRC, KC_RBRC, 1 << _SYMBOL);
const key_override_t symbol_layer_backslash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSLS, KC_BSLS, 1 << _SYMBOL);

// numpad layer overrides
const key_override_t numpad_layer_zero_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_0, KC_0, 1 << _NUMPAD);
const key_override_t numpad_layer_one_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_1, KC_1, 1 << _NUMPAD);
const key_override_t numpad_layer_two_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_2, KC_2, 1 << _NUMPAD);
const key_override_t numpad_layer_three_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_3, KC_3, 1 << _NUMPAD);
const key_override_t numpad_layer_four_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_4, KC_4, 1 << _NUMPAD);
const key_override_t numpad_layer_five_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_5, KC_5, 1 << _NUMPAD);
const key_override_t numpad_layer_six_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_6, KC_6, 1 << _NUMPAD);
const key_override_t numpad_layer_seven_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_7, KC_7, 1 << _NUMPAD);
const key_override_t numpad_layer_eight_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_8, KC_8, 1 << _NUMPAD);
const key_override_t numpad_layer_nine_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_9, KC_9, 1 << _NUMPAD);
const key_override_t numpad_layer_comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_COMM, 1 << _NUMPAD);
const key_override_t numpad_layer_dot_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_DOT, KC_DOT, 1 << _NUMPAD);
const key_override_t numpad_layer_slash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SLSH, KC_SLSH, 1 << _NUMPAD);

// globally define all key overrides
const key_override_t *key_overrides[] = {

	// base layers
	&colemak_comma_key_override,
	&game_comma_key_override,
	&game_lessthan_key_override,

	// symbol layer overrides
	&symbol_layer_grave_key_override,
	&symbol_layer_equal_key_override,
	&symbol_layer_left_bracket_key_override,
	&symbol_layer_right_bracket_key_override,
	&symbol_layer_backslash_key_override,

	// numpad layer overrides
	&numpad_layer_zero_key_override,
	&numpad_layer_one_key_override,
	&numpad_layer_two_key_override,
	&numpad_layer_three_key_override,
	&numpad_layer_four_key_override,
	&numpad_layer_five_key_override,
	&numpad_layer_six_key_override,
	&numpad_layer_seven_key_override,
	&numpad_layer_eight_key_override,
	&numpad_layer_nine_key_override,
	&numpad_layer_comma_key_override,
	&numpad_layer_dot_key_override,
	&numpad_layer_slash_key_override,
};
