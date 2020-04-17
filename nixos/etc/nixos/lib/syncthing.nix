let
  homemount = from: to: {
    mountPoint = "/home/s/" + to;
    device = "/home/s/" + from;
    options = ["bind" "nofail"];
  };

  syncmount = dir: homemount (".syncthing/shares/home/" + dir) dir;

  syncmounts = map syncmount ["code" "data" "log"];

  rest = [
    (homemount ".syncthing/shares/pdf" "pdf")
  ];
in
  syncmounts ++ rest
