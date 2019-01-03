{ autoreconfHook, glib, libtelnet, lua, pkgconfig, stdenv, texinfo, zeromq }:

stdenv.mkDerivation {
  name = "mudcore";
  src = ./.;

  nativeBuildInputs = [ autoreconfHook pkgconfig texinfo ];
  buildInputs = [ glib libtelnet lua zeromq ];

  meta = with stdenv.lib; {
    homepage = https://git.sr.ht/~jack/mudcore;
    description = "A minimal, lua-scripted MUD server";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.endgame ];
  };
}
