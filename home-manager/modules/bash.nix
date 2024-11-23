{ ... }:
{
  programs.bash.enable = true;
  programs.bash.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.bash.shellAliases = {
    lg = "lazygit";
    v = "nvim";
    k = "kubectl";
    dc = "docker compose";
  };
}

