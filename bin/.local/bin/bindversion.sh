#!/bin/bash

# queries all nameservers of a given domain for their bind version
# usage: ./bindversion.sh "foo.com"

HOST="$1"
NAMESERVERS=`dig +nocmd -t NS "$1" +noall +answer | awk '{ print $5 }' | sed 's/.$//'`
while IFS= read -r ns; do
  echo "Nameserver: $ns"
  echo -e "Version: " `dig "@${ns}" version.bind txt CHAOS +short` "\n"
done <<< "$NAMESERVERS"
