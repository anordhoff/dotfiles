// base layer overrides
const key_override_t colemak_comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_DOT, 1 << _COLEMAK);
const key_override_t colemak_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _COLEMAK);
const key_override_t game_comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_DOT, 1 << _GAME);
const key_override_t game_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _GAME);

// layer_r overrides
const key_override_t layer_r_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _LAYER_R);

// layer_s overrides
const key_override_t layer_s_left_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LBRC, KC_LBRC, 1 << _LAYER_S);
const key_override_t layer_s_right_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RBRC, KC_RBRC, 1 << _LAYER_S);
const key_override_t layer_s_backslash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSLS, KC_BSLS, 1 << _LAYER_S);
const key_override_t layer_s_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _LAYER_S);

// layer_t overrides
const key_override_t layer_t_grave_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_GRV, KC_GRV, 1 << _LAYER_T);
const key_override_t layer_t_slash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SLSH, KC_SLSH, 1 << _LAYER_T);
const key_override_t layer_t_semicolon_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SCLN, KC_SCLN, 1 << _LAYER_T);
const key_override_t layer_t_equal_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_EQL, KC_EQL, 1 << _LAYER_T);
const key_override_t layer_t_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _LAYER_T);

// layer_n overrides
const key_override_t layer_n_zero_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_0, KC_0, 1 << _LAYER_N);
const key_override_t layer_n_one_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_1, KC_1, 1 << _LAYER_N);
const key_override_t layer_n_two_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_2, KC_2, 1 << _LAYER_N);
const key_override_t layer_n_three_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_3, KC_3, 1 << _LAYER_N);
const key_override_t layer_n_four_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_4, KC_4, 1 << _LAYER_N);
const key_override_t layer_n_five_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_5, KC_5, 1 << _LAYER_N);
const key_override_t layer_n_six_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_6, KC_6, 1 << _LAYER_N);
const key_override_t layer_n_seven_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_7, KC_7, 1 << _LAYER_N);
const key_override_t layer_n_eight_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_8, KC_8, 1 << _LAYER_N);
const key_override_t layer_n_nine_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_9, KC_9, 1 << _LAYER_N);
const key_override_t layer_n_comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_COMM, 1 << _LAYER_N);
const key_override_t layer_n_dot_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_DOT, KC_DOT, 1 << _LAYER_N);
const key_override_t layer_n_slash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SLSH, KC_SLSH, 1 << _LAYER_N);
const key_override_t layer_n_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _LAYER_N);

// layer_e overrides
const key_override_t layer_e_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _LAYER_E);

// layer_i overrides
const key_override_t layer_i_backspace_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_COLN, 1 << _LAYER_I);

// globally define all key overrides to be used
const key_override_t *key_overrides[] = {

	// base layers
	&colemak_comma_key_override,
	&colemak_backspace_key_override,
	&game_comma_key_override,
	&game_backspace_key_override,

	// layer_r
	&layer_r_backspace_key_override,

	// layer_s
	&layer_s_left_bracket_key_override,
	&layer_s_right_bracket_key_override,
	&layer_s_backslash_key_override,
	&layer_s_backspace_key_override,

	// layer_t
	&layer_t_grave_key_override,
	&layer_t_slash_key_override,
	&layer_t_semicolon_key_override,
	&layer_t_equal_key_override,
	&layer_t_backspace_key_override,

	// layer_n
	&layer_n_zero_key_override,
	&layer_n_one_key_override,
	&layer_n_two_key_override,
	&layer_n_three_key_override,
	&layer_n_four_key_override,
	&layer_n_five_key_override,
	&layer_n_six_key_override,
	&layer_n_seven_key_override,
	&layer_n_eight_key_override,
	&layer_n_nine_key_override,
	&layer_n_comma_key_override,
	&layer_n_dot_key_override,
	&layer_n_slash_key_override,
	&layer_n_backspace_key_override,

	// layer_e
	&layer_e_backspace_key_override,

	// layer_i
	&layer_i_backspace_key_override
};
