#include "anordhoff.h"

// toggle right shift between KC_SLSH and KC_UP
bool kc_up_toggled = false;
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case QWERTY: case COLEMAK: case GAME:
			if (record->event.pressed) {
				kc_up_toggled = false;
			}
			return true;
		case TOG_SUP:
			if (record->event.pressed) {
				kc_up_toggled = !kc_up_toggled;
			}
			return true;
		case SLSH_UP:
			if (kc_up_toggled) {
				if (record->event.pressed) {
					register_code(KC_UP);
				} else {
					unregister_code(KC_UP);
				}
			} else {
				if (record->event.pressed) {
					register_code(KC_SLSH);
				} else {
					unregister_code(KC_SLSH);
				}
			}
			return true;
		default:
			return true;
	}
}

// per key tapping term value
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_Z:
		case MT_A:
		case MT_R:
    case MT_I:
    case MT_O:
      return 220;
    case MT_SPC:
      return 160;
		default:
			return TAPPING_TERM;
	}
};

// layer_s overrides
const key_override_t left_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LBRC, KC_LBRC, 1 << _LAYER_S);
const key_override_t right_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RBRC, KC_RBRC, 1 << _LAYER_S);
const key_override_t backslash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSLS, KC_BSLS, 1 << _LAYER_S);

// layer_t overrides
const key_override_t minus_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_MINS, KC_MINS, 1 << _LAYER_T);
const key_override_t semicolon_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SCLN, KC_SCLN, 1 << _LAYER_T);
const key_override_t equal_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_EQL, KC_EQL, 1 << _LAYER_T);
const key_override_t grave_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_GRV, KC_GRV, 1 << _LAYER_T);

// layer_n overrides
const key_override_t zero_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_0, KC_0, 1 << _LAYER_N);
const key_override_t one_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_1, KC_1, 1 << _LAYER_N);
const key_override_t two_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_2, KC_2, 1 << _LAYER_N);
const key_override_t three_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_3, KC_3, 1 << _LAYER_N);
const key_override_t four_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_4, KC_4, 1 << _LAYER_N);
const key_override_t five_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_5, KC_5, 1 << _LAYER_N);
const key_override_t six_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_6, KC_6, 1 << _LAYER_N);
const key_override_t seven_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_7, KC_7, 1 << _LAYER_N);
const key_override_t eight_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_8, KC_8, 1 << _LAYER_N);
const key_override_t nine_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_9, KC_9, 1 << _LAYER_N);
const key_override_t comma_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COMM, KC_COMM, 1 << _LAYER_N);
const key_override_t dot_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_DOT, KC_DOT, 1 << _LAYER_N);
const key_override_t slash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SLSH, KC_SLSH, 1 << _LAYER_N);

// globally define all key overrides to be used
const key_override_t **key_overrides = (const key_override_t *[]){

	// layer_s
	&left_bracket_key_override,
	&right_bracket_key_override,
	&backslash_key_override,

	// layer_t
	&minus_key_override,
	&semicolon_key_override,
	&equal_key_override,
	&grave_key_override,

	// layer_n
	&zero_key_override,
	&one_key_override,
	&two_key_override,
	&three_key_override,
	&four_key_override,
	&five_key_override,
	&six_key_override,
	&seven_key_override,
	&eight_key_override,
	&nine_key_override,
	&comma_key_override,
	&dot_key_override,
	&slash_key_override,
	NULL
};
