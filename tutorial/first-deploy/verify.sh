#!/usr/bin/bash

# URL to send the request to
URL="http://127.0.0.1:2482"

# Send a request to the URL
RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" $URL)

# Extract the body and the status code from the response
BODY=$(echo $RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')
STATUS=$(echo $RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

# If the status code is not 200, exit with code 1
if [ $STATUS -ne 200 ]; then
    echo "Error: Failed to reach $URL"
    exit 1
fi

# If the body is empty, exit with code 1
if [ -z "$BODY" ]; then
    echo "Error: No response from $URL"
    exit 1
fi

echo "Success: Received response from $URL"
exit 0