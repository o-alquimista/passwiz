# PassWiz
A random password generator written in Bash.

## Usage
```
Usage: passwiz [-m method_name,--method method_name] [-s length,--size length]

Options:
  -m, --method       specify a method for generating random characters
  -s, --size         specify the size of the generated string (use integer)
  -h, --help         print this help, then exit
  -v, --version      print version number, then exit

Methods:
  - urandom (default; uses /dev/urandom)
  - gpg

The default size of the resulting string is 16.
```

## Method "urandom"
Creates passwords containing uppercase and lowercase alphanumeric characters and punctuation.

## License
Copyright 2019 Douglas Silva (0x9fd287d56ec107ac)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
