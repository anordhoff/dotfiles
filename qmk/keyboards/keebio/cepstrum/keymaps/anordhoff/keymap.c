#include "anordhoff.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[_COLEMAK] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,        XXXXXXX, KC_J  , KC_L  , KC_U  , KC_Y  ,KC_SCLN,KC_QUOT,   XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_BSPC      , MT_A  , MT_R  , MT_S  , MT_T  , KC_G  ,        XXXXXXX, KC_M  , MT_N  , MT_E  , MT_I  , MT_O  ,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_Z             , KC_X  , KC_C  , KC_D  , KC_V  ,XXXXXXX,        XXXXXXX, KC_K  , KC_H  ,KC_COMM,KC_MINS,   KC_SLSH   , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX ,   NAV   ,     MT_SPC      ,             MT_ESC      ,   NUM   , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	// macos reserves `hyper + ,` and `hyper + .` for sysdiagnose (LM_COMM -> LM_LBRC, LM_DOT -> LM_RBRC)
	// TODO: update to reflect base layer changes
	[_COLEMAK_MEH] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX    , LM_Q  , LM_W  , LM_F  , LM_P  , LM_B  ,        XXXXXXX, LM_J  , LM_L  , LM_U  , LM_Y  ,LM_BSPC,XXXXXXX,   XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    LM_TAB       , LM_A  , LM_R  , LM_S  , LM_T  , LM_G  ,        XXXXXXX, LM_M  , LM_N  , LM_E  , LM_I  , LM_O  ,          LM_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    LM_Z             , LM_X  , LM_C  , LM_D  , LM_V  ,XXXXXXX,        XXXXXXX, LM_K  , LM_H  ,LM_LBRC,LM_RBRC,   LM_QUOT   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , ADJUST  ,     LHYPER      ,             RHYPER      , ADJUST  , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_SYMBOL] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX,KC_DLR ,KC_PERC,KC_CIRC,XXXXXXX,        XXXXXXX,XXXXXXX,KC_GRV ,KC_LCBR,KC_RCBR,XXXXXXX,XXXXXXX,   XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_BSPC      ,KC_RPRN,MT_EXLM, MT_AT ,MT_HASH,XXXXXXX,        XXXXXXX,XXXXXXX,MT_EQL ,MT_LBRC,MT_RBRC,KC_BSLS,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TILD          ,KC_AMPR,KC_ASTR,KC_LPRN,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_PIPE, KC_LT , KC_GT ,   KC_PLUS   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , XXXXXXX ,     _______     ,             KC_SPC      , XXXXXXX , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_NUMPAD] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX, KC_4  , KC_5  , KC_6  ,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,   XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_BSPC      , KC_0  , KC_1  , KC_2  , KC_3  ,XXXXXXX,        XXXXXXX,XXXXXXX,KC_RCTL,KC_RGUI,KC_RALT,XXXXXXX,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          , KC_7  , KC_8  , KC_9  ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,KC_COMM,KC_DOT ,   KC_SLSH   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX ,  FUNC   ,     KC_SPC      ,             XXXXXXX     , _______ , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_NAVIGATION] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,XXXXXXX,XXXXXXX,   XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_BSPC      ,XXXXXXX,KC_LALT,KC_LGUI,KC_LCTL,XXXXXXX,        XXXXXXX,XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_UNDO          ,KC_CUT ,KC_COPY,XXXXXXX,KC_PSTE,XXXXXXX,        XXXXXXX,XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , _______ ,     XXXXXXX     ,             KC_SPC      ,  FUNC   , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_FUNCTION] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,       XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_TAB     ,KC_F11 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,        XXXXXXX,XXXXXXX,KC_PSCR,KC_SCRL,KC_PAUS,KC_NUM ,XXXXXXX,   XXXXXXX ,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_BSPC      ,KC_F10 , KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,        XXXXXXX,XXXXXXX,KC_RCTL,KC_RGUI,KC_RALT,XXXXXXX,          KC_ENT ,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_F12           , KC_F7 , KC_F8 , KC_F9 ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,   XXXXXXX   ,XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX  , XXXXXXX , XXXXXXX , _______ ,     XXXXXXX     ,             XXXXXXX     , _______ , XXXXXXX ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),

	[_ADJUST] = LAYOUT_65xt(
	//┌───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────────────┬───────┐
	   XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├───────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┘   ┌───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───────────┼───────┤
	   XXXXXXX,XXXXXXX,    QK_BOOT    ,QWERTY ,COLEMAK,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,DT_PRNT, DT_UP ,DT_DOWN,XXXXXXX,XXXXXXX,    XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├───────────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_CAPS      ,UG_VALD,KC_BRID,KC_BRIU,UG_VALU,UG_TOGG,        XXXXXXX,XXXXXXX,KC_MPRV,KC_VOLD,KC_VOLU,KC_MNXT,          XXXXXXX,XXXXXXX,
	//├───────┼───────┤   ├─────────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴─────────┬───────┼───────┤
	   XXXXXXX,XXXXXXX,    XXXXXXX          ,UG_HUEU,UG_SATU,UG_NEXT,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_MPLY,KC_MUTE,XXXXXXX,   XXXXXXX   ,XXXXXXX,XXXXXXX,
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
	   XXXXXXX,XXXXXXX,    _______          , KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  ,         KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,   COLEMAK   , KC_UP ,XXXXXXX,
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
	   XXXXXXX,XXXXXXX,    COLEMAK          , KC_Z  , KC_X  , KC_C  , KC_V  , KC_B  ,         KC_N  , KC_M  ,KC_COMM,KC_DOT ,KC_SLSH,   _______   , KC_UP ,XXXXXXX,
	//├───────┼───────┤   ├─────────┬───────┴─┬─────┴───┬───┴─────┬─┴───────┴───────┤       ├───────┴───────┴─┬─────┴───┬───┴─────┬─┴─────┬───────┼───────┼───────┤
	   XXXXXXX,XXXXXXX,    KC_LCTL  , KC_LGUI , KC_LALT , KC_SPC  ,     KC_SPC              ,     KC_SPC      , KC_SPC  , XXXXXXX ,XXXXXXX,KC_LEFT,KC_DOWN,KC_RGHT
	//└───────┴───────┘   └─────────┴─────────┴─────────┴─────────┴─────────────────┘       └─────────────────┴─────────┴─────────┴───────┴───────┴───────┴───────┘
	),
};
