{ pkgs, ... }:

{
  programs.light.enable = true;
  services.actkbd = {
    enable = false;
    bindings = [
      { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -U 5"; }
      { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -A 5"; }
    ];
  };
}
