{ stdenv, fetchFromGitHub, python38, python38Packages, }:

stdenv.mkDerivation {
  pname = "psuinfo";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "nwg-piotr";
    repo = "psuinfo";
    rev = "0a84cada97718a26111254a0b04b54c1d23489f0";
    sha256 = "0yfngacm5vpkkvkr0g30mb97wg93ar3wgrxy5vwhkq2adg70iwsf";
  };

  buildInputs = [ 
    python38
    python38Packages.psutil
  ];

  nativeBuildInputs =  [
    python38
    python38Packages.psutil
  ];
  installPhase = ''
    mkdir -p $out/bin
    mv psuinfo $out/bin
  '';
}
