{ ... }:
{
  programs.git = {
    enable = true;
    userName = "plohan";
    userEmail = "30285202+plohan@users.noreply.github.com";
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
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = "true";
        followTags = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      merge = {
        conflictstyle = "zdiff3";
        tool = "vimdiff";
      };
      rebase = {
        autosquash = true; 
        autostash = true;
        updateRefs = true;
      };
      pull.rebase = false;
      commit.verbose = true;
      grep.patternType = "perl";
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@github.com/"= {
          insteadof = "gh:";
        };
      };
      user.signingkey = "5ACE2C4FBD9AD588";
    };
  };
}
