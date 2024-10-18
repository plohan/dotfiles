{ pkgs, ... }:

let
  searchengines = {
      "Nixpkgs" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "Github" = {
        urls = [{
          template = "https://github.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];

        iconUpdateURL = "https://github.com/favicon.svg";
        definedAliases = [ "@gh" ];
      };
      "Google".metaData.alias = "@g";
  };
in
{
  programs.firefox.enable = true;
  programs.firefox.profiles.imsozrious =
  {
    id = 0;
    isDefault = true;
    name = "imsozrious";
    bookmarks = [
      {
        name = "Github";
        url = "https://github.com";
      }
      {
        name = "Nixpkgs";
        url = "https://search.nixos.org";
      }
    ];
    search.engines = searchengines;
    search.force = true;
  };
}
