(map
  (dir: {
    mountPoint = "/home/s/" + dir;
    device = "/home/s/.syncthing/shares/home/" + dir;
    options = ["bind"];
  })
  ["audio" "bin" "code" "data" "foto" "hack" "http" "log" "pdf"])
