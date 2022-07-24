#include QMK_KEYBOARD_H

// base layers
#define QWERTY  DF(_QWERTY)
#define COLEMAK DF(_COLEMAK)
#define GAME    DF(_GAME)

// additional layers
#define RMEH    MO(_COLEMAK_MEH)
#define JOIN    MO(_JOIN)
#define ADJUST  MO(_ADJUST)

// switch out of qwerty using shifts
#define QWRT_LS LM(_QWERTY_LSFT, MOD_LSFT)
#define QWRT_RS LM(_QWERTY_RSFT, MOD_RSFT)

// home row mods / mod taps
#define MT_ESC  MT(MOD_LGUI, KC_ESC)
#define MT_R    LT(_LAYER_R, KC_R)
#define MT_S    LT(_LAYER_S, KC_S)
#define MT_T    LT(_LAYER_T, KC_T)

#define MT_N    LT(_LAYER_N, KC_N)
#define MT_E    LT(_LAYER_E, KC_E)
#define MT_I    LT(_LAYER_I, KC_I)
#define MT_ENT  MT(MOD_RALT, KC_ENT)

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
#define RM_ENT  RCTL(RSFT(RALT(KC_ENT)))
#define RM_ESC  RCTL(RSFT(RALT(KC_ESC)))
#define RM_BSPC RCTL(RSFT(RALT(KC_BSPC)))
#define RM_TAB  RCTL(RSFT(RALT(KC_TAB)))
#define RM_SPC  RCTL(RSFT(RALT(KC_SPC)))
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
#define RM_RGHT RCTL(RSFT(RALT(KC_RGHT)))
#define RM_LEFT RCTL(RSFT(RALT(KC_LEFT)))
#define RM_DOWN RCTL(RSFT(RALT(KC_DOWN)))
#define RM_UP   RCTL(RSFT(RALT(KC_UP)))
#define RM_DEL  RCTL(RSFT(RALT(KC_DEL)))

// layers enum
enum layers {
	_COLEMAK,
	_COLEMAK_MEH,
	_LAYER_R,
	_LAYER_S,
	_LAYER_T,
	_LAYER_N,
	_LAYER_E,
	_LAYER_I,
	_GAME,
	_JOIN,
	_ADJUST,
	_QWERTY,
	_QWERTY_LSFT,
	_QWERTY_RSFT,
};

// per key tapping term value
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case MT_ESC:
		case MT_ENT:
			return TAPPING_TERM - 20;
		default:
			return TAPPING_TERM;
	}
};

// layer_t overrides
const key_override_t left_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LBRC, KC_LBRC, 1 << _LAYER_T);
const key_override_t right_bracket_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RBRC, KC_RBRC, 1 << _LAYER_T);
const key_override_t minus_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_MINS, KC_MINS, 1 << _LAYER_T);
const key_override_t underscore_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_UNDS, KC_UNDS, 1 << _LAYER_T);
const key_override_t semicolon_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_SCLN, KC_SCLN, 1 << _LAYER_T);
const key_override_t colon_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_COLN, KC_COLN, 1 << _LAYER_T);
const key_override_t equal_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_EQL, KC_EQL, 1 << _LAYER_T);
const key_override_t grave_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_GRV, KC_GRV, 1 << _LAYER_T);
const key_override_t backslash_key_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_BSLS, KC_BSLS, 1 << _LAYER_T);

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

// globally define all key overrides to be used
const key_override_t **key_overrides = (const key_override_t *[]){
	&left_bracket_key_override,
	&right_bracket_key_override,
	&minus_key_override,
	&underscore_key_override,
	&semicolon_key_override,
	&colon_key_override,
	&equal_key_override,
	&grave_key_override,
	&backslash_key_override,
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
	NULL
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[_COLEMAK] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX, ADJUST,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,KC_LBRC, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_QUOT,KC_BSPC,     KC_DEL,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   MT_ESC       , KC_A  , MT_R  , MT_S  , MT_T  , KC_G  ,KC_RBRC, KC_M  , MT_N  , MT_E  , MT_I  , KC_O  ,XXXXXXX,   MT_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_D  , KC_V  ,KC_SCLN,KC_BSLS, KC_K  , KC_H  ,KC_COMM,KC_DOT ,XXXXXXX,KC_SLSH,  KC_UP,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_LCTL ,        KC_SPC         , KC_RSFT ,  RMEH   ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	// NOTE: macOS reserves `hyper + ,` and `hyper + .` for sysdiagnose. Remapped
	// RM_COMM, RM_DOT to RM_MINS, RM_EQL
	[_COLEMAK_MEH] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   RM_GRV , RM_1  , RM_2  , RM_3  , RM_4  , RM_5  , RM_6  , RM_7  , RM_8  , RM_9  , RM_0  ,RM_MINS,RM_EQL ,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   RM_TAB     , RM_Q  , RM_W  , RM_F  , RM_P  , RM_B  ,RM_LBRC, RM_J  , RM_L  , RM_U  , RM_Y  ,RM_QUOT,RM_BSPC,     RM_DEL,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   RM_ESC       , RM_A  , RM_R  , RM_S  , RM_T  , RM_G  ,RM_RBRC, RM_M  , RM_N  , RM_E  , RM_I  , RM_O  ,XXXXXXX,   RM_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   KC_LSFT, RM_Z  , RM_X  , RM_C  , RM_D  , RM_V  ,RM_SCLN,RM_BSLS, RM_K  , RM_H  ,RM_MINS,RM_EQL ,XXXXXXX,RM_SLSH,  RM_UP,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , ADJUST  ,        KC_RGUI        , XXXXXXX , _______ ,XXXXXXX,RM_LEFT,RM_DOWN,RM_RGHT
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_R] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_PSCR,KC_SLCK,KC_PAUS,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   _______      ,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,KC_NLCK,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , _______ , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_S] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_LCBR,KC_RCBR,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   _______      ,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_PLUS,KC_TILD,KC_PIPE,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , _______ , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_T] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_LBRC,KC_RBRC,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   _______      ,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,KC_MINS,KC_UNDS,KC_SCLN,KC_COLN,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_EQL ,KC_GRV ,KC_BSLS,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , XXXXXXX , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_N] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,XXXXXXX, KC_7  , KC_8  , KC_9  ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   _______      , KC_0  , KC_4  , KC_5  , KC_6  ,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,XXXXXXX, KC_1  , KC_2  , KC_3  ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , XXXXXXX , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_E] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,XXXXXXX,KC_AMPR,KC_ASTR,KC_LPRN,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   _______      ,KC_RPRN,KC_DLR ,KC_PERC,KC_CIRC,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,XXXXXXX,KC_EXLM, KC_AT ,KC_HASH,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , _______ , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_I] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,KC_F12 , KC_F7 , KC_F8 , KC_F9 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_CAPS      ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,KC_F11 , KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , _______ , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_GAME] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX, ADJUST,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,KC_LBRC, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_QUOT,KC_BSPC,     KC_DEL,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_ESC       , KC_A  , KC_R  , KC_S  , KC_T  , KC_G  ,KC_RBRC, KC_M  , KC_N  , KC_E  , KC_I  , KC_O  ,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_D  , KC_V  ,KC_SCLN,KC_BSLS, KC_K  , KC_H  ,KC_COMM,KC_DOT ,XXXXXXX,KC_SLSH,  KC_UP,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_LCTL ,        KC_SPC         , KC_RSFT ,  JOIN   ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_JOIN] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,KC_F12 , KC_F7 , KC_F8 , KC_F9 ,XXXXXXX,XXXXXXX,XXXXXXX,KC_PSCR,KC_SLCK,KC_PAUS,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_CAPS      ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,KC_NLCK,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,KC_F11 , KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , _______ , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_ADJUST] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   RESET  ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   _______    ,RGB_HUI,RGB_SAI,RGB_VAI,RGB_TOG,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,    _______,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   _______      ,QWERTY ,COLEMAK, GAME  ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_MPRV,KC_VOLD,KC_VOLU,KC_MNXT,XXXXXXX,  _______,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,RGB_HUD,RGB_SAD,RGB_VAD,RGB_MOD,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_MPLY,KC_MUTE,XXXXXXX,XXXXXXX,_______,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   _______      , _______ , _______ , _______ ,        _______        , _______ , _______ ,_______,_______,_______,_______
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  , KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,    KC_BSLS,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  , KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   QWRT_LS,KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  , KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,XXXXXXX,KC_RSFT,QWRT_RS,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_SPC  ,        KC_SPC         , KC_SPC  , KC_RALT ,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY_LSFT] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  , KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,    KC_BSLS,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  , KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  , KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,XXXXXXX,KC_RSFT,COLEMAK,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_SPC  ,        KC_SPC         , KC_SPC  , KC_RALT ,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY_RSFT] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  , KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,    KC_BSLS,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  , KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   COLEMAK,KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  , KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,XXXXXXX,KC_RSFT,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_SPC  ,        KC_SPC         , KC_SPC  , KC_RALT ,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT
	//├─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	)
};
