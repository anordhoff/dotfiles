#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')

if [[ $class == 'playing' ]]; then
	info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
	if [[ ${#info} > 80 ]]; then
		info=$(echo $info | cut -c1-80)"..."
	fi
	text="${info}"
elif [[ $class == 'paused' ]]; then
	text='Spotify: paused'
elif [[ $class == 'stopped' ]]; then
	text='Spotify: stopped'
fi

echo -e "{\"text\":\"${text}\", \"class\":\"${class}\"}"
