{...}: {
  programs.git = {
    enable = true;
    userName = "beeb5k";
    userEmail = "beeb5k6@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
