{ autoreconfHook
, git
, glib
, libtelnet
, lib
, lua
, pkgconfig
, stdenv
, texinfo
, zeromq
}:

stdenv.mkDerivation {
  name = "mudcore";
  src = ./.;

  buildInputs = [ glib libtelnet lua zeromq ];
  nativeBuildInputs = [ autoreconfHook pkgconfig texinfo ];

  meta = with lib; {
    homepage = https://git.sr.ht/~jack/mudcore;
    description = "A minimal, lua-scripted MUD server";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.endgame ];
    platforms = platforms.all;
  };
}
