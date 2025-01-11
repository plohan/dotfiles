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
    maintenance.enable = true;
    aliases = {
      skip = "update-index --skip-worktree";
      noskip = "update-index --no-skip-worktree";
    };
    extraConfig = {
      pull.rebase = true;
      merge.conflictstyle = "diff3";
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
