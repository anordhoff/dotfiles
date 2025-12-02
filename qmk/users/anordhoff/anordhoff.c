#include "anordhoff.h"

// TODO: holding comma, then hold shift, then release shift, and it breaks
// this might have useful info: https://getreuer.info/posts/keyboards/custom-shift-keys/index.html

bool kc_up_toggled = false;
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {

		// toggle right shift between KC_SLSH and KC_UP
		case QWERTY: case COLEMAK: case GAME:
			if (record->event.pressed) {
				kc_up_toggled = false;
			}
			break;
		case TOG_SUP:
			if (record->event.pressed) {
				kc_up_toggled = !kc_up_toggled;
			}
			break;
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
			break;

		// correctly handle mod taps with non-basic keycodes
		// https://docs.qmk.fm/mod_tap#intercepting-mod-taps
		case MT_EXLM:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_EXLM);
				return false;
			}
			break;
		case MT_AT:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_AT);
				return false;
			}
			break;
		case MT_HASH:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_HASH);
				return false;
			}
			break;
	}
	return true;
};

// per key tapping term
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_A:
		case MT_O:
			return 250;
		case MT_SPC:
		case MT_ESC:
			return 170;
		default:
			// TODO: after removing DYNAMIC_TAPPING_TERM_ENABLE, 
			// replace this with 200 and remove from config.h
			return TAPPING_TERM;
	}
};

// per key permissive hold
bool get_permissive_hold(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_A:
		case MT_O:
			return true;
		default:
			return false;
	}
};

// per key hold on other key press
bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_ESC:
			return true;
		default:
			return false;
	}
}

// per key quick tap term
uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_SPC:
			return 100;
		default:
			return 0;
	}
};
