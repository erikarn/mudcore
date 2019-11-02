{ name, src }:
{ autoreconfHook, git, glib, libtelnet, lua, pkgconfig, stdenv,
  texinfo, zeromq }:

stdenv.mkDerivation {
  inherit name src;

  buildInputs = [ glib libtelnet lua zeromq ];
  nativeBuildInputs = [ autoreconfHook pkgconfig texinfo ];

  meta = with stdenv.lib; {
    homepage = https://git.sr.ht/~jack/mudcore;
    description = "A minimal, lua-scripted MUD server";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.endgame ];
    platforms = platforms.all;
  };
}
