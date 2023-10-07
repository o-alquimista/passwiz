# PassWiz
A random string generator and a passphrase (diceware) generator.

## Requirements
- GNU/Linux
- Bash shell

### Build requirements
- GNU make
- C compiler (e.g. GNU C Compiler)
- libsodium headers (`libsodium-dev` on Debian)

## Installation
```sh
make

# then as root, to install in /usr/local
make install
```

## Usage
```sh
passwiz --help

# Generate a 6-word passphrase
passphrase
```

## License
Copyright 2019-2023 Douglas Silva (0x9fd287d56ec107ac)

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

