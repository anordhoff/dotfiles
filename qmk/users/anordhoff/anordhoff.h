#include QMK_KEYBOARD_H

enum custom_keycodes {
	TOG_SUP = SAFE_RANGE,
	SLSH_UP
};

enum layers {
	_COLEMAK,
	_COLEMAK_MEH,
	_SYMBOL,
	_NUMPAD,
	_NAVIGATION,
	_FUNCTION,
	_GAME,
	_GAME_MEH,
	_GAME_EXTEND,
	_ADJUST,
	_QWERTY,
	_QWERTY_LEFT_SHIFT,
	_QWERTY_RIGHT_SHIFT,
};

// base layers
#define QWERTY  DF(_QWERTY)
#define COLEMAK DF(_COLEMAK)
#define GAME    DF(_GAME)

// colemak layers
#define SYM     MO(_SYMBOL)
#define NUM     MO(_NUMPAD)
#define NAV     MO(_NAVIGATION)
#define FUNC    MO(_FUNCTION)
#define LHYPER  KC_LGUI
#define RHYPER  KC_RGUI

// gaming layers
#define GME_MEH MO(_GAME_MEH)
#define GME_HYP KC_LGUI
#define GME_EXT MO(_GAME_EXTEND)

// additional layers
#define ADJUST  MO(_ADJUST)

// layer mod taps
#define MT_SPC  LT(_SYMBOL,  KC_SPC)
#define MT_ESC  MT(MOD_LSFT, KC_ESC)

// switch out of qwerty using shifts
#define QWRT_LS LM(_QWERTY_LEFT_SHIFT, MOD_LSFT)
#define QWRT_RS LM(_QWERTY_RIGHT_SHIFT, MOD_RSFT)

// home row mods
#define MT_A    LT(_COLEMAK_MEH, KC_A)
#define MT_R    MT(MOD_LGUI,     KC_R)
#define MT_S    MT(MOD_LALT,     KC_S)
#define MT_T    MT(MOD_LCTL,     KC_T)
#define MT_N    MT(MOD_RCTL,     KC_N)
#define MT_E    MT(MOD_RALT,     KC_E)
#define MT_I    MT(MOD_RGUI,     KC_I)
#define MT_O    LT(_COLEMAK_MEH, KC_O)

#define MT_EXLM MT(MOD_LGUI,     KC_EXLM)
#define MT_AT   MT(MOD_LALT,     KC_AT)
#define MT_HASH MT(MOD_LCTL,     KC_HASH)
#define MT_EQL  MT(MOD_RCTL,     KC_EQL)
#define MT_LBRC MT(MOD_RALT,     KC_LBRC)
#define MT_RBRC MT(MOD_RGUI,     KC_RBRC)


// meh layer keys
#define LM_A    LCTL(LSFT(LALT(KC_A)))
#define LM_B    LCTL(LSFT(LALT(KC_B)))
#define LM_C    LCTL(LSFT(LALT(KC_C)))
#define LM_D    LCTL(LSFT(LALT(KC_D)))
#define LM_E    LCTL(LSFT(LALT(KC_E)))
#define LM_F    LCTL(LSFT(LALT(KC_F)))
#define LM_G    LCTL(LSFT(LALT(KC_G)))
#define LM_H    LCTL(LSFT(LALT(KC_H)))
#define LM_I    LCTL(LSFT(LALT(KC_I)))
#define LM_J    LCTL(LSFT(LALT(KC_J)))
#define LM_K    LCTL(LSFT(LALT(KC_K)))
#define LM_L    LCTL(LSFT(LALT(KC_L)))
#define LM_M    LCTL(LSFT(LALT(KC_M)))
#define LM_N    LCTL(LSFT(LALT(KC_N)))
#define LM_O    LCTL(LSFT(LALT(KC_O)))
#define LM_P    LCTL(LSFT(LALT(KC_P)))
#define LM_Q    LCTL(LSFT(LALT(KC_Q)))
#define LM_R    LCTL(LSFT(LALT(KC_R)))
#define LM_S    LCTL(LSFT(LALT(KC_S)))
#define LM_T    LCTL(LSFT(LALT(KC_T)))
#define LM_U    LCTL(LSFT(LALT(KC_U)))
#define LM_V    LCTL(LSFT(LALT(KC_V)))
#define LM_W    LCTL(LSFT(LALT(KC_W)))
#define LM_X    LCTL(LSFT(LALT(KC_X)))
#define LM_Y    LCTL(LSFT(LALT(KC_Y)))
#define LM_Z    LCTL(LSFT(LALT(KC_Z)))
#define LM_1    LCTL(LSFT(LALT(KC_1)))
#define LM_2    LCTL(LSFT(LALT(KC_2)))
#define LM_3    LCTL(LSFT(LALT(KC_3)))
#define LM_4    LCTL(LSFT(LALT(KC_4)))
#define LM_5    LCTL(LSFT(LALT(KC_5)))
#define LM_6    LCTL(LSFT(LALT(KC_6)))
#define LM_7    LCTL(LSFT(LALT(KC_7)))
#define LM_8    LCTL(LSFT(LALT(KC_8)))
#define LM_9    LCTL(LSFT(LALT(KC_9)))
#define LM_0    LCTL(LSFT(LALT(KC_0)))
#define LM_MINS LCTL(LSFT(LALT(KC_MINS)))
#define LM_EQL  LCTL(LSFT(LALT(KC_EQL)))
#define LM_LBRC LCTL(LSFT(LALT(KC_LBRC)))
#define LM_RBRC LCTL(LSFT(LALT(KC_RBRC)))
#define LM_BSLS LCTL(LSFT(LALT(KC_BSLS)))
#define LM_SCLN LCTL(LSFT(LALT(KC_SCLN)))
#define LM_QUOT LCTL(LSFT(LALT(KC_QUOT)))
#define LM_GRV  LCTL(LSFT(LALT(KC_GRV)))
#define LM_COMM LCTL(LSFT(LALT(KC_COMM)))
#define LM_DOT  LCTL(LSFT(LALT(KC_DOT)))
#define LM_SLSH LCTL(LSFT(LALT(KC_SLSH)))
#define LM_ESC  LCTL(LSFT(LALT(KC_ESC)))
#define LM_TAB  LCTL(LSFT(LALT(KC_TAB)))
#define LM_BSPC LCTL(LSFT(LALT(KC_BSPC)))
#define LM_ENT  LCTL(LSFT(LALT(KC_ENT)))
#define LM_SPC  LCTL(LSFT(LALT(KC_SPC)))
#define LM_UP   LCTL(LSFT(LALT(KC_UP)))
#define LM_LEFT LCTL(LSFT(LALT(KC_LEFT)))
#define LM_DOWN LCTL(LSFT(LALT(KC_DOWN)))
#define LM_RGHT LCTL(LSFT(LALT(KC_RGHT)))
#define LM_DEL  LCTL(LSFT(LALT(KC_DEL)))
