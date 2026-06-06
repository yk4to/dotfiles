{lib, ...}: let
  # Nix builtins do not expose sqrt, so use Newton's method for DPI calculation.
  sqrt = value: let
    iterate = guess: remaining:
      if remaining == 0
      then guess
      else iterate ((guess + value / guess) / 2.0) (remaining - 1);
  in
    if value < 0.0
    then throw "display.sqrt does not accept negative values"
    else if value == 0.0
    then 0.0
    else
      iterate (
        if value < 1.0
        then 1.0
        else value / 2.0
      )
      32;

  # Apple tends to land around these logical DPI targets for laptop vs desktop displays.
  getTargetDpi = {is_laptop ? false, ...}:
    if is_laptop
    then 127.0
    else 109.0;

  # Convert a panel's physical geometry into its actual DPI.
  getPhysicalDpi = {
    resolution,
    inch,
    ...
  }:
    sqrt (
      resolution.width
      * resolution.width
      + resolution.height * resolution.height
    )
    / inch;
in {
  # Linux pt size is 0.75x the macOS reference pt size.
  getLinuxPt = macPt: macPt * 0.75;

  # Niri can take fractional scales directly, so keep the ideal float without rounding.
  getScale = display:
    getPhysicalDpi display / getTargetDpi display;

  inherit getPhysicalDpi getTargetDpi;
}
