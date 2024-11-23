{ ... }:
{
  programs.git = {
    enable = true;
    userName = "imsozrious";
    userEmail = "30285202+ImSoZRious@users.noreply.github.com";
    ignores = [
      ".direnv"
      ".envrc"
    ];
    extraConfig = {
      merge.tool = "vimdiff";
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
      };
      user.signingkey = "5ACE2C4FBD9AD588";
    };
  };
}
