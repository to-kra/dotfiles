# dotfiles
This is my personal `dotfiles` project for MacOs &amp; Ubuntu Linux.
I was tired of always setting up of new environment, so I decided to make it automated everytime new machine comes up.
I know there are lots of such projects, but I wanted to make my own to improve & learn more shell/bash scripting skills. :-)

## How to:
1. Clone this repository (e.g. into `/Users/tokra/github/`)
1. After clone open terminal and run this script (it's located in root of cloned repo): `run.sh`
1. Next time you open terminal, it will fire installation of all things

## Supports (MacOs):
* Homebrew
* Homebrew Cask
* Caskroom Versions
* NPM
* Yarn

## Unit tests:
* [Nov2017] Started using [Bats: Bash Automated Testing System](https://github.com/sstephenson/bats) for testing my utils/helpers scripts. 

## Change log:
* [2017-Nov-17]: Bats unit tests
* [2017-Nov-19]: Added exporting app homes using brew/cask
* [2017-Nov-19]: moved exporting paths out of .bash_profile to paths.sh
* [2017-Nov-19]: refactor/update of hombrewTools.sh
