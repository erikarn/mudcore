{ name, src }:
{ autoreconfHook, git, glib, libtelnet, lua, pkgconfig, runCommand,
  stdenv, texinfo, zeromq }:

stdenv.mkDerivation {
  inherit name src;

  nativeBuildInputs = [ autoreconfHook pkgconfig texinfo ];
  buildInputs = [ glib libtelnet lua zeromq ];

  meta = with stdenv.lib; {
    homepage = https://git.sr.ht/~jack/mudcore;
    description = "A minimal, lua-scripted MUD server";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.endgame ];
    platforms = platforms.all;
  };
}
