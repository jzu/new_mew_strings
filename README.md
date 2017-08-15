# new_mew_strings

Finds missing strings in [translation files](https://github.com/kvhnuke/etherwallet/tree/mercury/app/scripts/translations) 
for [MyEtherWallet](https://www.myetherwallet.com/).

Checks the file in a given language against en.js, extracts newly created key:value pairs, displays them (key is colorized) in context (2 previous lines).

Use it at the root of the repo, e.g. `~/git/etherwallet/`. It takes one mandatory language argument: two or four (for zhcn and zhtw) letters.

The `-k` option simply displays the missing keys.
