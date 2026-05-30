#include "anordhoff.h"

// TODO: holding comma, then hold shift, then release shift, and it breaks
// this might have useful info: https://getreuer.info/posts/keyboards/custom-shift-keys/index.html

// correctly handle mod taps with non-basic keycodes
// https://docs.qmk.fm/mod_tap#intercepting-mod-taps
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_UNDS:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_UNDS);
				return false;
			}
			break;
		case MT_DLR:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_DLR);
				return false;
			}
			break;
		case MT_PERC:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_PERC);
				return false;
			}
			break;
		case MT_CIRC:
			if (record->tap.count && record->event.pressed) {
				tap_code16(KC_CIRC);
				return false;
			}
			break;
	}
	return true;
};

// per-key tapping term
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_Z:
		case MT_A:
		case MT_O:
			return 250;

		case MT_UNDS:
		case MT_MINS:
			return 200;

		case MT_SPC:
		case MT_ESC:
			return 170;

		default:
			return 180;
	}
};

// per-key hold on other key press
bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_ESC:
			return true;
		default:
			return false;
	}
}
