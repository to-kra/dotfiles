#!/bin/sh
# Examples:
# ./image64.sh myImage.png
#   outputs: data:image/png;base64,xxxxx
# ./image64.sh myImage.png -img
#   outputs: <img src="data:image/png;base64,xxxxx">

filename=$(basename $1)
xtype=${filename##*.}
append=""
if [ $xtype == gif ]; then
    append="data:image/gif;base64,";
    elif [ $xtype == jpeg ] || [ $xtype == jpg ]; then
    append="data:image/jpeg;base64,";
    elif [ $xtype == png ]; then
    append="data:image/png;base64,";
    elif [ $xtype == svg ]; then
    append="data:image/svg+xml;base64,";
    elif [ $xtype == ico ]; then
    append="data:image/vnd.microsoft.icon;base64,";
fi

#Mathias Bynens - http://superuser.com/questions/120796/os-x-base64-encode-via-command-line
data=$(openssl base64 < $1 | tr -d '\n')

if [ "$#" -eq 2 ] && [ $2 == -img ]; then
    data=\<img\ src\=\"$append$data\"\>
else
    data=$append$data
fi

echo $data | pbcopy

echo "copied to clipboard"