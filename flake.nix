# shared plugin dev environment
{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      dotnet = pkgs.dotnetCorePackages.sdk_10_0;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [ dotnet pkgs.roslyn-ls pkgs.just ]; 
        DOTNET_ROOT = "${dotnet}/share/dotnet";
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";
        EnableWindowsTargeting = "true";
      };
    };
}
