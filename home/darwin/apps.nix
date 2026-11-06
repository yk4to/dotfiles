{
  # Copy apps instead of symlinking them, so Spotlight and the Dock see real bundles.
  targets.darwin = {
    copyApps.enable = true;
    linkApps.enable = false;
  };
}
