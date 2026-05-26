#!/usr/bin/env bash

set -e

IP="$2"

COLOR=$(tput setaf 4)
SEC_COLOR=$(tput setaf 5)
RESET_COLOR=$(tput sgr0)

LINK="https://ipinfo.io/$IP"

IP_CMD=$(curl --silent $LINK | jq -r ".ip")
CITY=$(curl --silent $LINK | jq -r ".city")
REGION=$(curl --silent $LINK | jq -r ".region")
COUNTRY=$(curl --silent $LINK | jq -r ".country")
LOC=$(curl --silent $LINK | jq -r ".loc")
ORG=$(curl --silent $LINK | jq -r ".org")
POSTAL=$(curl --silent $LINK | jq -r ".postal")
TZ=$(curl --silent $LINK | jq -r ".timezone")

while getopts 'cropta:' OPTION; do
  case  "$OPTION" in
    c)
        echo "$COLOR[+] City :$RESET_COLOR $CITY"
        echo "$COLOR[+] Country :$RESET_COLOR $COUNTRY"
        ;;
    r)
        echo "$COLOR[+] Region :$RESET_COLOR $REGION"
        ;;
    o)
        echo "$COLOR[+] Organization :$RESET_COLOR $ORG"
        ;;
    p)
        echo "$COLOR[+] Postal Code :$RESET_COLOR $POSTAL"
        ;;
    t)
        echo "$COLOR[+] Timezone :$RESET_COLOR $TZ"
        ;;
    a)
        echo "$SEC_COLOR+------------------- Full Infos ------------------------+$RESET_COLOR"
        echo "$COLOR[+] IP :$RESET_COLOR $IP"
        echo "$COLOR[+] City :$RESET_COLOR $CITY"
        echo "$COLOR[+] Region :$RESET_COLOR $REGION"
        echo "$COLOR[+] Country :$RESET_COLOR $COUNTRY"
        echo "$COLOR[+] Location :$RESET_COLOR $LOC"
        echo "$COLOR[+] Organization :$RESET_COLOR $ORG"
        echo "$COLOR[+] Postal Code :$RESET_COLOR $POSTAL"
        echo "$COLOR[+] Timezone :$RESET_COLOR $TZ"
        echo "$SEC_COLOR+-------------------------------------------------------+$RESET_COLOR"
        ;;
    ?)
        echo "
        Usage: ipinfo [OPTION]... [IP]
          Gets a partial or a full report about an IP or your IP.

            -c : Displays city and country from the IP.
            
            -r : Displays region from the IP.

            -o : Displays organization from the IP.   

            -p : Displays the postal code from the IP.

            -t : Displays the timezone from the IP.

            -a : Displays a full report about the IP.
        
        " >&2
        exit 1
        ;;
  esac
done
