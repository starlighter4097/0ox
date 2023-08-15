#Bash Script to share files via 0x0.st (https://0x0.st) and zenity to select files

#!/bin/bash

#Check if zenity is installed
if ! command -v zenity &> /dev/null
then
    echo "zenity could not be found"
    exit
fi
#
##Check if curl is installed
if ! command -v curl &> /dev/null
then
    echo "curl could not be found"
    exit
fi

if ! command -v qrencode &> /dev/null
then 
	echo "qrencode not installed, please install qrencode "
	exit
fi


#Select file to upload
sudo apt install qrencode
FILE=$(zenity --file-selection --title="Select file to upload")

#Upload file
URL=$(curl -s -F "file=@$FILE" https://0x0.st)

#Copy URL to clipboard using wl-copy
echo $URL | wl-copy 

#Show URL
zenity --info --text="URL copied to clipboard: $URL"
qrencode -s 9 -l H -o "/tmp/URL.png" "$URL"
#Open URL in browser
xdg-open URL.png

