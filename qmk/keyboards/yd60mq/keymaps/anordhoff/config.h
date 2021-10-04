/*
Copyright 2017 Danny Nguyen <danny@keeb.io>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once

// #define USE_I2C
#define EE_HANDS

/* #define TAPPING_TERM 160 */          /* Configure the global tapping term (default: 200ms) */
#define TAPPING_TERM 200          /* Configure the global tapping term (default: 200ms) */
#define TAPPING_TERM_PER_KEY      /* Enable granular control of the tapping term */
#define IGNORE_MOD_TAP_INTERRUPT  /* Prevent normal rollover on alphas from accidentally triggering mods */
#define TAPPING_FORCE_HOLD        /* Enable rapid switch from tap to hold, disables double tap hold auto-repeat */
#define PERMISSIVE_HOLD           /* Apply the modifier on keys that are tapped during a short hold of a modtap */

#define ONESHOT_TAP_TOGGLE 2  /* Tapping this number of times holds the key until tapped once again */
#define ONESHOT_TIMEOUT 1000  /* Time (in ms) before the one shot key is released */
