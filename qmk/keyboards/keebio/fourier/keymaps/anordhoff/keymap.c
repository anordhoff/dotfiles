#include "anordhoff.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[_COLEMAK] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     KC_TAB , KC_Q  , KC_W  , KC_F  , KC_P  , KC_B  ,         KC_J  , KC_L  , KC_U  , KC_Y  ,KC_QUOT,KC_BSPC, KC_DEL,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   KC_MINS  , MT_A  , MT_R  , MT_S  , MT_T  , KC_G  ,         KC_M  , MT_N  , MT_E  , MT_I  , MT_O,         KC_ENT,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   KC_Z         , KC_X  , KC_C  , KC_D  , KC_V  ,XXXXXXX,         KC_K  , KC_H  ,KC_COMM,KC_DOT ,SLSH_UP,  TOG_SUP,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   KC_LCTL,KC_LALT,KC_LGUI,XXXXXXX,     MT_SPC      ,             MT_ESC      , KC_LALT ,KC_LEFT,KC_DOWN,  KC_RGHT
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	// macos reserves `hyper + ,` and `hyper + .` for sysdiagnose (RM_COMM -> RM_MINS, RM_DOT -> RM_EQL)
	[_COLEMAK_MEH] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     RM_TAB , RM_Q  , RM_W  , RM_F  , RM_P  , RM_B  ,         RM_J  , RM_L  , RM_U  , RM_Y  ,RM_QUOT,RM_BSPC, RM_DEL,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   RM_MINS  , RM_A  , RM_R  , RM_S  , RM_T  , RM_G  ,         RM_M  , RM_N  , RM_E  , RM_I  , RM_O,         RM_ENT,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   RM_Z         , RM_X  , RM_C  , RM_D  , RM_V  ,XXXXXXX,         RM_K  , RM_H  ,RM_MINS,RM_EQL ,RM_SLSH,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,ADJUST ,XXXXXXX,     RHYPER      ,             RHYPER      , ADJUST  ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_LAYER_R] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,KC_INS ,KC_HOME,KC_PGUP,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   XXXXXXX  ,XXXXXXX,_______,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,KC_LEFT,KC_DOWN, KC_UP ,KC_RGHT,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,KC_DEL ,KC_END ,KC_PGDN,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,KC_LGUI,XXXXXXX,     KC_LCTL     ,             KC_LSFT     , KC_LALT ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_LAYER_S] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_LBRC,KC_RBRC,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   XXXXXXX  ,XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,        XXXXXXX,KC_BSLS,KC_LPRN,KC_RPRN,KC_PIPE,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_LCBR,KC_RCBR,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,KC_LGUI,XXXXXXX,     KC_LCTL     ,             KC_LSFT     , KC_LALT ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_LAYER_T] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_GRV ,KC_TILD,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   XXXXXXX  ,XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,        XXXXXXX,KC_MINS,KC_UNDS,KC_SCLN,KC_COLN,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      ,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,        XXXXXXX,KC_EQL ,KC_PLUS,KC_EXLM,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,KC_LGUI,XXXXXXX,     KC_LCTL     ,             KC_LSFT     , KC_LALT ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_LAYER_N] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     XXXXXXX,XXXXXXX, KC_7  , KC_8  , KC_9  ,XXXXXXX,        XXXXXXX,XXXXXXX,KC_ASTR,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   XXXXXXX  , KC_0  , KC_4  , KC_5  , KC_6  ,XXXXXXX,        XXXXXXX,_______,KC_MINS,KC_PLUS,KC_COLN,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      , KC_1  , KC_2  , KC_3  ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,KC_COMM,KC_DOT ,KC_SLSH,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,KC_LGUI,XXXXXXX,     KC_LCTL     ,             KC_LSFT     , KC_LALT ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_LAYER_E] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     XXXXXXX,XXXXXXX,KC_AMPR,KC_ASTR,KC_LPRN,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   XXXXXXX  ,KC_RPRN,KC_DLR ,KC_PERC,KC_CIRC,XXXXXXX,        XXXXXXX,XXXXXXX,_______,XXXXXXX,XXXXXXX,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      ,KC_EXLM, KC_AT ,KC_HASH,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,KC_LGUI,XXXXXXX,     KC_LCTL     ,             KC_LSFT     , KC_LALT ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_LAYER_I] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     XXXXXXX,KC_F11 , KC_F7 , KC_F8 , KC_F9 ,KC_F12 ,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   XXXXXXX  ,KC_F10 , KC_F4 , KC_F5 , KC_F6 ,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,_______,XXXXXXX,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      , KC_F1 , KC_F2 , KC_F3 ,XXXXXXX,XXXXXXX,        XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,KC_LGUI,XXXXXXX,     KC_LCTL     ,             KC_LSFT     , KC_LALT ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),

	[_ADJUST] = LAYOUT(
	//┌───────┬───────┬───────┬───────┬───────┬───────┐       ┌───────┬───────┬───────┬───────┬───────┬───────┬───────┐
     QK_BOOT,XXXXXXX,_______,COLEMAK,_______,XXXXXXX,        XXXXXXX,KC_PSCR,KC_SCRL,KC_PAUS,KC_NUM ,XXXXXXX,XXXXXXX,
	//├───────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┐     └─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┤
	   KC_CAPS  ,RGB_VAD,KC_BRID,KC_BRIU,RGB_VAI,RGB_TOG,        XXXXXXX,KC_MPRV,KC_VOLD,KC_VOLU,KC_MNXT,      XXXXXXX,
	//├─────────┴───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┐   └───┬───┴───┬───┴───┬───┴───┬───┴───┬───┴───┬─────────┤
	   XXXXXXX      ,RGB_HUI,RGB_SAI,RGB_MOD,XXXXXXX,XXXXXXX,        XXXXXXX,KC_MPLY,KC_MUTE,XXXXXXX,XXXXXXX,  XXXXXXX,
	//├───────┬─────┴─┬─────┴─┬─────┴─┬─────┴───────┴───┬───┘   ┌───┴───────┴─────┬─┴───────┼───────┼───────┼─────────┤
	   XXXXXXX,XXXXXXX,_______,XXXXXXX,     XXXXXXX     ,             XXXXXXX     , _______ ,XXXXXXX,XXXXXXX,  XXXXXXX
	//└───────┴───────┴───────┴───────┴─────────────────┘       └─────────────────┴─────────┴───────┴───────┴─────────┘
	),
};
