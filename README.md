# MudCore, a simple MUD server

[![builds.sr.ht status](https://builds.sr.ht/~jack/mudcore.svg)](https://builds.sr.ht/~jack/mudcore?)

MudCore is a simple MUD server. Game logic is implemented in lua,
telnet handling is done for you, and the server can communicate with
the outside world by way of ZeroMQ sockets.

**NOTE:** MudCore is not under active development. I consider it
feature-complete, but never built a game atop it.


## Building MudCore

### Nix

The easiest way to build MudCore is with
[Nix](https://nixos.org/nix/):

```
nix build # With Nix >=2.4, and flakes enabled
nix-build # Equivalent old-style command
```

You can then run `./result/bin/mudcore` from the project root; this
will start a server using the example `boot.lua` script.

You can also install it into your local environment:

```
# Nix >=2.4, flakes enabled:
nix profile install git+https://git.sr.ht/~jack/mudcore

nix-env -f . -i # Equivalent old-style command
```

### Other Systems

#### Prerequisites

Beyond fundamental build tools (like you'd get with debian's
`build-essential`), you will need:

* GLib (debian: `libglib2.0-dev`)
* libtelnet (debian: `libtelnet-dev`)
* lua 5.2 (debian: `liblua5.2-dev`)
* pkg-config (debian: `pkg-config`)
* ZeroMQ >= 4.0.4 (debian: `libzmq3-dev`)

If you are building from git, you will also need:

* autoconf
* automake

If you want to build documentation, you will also need:

* texinfo
* texlive (if you want to a pdf/ps/dvi manual)

#### Building

If you are building from git, first run `autoreconf -i`.

Building from source is the usual `./configure && make && sudo make
install` dance. The server runs just fine without being installed by
`make install`, if you don't want to install it.


## Documentation

The full documentation for MudCore is maintained as a Texinfo
manual. It is built as part of a normal run of `make`, and if you do
not install it, you can read it after building by loading
`doc/mudcore.info` into your info reader.

If you want documentation in other formats, try running `make pdf` or
`make html`. Similarly, `make install-pdf` or `make install-html` will
install documentation.


## Hacking on MudCore

If you are developing a game, you should not need to modify the C
code. If you want to hack on MudCore itself, you can either install
dependencies by hand, or if you use Nix, run one of the following commands:

```
nix develop # Nix >=2.4, flakes enabled
nix-shell # Equivalent old-style command
```

To build a tarball for a release, run `make distcheck`.
