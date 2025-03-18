{...}: {
  programs.git = {
    enable = true;
    userName = "beeb5k";
    userEmail = "beeb5k6@gmail.com";

    signing = {
      key = "1D8222FA8B7E93A6";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
