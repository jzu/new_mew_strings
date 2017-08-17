# new_mew_strings

Finds missing strings in [translation files](https://github.com/kvhnuke/etherwallet/tree/mercury/app/scripts/translations) 
for [MyEtherWallet](https://www.myetherwallet.com/).

Checks the file in a given language against en.js, extracts newly created key:value pairs, displays them (key is colorized) in context (2 previous lines).

Use it at the root of the repo, e.g. `~/git/etherwallet/`. It takes one mandatory language argument: two or four (for zhcn and zhtw) letters.

The `-k` option simply displays the missing keys.

Giving a wrong language argument display all possible languages.

Check all languages at once (as of August 2017):

`for i in ar de el en es fi fr ht hu id it ja ko nl no pl pt ru sk sl sv tr vi zhcn zhtw; do echo "$i :" ; ../new_mew_strings/new_mew_strings.sh $i; done`

