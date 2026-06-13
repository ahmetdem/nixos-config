{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Load the AMD iGPU driver early (PRIME render offload pairs it with Nvidia)
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "splash"
    "pcie_aspm=off"
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
