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

OPTS=`getopt -n 'passwiz' -o s:h --long size:,help -- "$@"`

# If "getopt" exits with an error, echo a message.
if [[ $? != 0 ]] ; then echo $parseError >&2 ; exit 1 ; fi

# Set default settings.
HELP=false
DEFAULT_SIZE=16
SIZE=16

# Retrieves the values passed with the options.
# It uses the count of arguments that were passed as a progress
# indicator, "shifting" back until the count reaches zero, which
# causes the loop to end.
while (( $# )); do
  case "$1" in
    -s | --size ) SIZE="$2"; shift 2 ;;
    -h | --help ) HELP=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

usage=$(cat << EOF
Usage: passwiz [-h, --help] [-s length, --size length]

PassWiz, a random password generator.

Options:
  -s, --size         Specify the size (integer) of the generated string
  -h, --help         Print this help, then exit

The default size of the resulting string is $DEFAULT_SIZE characters.
EOF
)

if [[ $HELP == true ]]; then
    printf "%s\n" "$usage"

    exit
fi

# Detects if the requested size is an integer.
if ! [[ $SIZE =~ ^[0-9]+$ ]]; then
    echo $parseError >&2

    exit 1
fi

printf "Your new password: \n\n"

# "tr" will limit what characters can be used, and "head" will limit the size
# of the resulting string.
strings /dev/urandom | tr -dc "[:alnum:][:punct:]" | head -c$SIZE; echo