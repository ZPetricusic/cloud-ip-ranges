#!/bin/bash

# Constants
DATA_DIRECTORY="./data"
AWS_DIRECTORY="$DATA_DIRECTORY/aws"
AWS_RANGES_URL="https://ip-ranges.amazonaws.com/ip-ranges.json"
AWS_RANGES_FILE=$(echo -n "$AWS_RANGES_URL" | cut -d "/" -f 4)
AWS_API_GATEWAY_FILE="api_gateway.json"

# Amazon Web Services
if [[ ! -d AWS_DIRECTORY ]]; then
        echo "[*] Directory '$AWS_DIRECTORY' does not exist, creating"
        mkdir -p "$AWS_DIRECTORY"
        echo "[+] Directory '$AWS_DIRECTORY' created!"
else
        echo "[+] Directory '$AWS_DIRECTORY' exists"
fi

echo "[*] Fetching AWS ranges"
wget --no-if-modified-since -N -P "$AWS_DIRECTORY" "$AWS_RANGES_URL"
echo "[+] AWS ranges fetched"

## AWS gateway ranges
jq '.prefixes[] | select(.service == "API_GATEWAY")' "$AWS_DIRECTORY/$AWS_RANGES_FILE" > "$AWS_DIRECTORY/$AWS_API_GATEWAY_FILE"
