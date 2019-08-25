# PassWiz
A random password generator written in Bash

PassWiz uses `/dev/urandom` as its default source of randomness.

# Usage
```
passwiz [-m method_name,--method method_name] [-s integer,--size integer]
```

The currently supported methods are:
- `urandom`: /dev/urandom on GNU/Linux
- `gpg`: GnuPG

The default size is 16 characters long.

# Method "urandom"
Creates passwords containing uppercase and lowercase alphanumeric characters and punctuation.

# License
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
