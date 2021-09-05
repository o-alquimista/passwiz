# PassWiz
A random string generator.

It reads from `/dev/urandom`.

## Requirements
- Bash shell

## Usage
```sh
$ mv ./passwiz.sh ~/bin/passwiz
$ chmod +x ~/bin/passwiz
$ passwiz --help
```

```
Usage: passwiz [-h, --help] [-s SIZE, --size SIZE] [-c CONSTRAINT, --constraint CONSTRAINT]

PassWiz, a random string generator.

Options:
  -c, --constraint   Determines what type of characters can be used to make the string
  -s, --size         Select the size of the generated string (default: 20)
  -h, --help         Print this help, then exit

Character type constraints (--constraint argument):
  [1] Numeric
  [2] Alphabetical
  [3] Alphanumerical
  [4] Alphanumerical and punctuation (default)
```

## License
Copyright 2019-2021 Douglas Silva (0x9fd287d56ec107ac)

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

