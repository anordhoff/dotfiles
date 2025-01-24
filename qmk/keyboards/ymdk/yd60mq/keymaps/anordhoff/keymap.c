#include "anordhoff.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[_COLEMAK] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,KC_LBRC, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       , MT_A  , MT_R  , MT_S  , MT_T  , KC_G  ,KC_RBRC, KC_M  , MT_N  , MT_E  , MT_I  , MT_O  ,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_D  , KC_V  ,KC_SCLN,KC_BSLS, KC_K  , KC_H  ,KC_MINS,KC_COMM,XXXXXXX,QUOT_UP,TOG_QUP,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	// macos reserves `hyper + ,` and `hyper + .` for sysdiagnose (LM_COMM -> LM_LBRC, LM_DOT -> LM_RBRC)
	[_COLEMAK_MEH] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   LM_GRV , LM_1  , LM_2  , LM_3  , LM_4  , LM_5  , LM_6  , LM_7  , LM_8  , LM_9  , LM_0  ,LM_MINS,LM_EQL ,XXXXXXX,LM_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    , LM_Q  , LM_W  , LM_F  , LM_P  , LM_B  ,LM_LBRC, LM_J  , LM_L  , LM_U  , LM_Y  ,LM_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   LM_TAB       , LM_A  , LM_R  , LM_S  , LM_T  , LM_G  ,LM_RBRC, LM_M  , LM_N  , LM_E  , LM_I  , LM_O  ,XXXXXXX,   LM_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX, LM_Z  , LM_X  , LM_C  , LM_D  , LM_V  ,LM_SCLN,LM_BSLS, LM_K  , LM_H  ,LM_LBRC,LM_RBRC,XXXXXXX,LM_QUOT,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , ADJUST  ,        LHYPER         , RHYPER  , ADJUST  ,XXXXXXX,LM_LEFT,LM_DOWN,LM_RGHT
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_R] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       ,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_S] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_LBRC,KC_RBRC,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       ,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSLS,KC_LPRN,KC_RPRN,KC_PIPE,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX, KC_LT ,KC_LCBR,KC_RCBR, KC_GT ,XXXXXXX,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_T] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_GRV ,KC_TILD,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       ,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,KC_SLSH,KC_QUES,KC_SCLN,KC_COLN,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_EQL ,KC_PLUS,KC_EXLM,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_N] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,XXXXXXX, KC_7  , KC_8  , KC_9  ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       , KC_0  , KC_4  , KC_5  , KC_6  ,XXXXXXX,XXXXXXX,XXXXXXX,_______,KC_ASTR,KC_PLUS,KC_COLN,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX,XXXXXXX, KC_1  , KC_2  , KC_3  ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_COMM,KC_DOT ,XXXXXXX,KC_SLSH,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_E] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,XXXXXXX,KC_AMPR,KC_ASTR,KC_LPRN,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       ,KC_RPRN,KC_DLR ,KC_PERC,KC_CIRC,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX,XXXXXXX,KC_EXLM, KC_AT ,KC_HASH,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_I] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,KC_F11 , KC_F7 , KC_F8 , KC_F9 ,KC_F12 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX,XXXXXXX, KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , XXXXXXX , KC_LGUI ,        MT_SPC         , MT_ESC  , KC_LALT ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_GAME] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,KC_LBRC, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_TAB       , KC_A  , KC_R  , KC_S  , KC_T  , KC_G  ,KC_RBRC, KC_M  , KC_N  , KC_E  , KC_I  , KC_O  ,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   KC_LSFT, MT_Z  , KC_X  , KC_C  , KC_D  , KC_V  ,KC_SCLN,KC_BSLS, KC_K  , KC_H  ,KC_MINS,KC_COMM,XXXXXXX,QUOT_UP,TOG_QUP,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_SPC  ,        KC_SPC         , MT_ESC  , GME_MEH ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	// macos reserves `hyper + ,` and `hyper + .` for sysdiagnose (LM_COMM -> LM_LBRC, LM_DOT -> LM_RBRC)
	[_GAME_MEH] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   LM_GRV , LM_1  , LM_2  , LM_3  , LM_4  , LM_5  , LM_6  , LM_7  , LM_8  , LM_9  , LM_0  ,LM_MINS,LM_EQL ,XXXXXXX,LM_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   LM_TAB     , LM_Q  , LM_W  , LM_F  , LM_P  , LM_B  ,LM_LBRC, LM_J  , LM_L  , LM_U  , LM_Y  ,LM_BSPC,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   LM_TAB       , LM_A  , LM_R  , LM_S  , LM_T  , LM_G  ,LM_RBRC, LM_M  , LM_N  , LM_E  , LM_I  , LM_O  ,XXXXXXX,   LM_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   XXXXXXX, LM_Z  , LM_X  , LM_C  , LM_D  , LM_V  ,LM_SCLN,LM_BSLS, LM_K  , LM_H  ,LM_LBRC,LM_RBRC,XXXXXXX,LM_QUOT,  LM_UP,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , ADJUST  , GME_EXT ,        GME_HYP        , XXXXXXX , _______ ,XXXXXXX,LM_LEFT,LM_DOWN,LM_RGHT
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_GAME_EXTEND] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,KC_F11 , KC_F7 , KC_F8 , KC_F9 ,KC_F12 ,XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,XXXXXXX,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   XXXXXXX      ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,XXXXXXX,XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   KC_LSFT,XXXXXXX, KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , _______ ,        XXXXXXX        , XXXXXXX , _______ ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_ADJUST] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   QK_BOOT,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   XXXXXXX    ,XXXXXXX,QWERTY ,COLEMAK, GAME  ,XXXXXXX,XXXXXXX,XXXXXXX,KC_PSCR,KC_SCRL,KC_PAUS,KC_NUM ,XXXXXXX,    XXXXXXX,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_CAPS      ,RGB_VAD,KC_BRID,KC_BRIU,RGB_VAI,RGB_TOG,XXXXXXX,XXXXXXX,KC_MPRV,KC_VOLD,KC_VOLU,KC_MNXT,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,XXXXXXX,RGB_HUI,RGB_SAI,RGB_MOD,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_MPLY,KC_MUTE,XXXXXXX,XXXXXXX,XXXXXXX,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   XXXXXXX      , XXXXXXX , _______ , _______ ,        XXXXXXX        , XXXXXXX , _______ ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
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
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY_LEFT_SHIFT] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  , KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,    KC_BSLS,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  , KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   _______,KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  , KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,XXXXXXX,KC_RSFT, ADJUST,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_SPC  ,        KC_SPC         , KC_SPC  , KC_RALT ,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY_RIGHT_SHIFT] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┐
	   KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  , KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,XXXXXXX,KC_BSPC,
	//├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───────┤
	   KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  , KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,    KC_BSLS,
	//├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────────┤
	   KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  , KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,XXXXXXX,   KC_ENT,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬───────┤
	   ADJUST ,KC_LSFT, KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  , KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,XXXXXXX,KC_RSFT,_______,
	//├───────┴─────┬─┴───────┼───────┴─┬─────┴───┬───┴───────┴───────┴───┬───┴─────┬─┴───────┼───────┼───────┼───────┼───────┤
	   KC_LCTL      , KC_LGUI , KC_LALT , KC_SPC  ,        KC_SPC         , KC_SPC  , KC_RALT ,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT
	//└─────────────┴─────────┴─────────┴─────────┴───────────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	)
};
