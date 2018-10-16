#! /usr/bin/env bash

function errorHandle {
	rm temp
	zenity --error --text="Decryption failed" --width=200
	exit 1
}

FileName=$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS

PWD=$(zenity --title="Encript or Decript File" --entry --text="Enter Password" --hide-text --width=300)

if [ -z $PWD ] ; then
	zenity --title="Canceled" --info --text="Processing was aborted" --width=200
	exit 1
fi

if [ $(strings $FileName | grep "Salted__") ]; then
	openssl aes-256-cbc -d -in $FileName -out temp -pass pass:$PWD || errorHandle
else
	openssl aes-256-cbc -e -in $FileName -out temp -pass pass:$PWD
fi

mv temp $FileName

exit 0



