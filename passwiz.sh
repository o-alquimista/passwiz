#!/bin/bash

#
# PassWiz, a random string generator.
#
# Copyright 2019-2023 Douglas Silva (0x9fd287d56ec107ac)
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

opts=$(getopt \
  --name 'passwiz' \
  --options c:s:hv \
  --longoptions constraint:,size:,help,version \
  -- "$@")

if [[ $? -ne 0 ]]; then
    echo "Failed parsing options. See --help." >&2;
    exit 1;
fi

readonly VERSION_TAG="v2.1.0"

# Constraint options
readonly CONSTRAINT_DIGIT=1
readonly CONSTRAINT_ALPHA=2
readonly CONSTRAINT_ALNUM=3
readonly CONSTRAINT_ALNUM_PUNCT=4

# Set default settings
help=false
version=false
size=20
constraint=$CONSTRAINT_ALNUM_PUNCT

# Retrieves the values passed with the arguments. It uses the count of
# arguments passed as a progress indicator, "shifting" back until the
# count reaches zero, which causes the loop to end.
while (( $# )); do
  case "$1" in
    -c | --constraint ) constraint="$2"; shift 2 ;;
    -s | --size ) size="$2"; shift 2 ;;
    -h | --help ) help=true; shift ;;
    -v | --version ) version=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

usage=$(cat << EOF
Usage: passwiz [-v, --version] [-h, --help] [-s SIZE, --size SIZE] [-c CONSTRAINT, --constraint CONSTRAINT]

PassWiz, a random string generator.

Options:
  -c, --constraint   Determines what type of characters can be used to make the string
  -s, --size         Select the size of the generated string (default: 20)
  -h, --help         Print this help, then exit
  -h, --version      Print the version tag, then exit

Character type constraints (--constraint argument):
  [1] Numeric
  [2] Alphabetical
  [3] Alphanumerical
  [4] Alphanumerical and punctuation (default)
  [5] Other - specify which characters are allowed; see "man tr" for format)
EOF
)

if [[ $help == true ]]; then
    printf "%s\n" "$usage"
    exit
fi

if [[ $version == true ]]; then
    echo $VERSION_TAG
    exit
fi

if ! [[ $size =~ ^[0-9]+$ ]]; then
    echo "Invalid size. See --help." >&2
    exit 1
fi

# see: man tr
case $constraint in
    $CONSTRAINT_DIGIT ) constraint="[:digit:]";;
    $CONSTRAINT_ALPHA ) constraint="[:alpha:]";;
    $CONSTRAINT_ALNUM ) constraint="[:alnum:]";;
    $CONSTRAINT_ALNUM_PUNCT ) constraint="[:alnum:][:punct:]";;
    * ) constraint="$constraint";;
esac

# This is where the string is retrieved, using the same method
# password-store v1.7.4 uses (read from process substitution)
read -r -n $size string < <(LC_ALL=C tr -dc "$constraint" < /dev/urandom)

echo "$string"
