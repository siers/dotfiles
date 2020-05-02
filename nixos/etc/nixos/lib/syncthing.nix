{ excluding ? [], recursiveUpdate }:

let
  homemount = from: to: {
    "/home/s/${to}" = {
      device = "/home/s/" + from;
      options = ["bind" "nofail"];
    };
  };

  syncmount = dir: homemount (".syncthing/shares/home/" + dir) dir;

  syncmounts = map syncmount ["code" "data" "log"];

  rest = builtins.concatLists [
    (if (builtins.elem "pdf" excluding) then [] else [(homemount ".syncthing/shares/pdf" "pdf")])
  ];

  foldMounts = builtins.foldl' recursiveUpdate {};
in
  foldMounts (syncmounts ++ rest)
