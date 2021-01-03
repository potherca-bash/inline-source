# Inline `source`

Inline `source`-ed code.

## Installation

The advised installation method is using the [`bpkg` package manager][bpkg], as
this will allow versioning to be used.

Alternatively, the latest version of this project's main script can be 
downloaded directly:

```sh
curl -Lo- https://bpkg.pother.ca/inline-source/dist/inline_source
chmod +x inline_source
```

## Usage

This script will output a file for a given path, will all `sourced` files inlined.

```sh
inline_source <source-file>
```

For instance, given a file `a.sh` and file `b.sh` like this:

**a.sh**
```sh
#!/usr/bin/env bash

echo 'I am file A.'

source 'b.sh.'
```

**b.sh**
```sh
#!/usr/bin/env bash

echo 'I am file B.'
```

Calling `inline_source a.sh` will output:

```sh
#!/usr/bin/env bash

echo 'I am file A.'

echo 'I am file B.'
```

If a script sources files that are not in the `$PATH`, this will need to be 
resolved before calling `inline_source`:

```sh
export PATH="${PATH}:/path/to/sources" && inline_source a.sh
```

All that really happens is that the code of any file that is `sourced` in the
main script is placed inline.

This allows for a single script to be created for distribution purposes.

For instance, the distribution file in this repo was created by pipe-ing the
output to a file:

```sh
inline_source inline_source.sh > dist/inline_source
```

The script leaves everything "as-is", except for any shebang lines that it might
find. To clean things up, pipe this script through a formatter, for instance
[shfmt](https://github.com/mvdan/sh):

```sh
inline_source inline_source.sh | shfmt -i 2 -ci -s > dist/inline_source
```

## Development

This repository is set up like this:

```
    .
    ├── deps/       <-- Third-party dependencies
    ├── dist/       <-- Bundled distrubtion script
    ├── src/        <-- Source files
    ├── bpkg.json   <-- Package declaration
    └── README.md   <-- You are here
```

Dependencies needed by this project are managed through [`bpkg`][bpkg].

To install them (in the `deps/` folder) run:

```sh
bpkg getdeps
```

After that, edits can be made to files in the `src/` directory.

Finally, to create a single file containing all the source logic (this time
using a docker image for `shfmt`), run:

```sh
bash inline_source.sh inline_source.sh \
  | docker run -i --rm --volume="$PWD:/mnt" -w /mnt mvdan/shfmt -i 2 -ci -s \
  > dist/inline_source
```

This will create a distribution file in the `dist/` directory.

[bpkg]: https://github.com/bpkg/bpkg
