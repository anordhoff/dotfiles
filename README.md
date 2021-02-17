# dotfiles

My `.dotfiles` repository for Arch Linux

```
git clone https://github.com/anordhoff/dotfiles.git $HOME/.dotfiles
```

#### macOS

See [macos/](macos/)

#### windows

See [windows/](windows/)

## audio

with headphones disconnected:

```
amixer -c 0 set Speaker 100%
amixer -c 0 set Speaker unmute
amixer -c 0 set Headphone 0%
amixer -c 0 set Headphone mute
```

with headphones connected:

```
amixer -c 0 set Speaker 0%
amixer -c 0 set Speaker mute
amixer -c 0 set Headphone 100%
amixer -c 0 set Headphone unmute
```

#### bluetooth

See https://wiki.archlinux.org/index.php/Bluetooth_headset#Configuration_via_CLI and https://wiki.archlinux.org/index.php/Bluetooth_headset#Apple_Airpods_have_low_volume

```
pacmd list-sinks
pactl set-sink-volume name_of_bluetooth_speaker x%
```

If there is no sound, try disconnecting, executing `sudo pkill pulseaudio`, and reconnecting

## firefox

Firefox theme: https://github.com/overdodactyl/ShadowFox

#### white flash

userChrome.css
```
/* Uses color from theme_colors if available */
#tabbrowser-tabpanels{
  background-color: var(--uc-light-bkgnd-color,rgb(32,32,34)) !important;
}
```

userContent.css
```
/* New Tab Flash */
@namespace url("http://www.w3.org/1999/xhtml");
@-moz-document url("about:home"),url("about:blank"),url("about:newtab"),url("about:privatebrowsing") {
  html:not(#ublock0-epicker),
  html:not(#ublock0-epicker) body {
    background-color: rgb(32, 32, 34) !important;
  }
}
@-moz-document ("about:privatebrowsing") {
  .search-handoff-button {
    background-color: rgba(100, 100, 100, 0.1) !important;
  }
  .fake-textbox {
    color: rgb(200, 200, 200) !important;
  }
}
```

#### dark reader

Add the following snippet under `CSS` add the top of `Dev tools`:

```
* {
    scrollbar-color: #3d4143 transparent;
}
```
#### rearrange tabs

Move selected tab(s) left: Alt + E

Move selected tab(s) right: Alt + I

Move selected tab(s) to the end: Alt + O

Move selected tab(s) to the front: Alt + N

#### vimium

Vimium extension mappings:

```
# Insert your preferred key mappings here.
map n scrollLeft
map e scrollDown
map i scrollUp
map o scrollRight
map zN scrollToLeft
map zO scrollToRight
map N goBack
map E previousTab
map I nextTab
map O goForward
map s LinkHints.activateMode
map S LinkHints.activateModeToOpenInNewTab
map <a-s> LinkHints.activateModeWithQueue
map f performFind
map F performBackwardsFind
map a Vomnibar.activate
map A Vomnibar.activateInNewTab
map q enterInsertMode
```

Characters used for link hints: `arstneio`

Enable `Don't let pages steal the focus on load`

Theme: https://github.com/ysjn/vimium-simply-dark

- change color from hotpink to cadetblue
- remove the block `#vimiumHintMarkerContainer div > .matchingCharacter ~ span {`
- change `opacity: 0.4;` to `color: cadetblue`

#### wayland

Add the following line to `~/.pam_environment`:
```
MOZ_ENABLE_WAYLAND=1
```

## font

Icons for desktop apps (such as waybar) are pulled from the Font Awesome icon pack (`ttf-font-awesome` arch package) (`fontawesome-fonts` fedora package)

San Francisco fonts can be cloned and installed from https://github.com/AppleDesignResources/SanFranciscoFont and https://www.cufonfonts.com/font/sf-mono

## keyboard

The keyboard layout is a modified version of Colemak (with DH, wide, and angle mods), and a symbol layer that can be accessed using the `Hyper`/`Lower` key (the `Raise` key is for Iris specific controls)

```sudo ln -s $HOME/.dotfiles/xkb/custom /usr/share/X11/xkb/symbols/.```

Install evscript to make hyper send escape when tapped on linux: https://github.com/unrelentingtech/evscript

#### ANSI

```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━┓
│     │  !  │  @  │  #  │  $  │  %  │     │     │  ^  │  &  │  *  │  (  │  )  ┃         ┃
│ Esc │  1  │  2  │  3  │  4  │  5  │     │     │  6  │  7  │  8  │  9  │  0  ┃ Capslock┃
┢━━━━━┷━┱───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┺━┯━━━━━━━┦
┃       ┃  Q  │  W  │  F  │  P  │  B  │     │  J  │  L  │  U  │  Y  │  :  │  "  │       │
┃ Tab   ┃  q  │  w  │  f  │  p  │  b  │     │  j  │  l  │  u  │  y  │  ;  │  '  │       │
┣━━━━━━━┻┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┲━━━━┷━━━━━━━
┃        ┃  A  │  R  │  S  │  T  │  G  │     │  M  │  N  │  E  │  I  │  O  ┃            ┃
┃Backspce┃  a  │  r  │  s  │  t  │  g  │     │  m  │  n  │  e  │  i  │  o  ┃      Enter ┃
┣━━━━━━━━┻━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┲━━┻━━━━━━━━━━━━┫
┃           ┃  X  │  C  │  D  │  V  │  Z  │  ?  │  K  │  H  │  <  │  >  ┃               ┃
┃ Shift     ┃  x  │  c  │  d  │  v  │  z  │  /  │  k  │  h  │  ,  │  .  ┃         Shift ┃
┣━━━━━━━┳━━━┻━━┳━━┷━━━┱─┴─────┴─────┴─────┴─────┴─────┴──┲━━┷━━━┳━┷━━━━┳┻━━━━━┳━━━━━━━━━┫
┃       ┃      ┃      ┃                                  ┃      ┃      ┃      ┃         ┃
┃       ┃ Alt  ┃ Ctrl ┃              Space               ┃ Hyper┃ Meta ┃      ┃         ┃
┗━━━━━━━┻━━━━━━┻━━━━━━┹──────────────────────────────────┺━━━━━━┻━━━━━━┻━━━━━━┻━━━━━━━━━┛
```

```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━┓
│     │     │     │     │     │     │     │     │     │     │     │     │     ┃         ┃
│ F12 │ F1  │ F2  │ F3  │ F4  │ F5  │     │     │  F6 │  F7 │  F8 │  F9 │ F10 ┃     F11 ┃
┢━━━━━┷━┱───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┺━┯━━━━━━━┦
┃       ┃     │     │     │     │     │     │     │     │     │     │     │     │       │
┃ Tab   ┃     │  ~  │  =  │  +  │  |  │     │ PSCR│ INS │ HOME│ PGUP│     │     │       │
┣━━━━━━━┻┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┲━━━━┷━━━━━━━┧
┃        ┃     │     │     │     │     │     │     │     │     │     │     ┃            ┃
┃Backspce┃  [  │  ]  │  -  │  _  │  \  │     │ PAUS│  🠔  │  🠗  │  🠕  │  🠖  ┃      Enter ┃
┣━━━━━━━━┻━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┲━━┻━━━━━━━━━━━━┫
┃           ┃     │     │     │     │     │     │     │     │     │     ┃               ┃
┃ Shift     ┃  `  │  {  │  }  │     │     │     │     │ DEL │ END │ PGDN┃         Shift ┃
┣━━━━━━━┳━━━┻━━┳━━┷━━━┱─┴─────┴─────┴─────┴─────┴─────┴──┲━━┷━━━┳━┷━━━━┳┻━━━━━┳━━━━━━━━━┫
┃       ┃      ┃      ┃                                  ┃      ┃      ┃      ┃         ┃
┃       ┃ Alt  ┃ Ctrl ┃              Space               ┃ Hyper┃ Meta ┃      ┃         ┃
┗━━━━━━━┻━━━━━━┻━━━━━━┹──────────────────────────────────┺━━━━━━┻━━━━━━┻━━━━━━┻━━━━━━━━━┛
```

#### Iris

```
                  ┌─────┐                                           ┌─────┐
            ┌─────┤  #  ├─────┐                               ┌─────┤  *  ├─────┐
┏━━━━━┱─────┤  @  │  3  │  $  ├─────┐                   ┌─────┤  &  │  8  │  (  ├─────┬─────┐
┃     ┃  !  │  2  ├─────┤  4  │  %  │                   │  ^  │  7  ├─────┤  9  │  )  │     │
┃ Esc ┃  1  ├─────┤  F  ├─────┤  5  │                   │  6  ├─────┤  U  ├─────┤  0  │ Caps│
┣━━━━━╉─────┤  W  │  f  │  P  ├─────┤                   ├─────┤  L  │  u  │  Y  ├─────┼─────┤
┃     ┃  Q  │  w  ├─────┤  p  │  B  │                   │  J  │  l  ├─────┤  y  │  :  │  "  │
┃ Tab ┃  q  ├─────┤  S  ├─────┤  b  │                   │  j  ├─────┤  E  ├─────┤  ;  │  '  │
┣━━━━━╉─────┤  R  │  s  │  T  ├─────┤                   │─────┤  N  │  e  │  I  ├─────╆━━━━━┪
┃     ┃  A  │  r  ├─────┤  t  │  G  │                   │  M  │  n  ├─────┤  i  │  O  ┃     ┃
┃Bksp ┃  a  ├─────┤  C  ├─────┤  g  │                   │  m  ├─────┤  <  ├─────┤  o  ┃Enter┃
┣━━━━━╉─────┤  X  │  c  │  D  ├─────┤                   │─────┤  H  │  ,  │  >  ├─────╊━━━━━┫
┃     ┃  Z  │  x  ├─────┤  d  │  V  │ ┏━━━━━┓   ┏━━━━━┓ │  K  │  h  ├─────┤  .  │  ?  ┃     ┃
┃Shift┃  z  ├─────┘     └─────┤  v  │ ┃     ┃   ┃     ┃ │  k  ├─────┘     └─────┤  /  ┃Shift┃
┗━━━━━┹─────┘                 └─────┘ ┃Qwrty┃   ┃Colmk┃ └─────┘                 └─────┺━━━━━┛
                          ┏━━━━━┳━━━━━╋━━━━━┫   ┣━━━━━╋━━━━━┳━━━━━┓
                          ┃     ┃     ┃     ┃   ┃     ┃     ┃     ┃
                          ┃ Alt ┃Ctrl ┃Space┃   ┃Raise┃Lower┃ Meta┃
                          ┗━━━━━┻━━━━━┻━━━━━┛   ┗━━━━━┻━━━━━┻━━━━━┛
```

```
                  ┌─────┐                                           ┌─────┐
            ┌─────┤     ├─────┐                               ┌─────┤     ├─────┐
┏━━━━━┱─────┤     │ F3  │     ├─────┐                   ┌─────┤     │  F8 │     ├─────┬─────┐
┃     ┃     │ F2  ├─────┤ F4  │     │                   │     │  F7 ├─────┤  F9 │     │     │
┃ F12 ┃ F1  ├─────┤     ├─────┤ F5  │                   │  F6 ├─────┤     ├─────┤ F10 │ F11 │
┣━━━━━╉─────┤     │  =  │     ├─────┤                   ├─────┤     │ HOME│     ├─────┼─────┤
┃     ┃     │  ~  ├─────┤  +  │     │                   │     │ INS ├─────┤ PGUP│     │     │
┃ Tab ┃     ├─────┤     ├─────┤  |  │                   │ PSCR├─────┤     ├─────┤     │     │
┣━━━━━╉─────┤     │  -  │     ├─────┤                   │─────┤     │  🠗  │     ├─────╆━━━━━┪
┃     ┃     │  ]  ├─────┤  _  │     │                   │     │  🠔  ├─────┤  🠕  │     ┃     ┃
┃Bksp ┃  [  ├─────┤     ├─────┤  \  │                   │ PAUS├─────┤     ├─────┤  🠖  ┃Enter┃
┣━━━━━╉─────┤     │  {  │     ├─────┤                   │─────┤     │ END │     ├─────╊━━━━━┫
┃     ┃     │  `  ├─────┤  }  │     │ ┏━━━━━┓   ┏━━━━━┓ │     │ DEL ├─────┤ PGDN│     ┃     ┃
┃Shift┃     ├─────┘     └─────┤     │ ┃     ┃   ┃     ┃ │     ├─────┘     └─────┤     ┃Shift┃
┗━━━━━┹─────┘                 └─────┘ ┃Qwrty┃   ┃Colmk┃ └─────┘                 └─────┺━━━━━┛
                          ┏━━━━━┳━━━━━╋━━━━━┫   ┣━━━━━╋━━━━━┳━━━━━┓
                          ┃     ┃     ┃     ┃   ┃     ┃     ┃     ┃
                          ┃ Alt ┃Ctrl ┃Space┃   ┃Raise┃Lower┃ Meta┃
                          ┗━━━━━┻━━━━━┻━━━━━┛   ┗━━━━━┻━━━━━┻━━━━━┛
```

## neovim

#### vim-go

edit `~/.local/share/nvim/plugged/vim-go/autoload/fzf/decls.vim`

change lines 47, 134, and 146:
```
let cmd = get({'ctrl-s': 'split',
...
let normal_bg = s:code("CursorLine", "#222222")
...
\ 'options': printf('-n 1 --with-nth 1,2 --delimiter=$''\t'' --preview "echo {3}" --ansi --prompt "GoDecls> " --expect=ctrl-t,ctrl-v,ctrl-s%s', colors),
...
```

## xdg

For the sake of being explicit, add the following to /etc/profile.d/xdg.sh:

```
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg
```
