#!/bin/bash

#
# PassWiz, a random password generator.
#
# Copyright 2019 Douglas Silva (0x9fd287d56ec107ac)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

parseError="Failed parsing options. See --help."

opts=`getopt -n 'passwiz' -o c:s:h --long constraint:,size:,help -- "$@"`

# If getopt exits with an error, echo a message.
if [[ $? != 0 ]] ; then echo $parseError >&2 ; exit 1 ; fi

# Set default settings.
help=false
size=20
constraint=4

# Constraint options
readonly digit=1
readonly alpha=2
readonly alnum=3
readonly alnum_punct=4

# Retrieves the values passed with the arguments. It uses the count of
# arguments passed as a progress indicator, "shifting" back until the
# count reaches zero, which causes the loop to end.
while (( $# )); do
  case "$1" in
    -c | --constraint ) constraint="$2"; shift 2 ;;
    -s | --size ) size="$2"; shift 2 ;;
    -h | --help ) help=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

usage=$(cat << EOF
Usage: passwiz [-h, --help] [-s SIZE, --size SIZE] [-c CONSTRAINT, --constraint CONSTRAINT]

PassWiz, a random password generator.

Options:
  -c, --constraint   Determine what type of characters can be used to make the password
  -s, --size         Select the size of the generated string (default: 20)
  -h, --help         Print this help, then exit

Character type constraints (--constraint argument):
  [1] Numeric
  [2] Alphabetical
  [3] Alphanumerical
  [4] Alphanumerical and punctuation (default)
EOF
)

invalidConstraint="Invalid constraint. See --help."
invalidSize="Invalid size. See --help."

if [[ $help == true ]]; then
    printf "%s\n" "$usage"

    exit
fi

if ! [[ $size =~ ^[0-9]+$ ]]; then
    echo $invalidSize >&2

    exit 1
fi

case $constraint in
    $digit ) constraint="[:digit:]";;
    $alpha ) constraint="[:alpha:]";;
    $alnum ) constraint="[:alnum:]";;
    $alnum_punct ) constraint="[:alnum:][:punct:]";;
    * ) echo $invalidConstraint >&2; exit 1 ;;
esac

printf "Your new password: \n\n"
strings /dev/urandom | tr -dc $constraint | head -c$size; echo