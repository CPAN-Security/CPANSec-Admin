{ pkgs ? import <nixpkgs> {}}:

with pkgs;
with stdenv;
with perlPackages;

assert (lib.versionAtLeast perl.version "5.38.0");

let perl' = perl.withPackages(p: with p; [
      CPANMetaRequirements
      ENVUtil
      MetaCPANClient
      JSON
      NetNVD
      PathTiny
      Test2Suite
      Test2Harness
      TimePiece
      PodParser
      URI
    ]);
    ENVUtil = buildPerlPackage {
      pname = "ENV-Util";
      version = "0.03";
      src = fetchurl {
        url = "mirror://cpan/authors/id/G/GA/GARU/ENV-Util-0.03.tar.gz";
        hash = "sha256-B1574ehSxD6wiGYvr978FS9O9WyEPB4F2QDaGQb3P60=";
      };
      meta = {
        description = "Parse prefixed environment variables and dotnev (.env) files into Perl";
        license = with lib.licenses; [ artistic1 gpl1Plus ];
      };
    };
    NetNVD = buildPerlPackage {
      pname = "Net-NVD";
      version = "0.0.3";
      src = fetchurl {
        url = "mirror://cpan/authors/id/G/GA/GARU/Net-NVD-0.0.3.tar.gz";
        hash = "sha256-uKZXEg+UsO7R2OvbA4i8M2DSj6Xw+CNrnNjNrovv5Bg=";
      };
      propagatedBuildInputs = [ IOSocketSSL JSON NetSSLeay ];
      meta = {
        description = "Query CVE data from NIST's NVD (National Vulnerability Database)";
        license = with lib.licenses; [ artistic1 gpl1Plus ];
      };
    };
in pkgs.mkShell {
  buildInputs = [ perl' ];
}
