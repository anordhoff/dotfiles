#include QMK_KEYBOARD_H

enum custom_keycodes {
	TOG_SUP = SAFE_RANGE,
	SLSH_UP
};

enum layers {
	_COLEMAK,
	_COLEMAK_GAME,
	_COLEMAK_MEH,
	_LAYER_R,
	_LAYER_S,
	_LAYER_T,
	_LAYER_N,
	_LAYER_E,
	_LAYER_I,
	_JOIN,
	_ADJUST,
	_QWERTY,
	_QWERTY_LEFT_SHIFT,
	_QWERTY_RIGHT_SHIFT,
};

// base layers
#define QWERTY  DF(_QWERTY)
#define COLEMAK DF(_COLEMAK)
#define GAME    DF(_COLEMAK_GAME)

// additional layers
#define JOIN    MO(_JOIN)
#define ADJUST  MO(_ADJUST)
#define RMEH    MO(_COLEMAK_MEH)
#define RHYP    KC_RGUI

// switch out of qwerty using shifts
#define QWRT_LS LM(_QWERTY_LEFT_SHIFT, MOD_LSFT)
#define QWRT_RS LM(_QWERTY_RIGHT_SHIFT, MOD_RSFT)

// home row mods / mod taps
#define MT_ESC  MT(MOD_LGUI, KC_ESC)

#define MT_A    LT(_COLEMAK_MEH, KC_A)
#define MT_R    LT(_LAYER_R, KC_R)
#define MT_S    LT(_LAYER_S, KC_S)
#define MT_T    LT(_LAYER_T, KC_T)
#define MT_N    LT(_LAYER_N, KC_N)
#define MT_E    LT(_LAYER_E, KC_E)
#define MT_I    LT(_LAYER_I, KC_I)
#define MT_O    LT(_COLEMAK_MEH, KC_O)

#define MT_SPC  MT(MOD_LCTL, KC_SPC)

#define MT_Z    MT(MOD_LSFT, KC_Z)

// right meh layer keys
#define RM_A    RCTL(RSFT(RALT(KC_A)))
#define RM_B    RCTL(RSFT(RALT(KC_B)))
#define RM_C    RCTL(RSFT(RALT(KC_C)))
#define RM_D    RCTL(RSFT(RALT(KC_D)))
#define RM_E    RCTL(RSFT(RALT(KC_E)))
#define RM_F    RCTL(RSFT(RALT(KC_F)))
#define RM_G    RCTL(RSFT(RALT(KC_G)))
#define RM_H    RCTL(RSFT(RALT(KC_H)))
#define RM_I    RCTL(RSFT(RALT(KC_I)))
#define RM_J    RCTL(RSFT(RALT(KC_J)))
#define RM_K    RCTL(RSFT(RALT(KC_K)))
#define RM_L    RCTL(RSFT(RALT(KC_L)))
#define RM_M    RCTL(RSFT(RALT(KC_M)))
#define RM_N    RCTL(RSFT(RALT(KC_N)))
#define RM_O    RCTL(RSFT(RALT(KC_O)))
#define RM_P    RCTL(RSFT(RALT(KC_P)))
#define RM_Q    RCTL(RSFT(RALT(KC_Q)))
#define RM_R    RCTL(RSFT(RALT(KC_R)))
#define RM_S    RCTL(RSFT(RALT(KC_S)))
#define RM_T    RCTL(RSFT(RALT(KC_T)))
#define RM_U    RCTL(RSFT(RALT(KC_U)))
#define RM_V    RCTL(RSFT(RALT(KC_V)))
#define RM_W    RCTL(RSFT(RALT(KC_W)))
#define RM_X    RCTL(RSFT(RALT(KC_X)))
#define RM_Y    RCTL(RSFT(RALT(KC_Y)))
#define RM_Z    RCTL(RSFT(RALT(KC_Z)))
#define RM_1    RCTL(RSFT(RALT(KC_1)))
#define RM_2    RCTL(RSFT(RALT(KC_2)))
#define RM_3    RCTL(RSFT(RALT(KC_3)))
#define RM_4    RCTL(RSFT(RALT(KC_4)))
#define RM_5    RCTL(RSFT(RALT(KC_5)))
#define RM_6    RCTL(RSFT(RALT(KC_6)))
#define RM_7    RCTL(RSFT(RALT(KC_7)))
#define RM_8    RCTL(RSFT(RALT(KC_8)))
#define RM_9    RCTL(RSFT(RALT(KC_9)))
#define RM_0    RCTL(RSFT(RALT(KC_0)))
#define RM_ESC  RCTL(RSFT(RALT(KC_ESC)))
#define RM_TAB  RCTL(RSFT(RALT(KC_TAB)))
#define RM_BSPC RCTL(RSFT(RALT(KC_BSPC)))
#define RM_DEL  RCTL(RSFT(RALT(KC_DEL)))
#define RM_ENT  RCTL(RSFT(RALT(KC_ENT)))
#define RM_SPC  RCTL(RSFT(RALT(KC_SPC)))
#define RM_UP   RCTL(RSFT(RALT(KC_UP)))
#define RM_LEFT RCTL(RSFT(RALT(KC_LEFT)))
#define RM_DOWN RCTL(RSFT(RALT(KC_DOWN)))
#define RM_RGHT RCTL(RSFT(RALT(KC_RGHT)))
#define RM_MINS RCTL(RSFT(RALT(KC_MINS)))
#define RM_EQL  RCTL(RSFT(RALT(KC_EQL)))
#define RM_LBRC RCTL(RSFT(RALT(KC_LBRC)))
#define RM_RBRC RCTL(RSFT(RALT(KC_RBRC)))
#define RM_BSLS RCTL(RSFT(RALT(KC_BSLS)))
#define RM_SCLN RCTL(RSFT(RALT(KC_SCLN)))
#define RM_QUOT RCTL(RSFT(RALT(KC_QUOT)))
#define RM_GRV  RCTL(RSFT(RALT(KC_GRV)))
#define RM_COMM RCTL(RSFT(RALT(KC_COMM)))
#define RM_DOT  RCTL(RSFT(RALT(KC_DOT)))
#define RM_SLSH RCTL(RSFT(RALT(KC_SLSH)))
#define RM_RGUI RCTL(RSFT(RALT(KC_RGUI)))
