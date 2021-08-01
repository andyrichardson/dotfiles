# Make some libs system wide for easy node development
{ pkgs, ... }:
with pkgs; {
  environment.systemPackages =
    [ stdenv.cc.cc.lib zlib libuv openssl.dev pkg-config python glibc ];
  environment.variables.TEST =
    "${stdenv.cc.cc.lib}/lib64;${stdenv.cc.cc.lib}/lib;${zlib}/lib;${libuv}/lib;${openssl.dev}/lib;${glibc}/lib;${glibc}/lib64;";
}
