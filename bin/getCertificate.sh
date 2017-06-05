#!/bin/bash
SERVER_NAME="$1"
PORT_NUMBER="$2"
STORE_DIR="`realpath ./`"
CERTIFICATE_FILE_NAME="$SERVER_NAME.cer"
CERTIFICATE_FILE_PATH="`realpath $STORE_DIR/$CERTIFICATE_FILE_NAME`"

if [ -z "$SERVER_NAME" ]; then
   echo "Server host name is empty !"
   exit 1
fi

if [ -z "$PORT_NUMBER" ]; then
   echo "Server port number is empty !"
   exit 1
fi

echo -n | openssl s_client -connect $SERVER_NAME:$PORT_NUMBER | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $CERTIFICATE_FILE_PATH
echo "Certificate saved to: $CERTIFICATE_FILE_PATH"