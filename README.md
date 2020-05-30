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

Potential white flash fix: https://github.com/darkreader/darkreader/issues/1219

#### dark reader

Add the following snippet under `CSS` add the top of `Dev tools`:

```
* {
    scrollbar-color: #3d4143 transparent;
}
```

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
```

#### wayland

Add the following line to `~/.pam_environment`:
```
MOZ_ENABLE_WAYLAND=1
```

## font

Icons for desktop apps (such as waybar) are pulled from the Font Awesome icon pack (`ttf-font-awesome` arch package)

## keyboard

The keyboard layout is a modified version of Colemak (with DH, wide, and angle mods), and a customized third level that can be accessed using the `AltGr` key.

```sudo ln -s $HOME/.dotfiles/xkb/custom /usr/share/X11/xkb/symbols/.```

#### ANSI

```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━┓
│  ~  │  !  │  @  │  #  │  $  │  %  │  _  │  +  │  ^  │  &  │  *  │  (  │  )  ┃         ┃
│  `  │  1  │  2  │  3  │  4  │  5  │  -  │  =  │  6  │  7  │  8  │  9  │  0  ┃Backspace┃
┢━━━━━┷━┱───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┺━┯━━━━━━━┦
┃       ┃  Q  │ W { │ F } │ P + │ B | │  {  │  J  │  L  │  U  │  Y  │  :  │  "  │   |   │
┃ Tab   ┃  q  │ w { │ f } │ p + │ b | │  [  │  j  │  l  │  u  │  y  │  ;  │  '  │   \   │
┣━━━━━━━┻┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┲━━━━┷━━━━━━━┧
┃        ┃ A [ │ R ] │ S = │ T _ │ G \ │  }  │  K  │  N  │  E  │  I  │  O  ┃            ┃
┃Backspc.┃ a [ │ r ] │ s = │ t _ │ g \ │  ]  │  k  │  n  │  e  │  i  │  o  ┃      Enter ┃
┣━━━━━━━━┻━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┲━━┻━━━━━━━━━━━━┫
┃           ┃ X ` │ C ~ │ D - │  V  │  Z  │  ?  │  M  │  H  │  <  │  >  ┃               ┃
┃ Shift     ┃ x ` │ c ~ │ d - │  v  │  z  │  /  │  m  │  h  │  ,  │  .  ┃         Shift ┃
┣━━━━━━━┳━━━┻━━┳━━┷━━━┱─┴─────┴─────┴─────┴─────┴─────┴──┲━━┷━━━┳━┷━━━━┳┻━━━━━┳━━━━━━━━━┫
┃       ┃      ┃      ┃                                  ┃      ┃      ┃      ┃         ┃
┃ Meta  ┃ Alt  ┃ Ctrl ┃              Space               ┃AltGr ┃ Meta ┃  Fn  ┃    Ctrl ┃
┗━━━━━━━┻━━━━━━┻━━━━━━┹──────────────────────────────────┺━━━━━━┻━━━━━━┻━━━━━━┻━━━━━━━━━┛
```

#### Iris

```
                  ┌─────┐                                           ┌─────┐
            ┌─────┤  #  ├─────┐                               ┌─────┤  *  ├─────┐
┏━━━━━┱─────┤  @  │  3  │  $  ├─────┐                   ┌─────┤  &  │  8  │  (  ├─────┬─────┐
┃     ┃  !  │  2  ├─────┤  4  │  %  │                   │  ^  │  7  ├─────┤  9  │  )  │  |  │
┃ Esc ┃  1  ├─────┤ F } ├─────┤  5  │                   │  6  ├─────┤  U  ├─────┤  0  │  \  │
┣━━━━━╉─────┤ W { │ f } │ P + ├─────┤                   ├─────┤  L  │  u  │  Y  ├─────┼─────┤
┃     ┃  Q  │ w { ├─────┤ p + │ B | │                   │  J  │  l  ├─────┤  y  │  :  │  "  │
┃ Tab ┃  q  ├─────┤ S = ├─────┤ b | │                   │  j  ├─────┤  E  ├─────┤  ;  │  '  │
┣━━━━━╉─────┤ R ] │ s = │ T _ ├─────┤                   │─────┤  N  │  e  │  I  ├─────╆━━━━━┪
┃     ┃ A [ │ r ] ├─────┤ t _ │ G \ │                   │  K  │  n  ├─────┤  i  │  O  ┃     ┃
┃Bksp ┃ a [ ├─────┤ C ~ ├─────┤ g \ │                   │  k  ├─────┤  <  ├─────┤  o  ┃Enter┃
┣━━━━━╉─────┤ X ` │ c ~ │ D - ├─────┤                   │─────┤  H  │  ,  │  >  ├─────╊━━━━━┫
┃     ┃  Z  │ x ` ├─────┤ d - │  V  │ ┏━━━━━┓   ┏━━━━━┓ │  M  │  h  ├─────┤  .  │  ?  ┃     ┃
┃Shift┃  z  ├─────┘     └─────┤  v  │ ┃     ┃   ┃     ┃ │  m  ├─────┘     └─────┤  /  ┃Shift┃
┗━━━━━┹─────┘                 └─────┘ ┃     ┃   ┃     ┃ └─────┘                 └─────┺━━━━━┛
                          ┏━━━━━┳━━━━━┫     ┃   ┃     ┣━━━━━┳━━━━━┓
                          ┃     ┃     ┃Space┃   ┃  Fn ┃     ┃     ┃
                          ┃ Alt ┃Ctrl ┃     ┃   ┃     ┃AltGr┃ Meta┃
                          ┗━━━━━┻━━━━━┻━━━━━┛   ┗━━━━━┻━━━━━┻━━━━━┛
```

## screen sharing

The following steps only enable screen sharing for chromium

#### installation

```
sudo pacman -S chromium pipewire xdg-desktop-portal libpipewire02
yay -S xdg-desktop-portal-wlr-git
```

#### setup

Add the following lines to ~/.pam_environment:

```
XDG_SESSION_TYPE=wayland
XDG_CURRENT_DESKTOP=sway
```

Ensure `pipewire.service` and `pipewire.socket` are running:

```
systemctl --user status pipewire.service
systemctl --user status pipewire.socket
```

Enable `WebRTC PipeWire support` on chromium: `chrome://flags/#enable-webrtc-pipewire-capturer`

## neovim

#### vim-go

edit `~/.local/share/nvim/plugged/vim-go/autoload/fzf/decls.vim`

change lines 136 and 148:
```
...
" let normal_bg = s:code("Normal", "bg")
let normal_bg = s:code("CursorLine", "bg")
...
" \ 'options': '-n 1 --ansi --prompt "GoDecls> " --expect=ctrl-t,ctrl-v,ctrl-x'.colors,
\ 'options': '-n 1 --ansi --prompt "GoDecls> " --expect=ctrl-t,ctrl-v,ctrl-s'.colors,
...
```
