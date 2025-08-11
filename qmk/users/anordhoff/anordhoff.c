#include "anordhoff.h"

// TODO: holding comma, then hold shift, then release shift, and it breaks
// this might have useful info: https://getreuer.info/posts/keyboards/custom-shift-keys/index.html

// toggle right shift between KC_QUOT and KC_UP
bool kc_up_toggled = false;
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case QWERTY: case COLEMAK: case GAME:
			if (record->event.pressed) {
				kc_up_toggled = false;
			}
			return true;
		case TOG_QUP:
			if (record->event.pressed) {
				kc_up_toggled = !kc_up_toggled;
			}
			return true;
		case QUOT_UP:
			if (kc_up_toggled) {
				if (record->event.pressed) {
					register_code(KC_UP);
				} else {
					unregister_code(KC_UP);
				}
			} else {
				if (record->event.pressed) {
					register_code(KC_QUOT);
				} else {
					unregister_code(KC_QUOT);
				}
			}
			return true;
		default:
			return true;
	}
};

// per key tapping term
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_A:
		case MT_R:
		case MT_I:
		case MT_O:
		case MT_Z:
			return 250;
		case MT_SPC:
		case MT_ESC:
			return 170;
		default:
			return TAPPING_TERM;
	}
};

// per key permissive hold
bool get_permissive_hold(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
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
			return QUICK_TAP_TERM;
	}
};
