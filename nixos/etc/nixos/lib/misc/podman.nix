{ config, pkgs, ... }:

{
  environment.etc."containers/libpod.conf".text = ''
    image_default_transport = "docker://"
    runtime_path = ["${pkgs.runc}/bin/runc"]
    conmon_path = ["${pkgs.conmon}/bin/conmon"]
    cni_plugin_dir = ["${pkgs.cni-plugins}/bin/"]
    cgroup_manager = "systemd"
    cni_config_dir = "/etc/cni/net.d/"
    cni_default_network = "podman"
    # pause
    pause_image = "k8s.gcr.io/pause:3.1"
    pause_command = "/pause"
  '';

  environment.etc."containers/registries.conf".text = ''
    [registries.search]
    registries = ['docker.io', 'registry.fedoraproject.org', 'quay.io', 'registry.access.redhat.com', 'registry.centos.org']
  '';

  environment.etc."containers/policy.json".text = ''
    {
      "default": [
        { "type": "insecureAcceptAnything" }
      ]
    }
  '';

  environment.etc."cni/net.d/87-podman-bridge.conflist".text = ''
    {
        "cniVersion": "0.3.0",
        "name": "podman",
        "plugins": [
          {
            "type": "bridge",
            "bridge": "cni0",
            "isGateway": true,
            "ipMasq": true,
            "ipam": {
                "type": "host-local",
                "subnet": "10.88.0.0/16",
                "routes": [
                    { "dst": "0.0.0.0/0" }
                ]
            }
          },
          {
            "type": "portmap",
            "capabilities": {
              "portMappings": true
            }
          }
        ]
    }
  '';
}
