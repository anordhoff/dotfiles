#include "anordhoff.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[_COLEMAK] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
     XXXXXXX,XXXXXXX,    KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  ,         KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,        KC_LBRC, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_QUOT,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      , MT_A  , MT_R  , MT_S  , MT_T  , KC_G  ,        KC_RBRC, KC_M  , MT_N  , MT_E  , MT_I  , MT_O  ,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_Z             , KC_X  , KC_C  , KC_D  , KC_V  ,KC_SCLN,        KC_BSLS, KC_K  , KC_H  ,KC_COMM,KC_DOT ,   KC_SLSH   , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	// macos reserves `hyper + ,` and `hyper + .` for sysdiagnose (RM_COMM -> RM_LBRC, RM_DOT -> RM_RBRC)
	[_COLEMAK_MEH] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    RM_GRV , RM_1  , RM_2  , RM_3  , RM_4  , RM_5  , RM_6  ,         RM_7  , RM_8  , RM_9  , RM_0  ,RM_MINS,RM_EQL ,       RM_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    RM_TAB     , RM_Q  , RM_W  , RM_F  , RM_P  , RM_B  ,        RM_LBRC, RM_J  , RM_L  , RM_U  , RM_Y  ,RM_QUOT,RM_BSPC,    RM_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    RM_MINS      , RM_A  , RM_R  , RM_S  , RM_T  , RM_G  ,        RM_RBRC, RM_M  , RM_N  , RM_E  , RM_I  , RM_O  ,          RM_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    RM_Z             , RM_X  , RM_C  , RM_D  , RM_V  ,RM_SCLN,        RM_BSLS, RM_K  , RM_H  ,RM_LBRC,RM_RBRC,   RM_SLSH   , RM_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , ADJUST  ,     RHYPER      ,             RHYPER      , ADJUST  , XXXXXXX ,XXXXXXX,RM_LEFT,RM_DOWN,RM_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_R] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,XXXXXXX,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      ,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_S] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,KC_LBRC,KC_RBRC,XXXXXXX,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      ,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_BSLS,KC_LPRN,KC_RPRN,KC_PIPE,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,KC_LCBR,KC_RCBR,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_T] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,KC_GRV ,KC_TILD,XXXXXXX,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      ,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_SCLN,KC_COLN,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_EQL ,KC_PLUS,KC_EXLM,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_N] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX, KC_7  , KC_8  , KC_9  ,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      , KC_0  , KC_4  , KC_5  , KC_6  ,XXXXXXX,        XXXXXXX,XXXXXXX,_______,KC_ASTR,KC_PLUS,KC_COLN,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          , KC_1  , KC_2  , KC_3  ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,KC_COMM,KC_DOT ,   KC_SLSH   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_E] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX,KC_AMPR,KC_ASTR,KC_LPRN,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      ,KC_RPRN,KC_DLR ,KC_PERC,KC_CIRC,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          ,KC_EXLM, KC_AT ,KC_HASH,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_LAYER_I] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,KC_F11 , KC_F7 , KC_F8 , KC_F9 ,KC_F12 ,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_MINS      ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          , KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , KC_LGUI ,     MT_SPC      ,             MT_ESC      , KC_LALT , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_GAME] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
     XXXXXXX,XXXXXXX,    KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  ,         KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,        KC_LBRC, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_QUOT,KC_BSPC,    KC_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_ESC       , KC_A  , KC_R  , KC_S  , KC_T  , KC_G  ,        KC_RBRC, KC_M  , KC_N  , KC_E  , KC_I  , KC_O  ,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    MT_Z             , KC_X  , KC_C  , KC_D  , KC_V  ,KC_SCLN,        KC_BSLS, KC_K  , KC_H  ,KC_COMM,KC_DOT ,   KC_SLSH   , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , KC_SPC  ,     KC_SPC      ,             KC_LSFT     , GME_MEH , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	// macos reserves `hyper + ,` and `hyper + .` for sysdiagnose (RM_COMM -> RM_LBRC, RM_DOT -> RM_RBRC)
	[_GAME_MEH] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    RM_GRV , RM_1  , RM_2  , RM_3  , RM_4  , RM_5  , RM_6  ,         RM_7  , RM_8  , RM_9  , RM_0  ,RM_MINS,RM_EQL ,       RM_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    RM_TAB     , RM_Q  , RM_W  , RM_F  , RM_P  , RM_B  ,        RM_LBRC, RM_J  , RM_L  , RM_U  , RM_Y  ,RM_QUOT,RM_BSPC,    RM_DEL ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    RM_MINS      , RM_A  , RM_R  , RM_S  , RM_T  , RM_G  ,        RM_RBRC, RM_M  , RM_N  , RM_E  , RM_I  , RM_O  ,          RM_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    RM_Z             , RM_X  , RM_C  , RM_D  , RM_V  ,RM_SCLN,        RM_BSLS, RM_K  , RM_H  ,RM_LBRC,RM_RBRC,   RM_SLSH   , RM_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , ADJUST  , GME_EXT ,     GME_HYP     ,             XXXXXXX     , _______ , XXXXXXX ,XXXXXXX,RM_LEFT,RM_DOWN,RM_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_GAME_EXTEND] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX    ,KC_F11 , KC_F7 , KC_F8 , KC_F9 ,KC_F12 ,        XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX      ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,        XXXXXXX,XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,          XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LSFT          , KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , _______ ,     XXXXXXX     ,             XXXXXXX     , _______ , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_ADJUST] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    QK_BOOT,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX    ,XXXXXXX,QWERTY ,COLEMAK, GAME  ,XXXXXXX,        XXXXXXX,XXXXXXX,KC_PSCR,KC_SCRL,KC_PAUS,KC_NUM ,XXXXXXX,    XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_CAPS      ,RGB_VAD,KC_BRID,KC_BRIU,RGB_VAI,RGB_TOG,        XXXXXXX,XXXXXXX,KC_MPRV,KC_VOLD,KC_VOLU,KC_MNXT,          XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    _______          ,RGB_HUI,RGB_SAI,RGB_MOD,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_MPLY,KC_MUTE,XXXXXXX,   _______   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , _______ , _______ ,     XXXXXXX     ,             XXXXXXX     , _______ , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  ,         KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  ,         KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,   KC_BSLS ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  ,         KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    QWRT_LS          , KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  ,         KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,   QWRT_RS   , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , KC_SPC  ,     KC_SPC              ,     KC_SPC      , KC_SPC  , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY_LEFT_SHIFT] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  ,         KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  ,         KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,   KC_BSLS ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  ,         KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    _______          , KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  ,         KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,   ADJUST    , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , KC_SPC  ,     KC_SPC              ,     KC_SPC      , KC_SPC  , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_QWERTY_RIGHT_SHIFT] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    KC_GRV , KC_1  , KC_2  , KC_3  , KC_4  , KC_5  , KC_6  ,         KC_7  , KC_8  , KC_9  , KC_0  ,KC_MINS,KC_EQL ,       KC_BSPC ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     , KC_Q  , KC_W  , KC_E  , KC_R  , KC_T  ,         KC_Y  , KC_U  , KC_I  , KC_O  , KC_P  ,KC_LBRC,KC_RBRC,   KC_BSLS ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_ESC       , KC_A  , KC_S  , KC_D  , KC_F  , KC_G  ,         KC_H  , KC_J  , KC_K  , KC_L  ,KC_SCLN,KC_QUOT,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    ADJUST           , KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  ,         KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,   _______   , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , KC_SPC  ,     KC_SPC              ,     KC_SPC      , KC_SPC  , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),
};
