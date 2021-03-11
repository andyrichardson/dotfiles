self: super:
{
  sway-unwrapped = super.sway-unwrapped.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ../patches/001-sway-desktop.patch
    ];
  });
}
