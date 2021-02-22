#!/bin/sh

# This script installs the Nix package manager on your system by
# downloading a binary distribution and running its installer script
# (which in turn creates and populates /nix).

{ # Prevent execution if this script was only partially downloaded
oops() {
    echo "$0:" "$@" >&2
    exit 1
}

umask 0022

tmpDir="$(mktemp -d -t nix-binary-tarball-unpack.XXXXXXXXXX || \
          oops "Can't create temporary directory for downloading the Nix binary tarball")"
cleanup() {
    rm -rf "$tmpDir"
}
trap cleanup EXIT INT QUIT TERM

require_util() {
    command -v "$1" > /dev/null 2>&1 ||
        oops "you do not have '$1' installed, which I need to $2"
}

case "$(uname -s).$(uname -m)" in
    Linux.x86_64)
        hash=08b7faafcb2a3f3ca81a44dae51f2e4cf7edb8b6898c7cef6a40193d67cf7519
        path=hp9wr656yhn2syy3rlgzcmjj5hzx01i8/nix-2.4pre20210122_b7bfc7e-x86_64-linux.tar.xz
        system=x86_64-linux
        ;;
    Linux.i?86)
        hash=098361f63f84f5fbc0e039dc785e57644fa293e1b389fec487a6391a64eca6e3
        path=3r1v1w0cl0r6hlnbqs1q4xwbybinwvk5/nix-2.4pre20210122_b7bfc7e-i686-linux.tar.xz
        system=i686-linux
        ;;
    Linux.aarch64)
        hash=2c5c3bd825a8974cd924ac915310bc0d11756f3d1dc8dd6e7072b8b4258a222f
        path=43xqfjnp5k4m3znf8rxs2dxv3zzd6y1v/nix-2.4pre20210122_b7bfc7e-aarch64-linux.tar.xz
        system=aarch64-linux
        ;;
    Darwin.x86_64)
        hash=8dbc7baacaee87614f0c8a4a72a1ede95e92d4a6ce026d6f187314b818da585d
        path=6szm7r46p0jk3j9j4hxc94x0f5kwn1rz/nix-2.4pre20210122_b7bfc7e-x86_64-darwin.tar.xz
        system=x86_64-darwin
        ;;
    Darwin.arm64|Darwin.aarch64)
        # check for Rosetta 2 support
        if ! [ -f /Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist ]; then
          oops "Rosetta 2 is not installed on this ARM64 macOS machine. Run softwareupdate --install-rosetta then restart installation"
        fi

        hash=@binaryTarball_x86_64-darwin@
        path=6szm7r46p0jk3j9j4hxc94x0f5kwn1rz/nix-2.4pre20210122_b7bfc7e-x86_64-darwin.tar.xz
        # eventually maybe: aarch64-darwin
        system=x86_64-darwin
        ;;
    *) oops "sorry, there is no binary distribution of Nix for your platform";;
esac

# Use this command-line option to fetch the tarballs using nar-serve or Cachix
if "${1:---tarball-url-prefix}"; then
    if [ -z "${2:-}" ]; then
        oops "missing argument for --tarball-url-prefix"
    fi
    url=${2}/${path}
    shift 2
else
    url=https://github.com/numtide/nix-flakes-installer/releases/download/nix-2.4pre20210122_b7bfc7e/nix-2.4pre20210122_b7bfc7e-$system.tar.xz
fi

tarball=$tmpDir/nix-2.4pre20210122_b7bfc7e-$system.tar.xz

require_util curl "download the binary tarball"
require_util tar "unpack the binary tarball"
if [ "$(uname -s)" != "Darwin" ]; then
    require_util xz "unpack the binary tarball"
fi

echo "downloading Nix 2.4pre20210122_b7bfc7e binary tarball for $system from '$url' to '$tmpDir'..."
curl -L "$url" -o "$tarball" || oops "failed to download '$url'"

if command -v sha256sum > /dev/null 2>&1; then
    hash2="$(sha256sum -b "$tarball" | cut -c1-64)"
elif command -v shasum > /dev/null 2>&1; then
    hash2="$(shasum -a 256 -b "$tarball" | cut -c1-64)"
elif command -v openssl > /dev/null 2>&1; then
    hash2="$(openssl dgst -r -sha256 "$tarball" | cut -c1-64)"
else
    oops "cannot verify the SHA-256 hash of '$url'; you need one of 'shasum', 'sha256sum', or 'openssl'"
fi

if [ "$hash" != "$hash2" ]; then
    oops "SHA-256 hash mismatch in '$url'; expected $hash, got $hash2"
fi

unpack=$tmpDir/unpack
mkdir -p "$unpack"
tar -xJf "$tarball" -C "$unpack" || oops "failed to unpack '$url'"

script=$(echo "$unpack"/*/install)

[ -e "$script" ] || oops "installation script is missing from the binary tarball!"
export INVOKED_FROM_INSTALL_IN=1
"$script" "$@"

} # End of wrapping
