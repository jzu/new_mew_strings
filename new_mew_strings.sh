#!/bin/bash

# new_mew_strings - https://github.com/jzu/new_mew_strings - MIT license
# Written for MyEtherWallet (https://www.myetherwallet.com/).
# Find missing MEW translation strings in app/scripts/translations/XX.js
# and display original en.js key:value pairs.
# -k simply displays keys.
# Example : 
# cd ~/git/etherwallet
# new_mew_strings.sh fr

LANG=C
LC_ALL=C

# Cleanup all temp files

trap "rm -f /tmp/mew.*.$$" 0 1 2 3 15

# Sanity checks

DIR=app/scripts/translations

if [ ! -f $DIR/en.js ]
then
  echo "Where are you?"
  exit 1
fi

if [ $# -eq 0 ] 
then
  echo "Usage: $0 [-k] target_language"
  exit 2
fi

if [ $1 = "-k" ]
then
  KEYS=1
  shift
fi

TARGET=$1

if [ ! -f $DIR/$TARGET.js ]
then
  echo "$1 doesn't exist. Possible arguments are:"
  ls $DIR \
  | sed 's/\.js//' \
  | egrep "^..$|^....$" \
  | xargs
  exit 3 
fi

# Find all translation keys in en.js

grep -P '[\t ]:[\t ]' $DIR/en.js \
| grep -v '^/' \
| sed 's/[[:space:]]*:.*//' \
| sort \
> /tmp/mew.en.$$

# Find all translation keys in $TARGET.js

grep -P '^[^:]*:[\t ]' $DIR/$TARGET.js \
| grep -v '^/' \
| sed 's/[[:space:]]*:.*//' \
| sort \
> /tmp/mew.$TARGET.$$

# Compare both and extract keys not in $TARGET

diff /tmp/mew.en.$$ /tmp/mew.$TARGET.$$ \
| grep '^<' \
| sed 's/^< //' \
| xargs \
| sed -e 's/ /|/g' \
      -e 's/^/"egrep_kludge|/' \
      -e 's/$/|egrep_kludge"/' \
> /tmp/mew.strings.$$

grep -q 'kludge||egrep' /tmp/mew.strings.$$ && \
  exit 9

# Print only missing keys if -k 

if [ "$KEYS" = "1" ]
then
  cat /tmp/mew.strings.$$ \
  | sed -e "s/|*egrep_kludge|*//g" \
        -e 's/"//g' \
        -e 's/|/\n/g'
  exit 0
fi

# Display key:value pairs in en.js with context

egrep -w -B 2 --color `cat /tmp/mew.strings.$$` $DIR/en.js

