{
  description = "A flake to build a website coded with eleventy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs =
  { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let 
       pkgs = import nixpkgs {
         inherit system;
       };
        node = pkgs.nodejs-18_x; # Adjust the Node.js version as needed
        pnpm = pkgs.pnpm;
      in {
	devShell = pkgs.mkShell {
	  buildInputs = [node pnpm];
	  shellHook = ''
	    echo "Run pnpm install to install deps"
	  '';
	};

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "my-website";
          version = "0.1.0";

          src = ./.;

	  buildInputs = [ node pnpm ];

          buildPhase = ''
          '';

	  preBuild = '' 
	  '';

          installPhase = ''
            mkdir -p $out
            cp -r dist/* $out/
          '';

        };
      }
   );
}
