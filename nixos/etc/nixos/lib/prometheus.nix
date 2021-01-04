{ pkgs, lib, config, ... }:
{
  networking = {
    firewall.interfaces.tun0.allowedTCPPorts = [
      9100 # node_exporter
    ];
  };

  services = {
    prometheus = {
      enable = false;
      scrapeConfigs = [
        {
          job_name = "node";
          scrape_interval = "10s";
          static_configs = [
            {
              targets = [
                "localhost:9100"
              ];
              labels = {
                alias = "prometheus.example.com";
              };
            }
          ];
        }
      ];
      exporters.node = {
        enable = false;
        enabledCollectors = [
          # "conntrack"
          # "diskstats"
          # "entropy"
          # "filefd"
          "filesystem"
          "loadavg"
          # "mdadm"
          "meminfo"
          # "netdev"
          "netstat"
          # "stat"
          # "time"
          # "vmstat"
          # "systemd"
          # "logind"
          # "interrupts"
          # "ksmd"
        ];
      };
    };

    grafana = {
      enable = false;
      addr = "0.0.0.0";
      domain = "grafana.example.com";
      rootUrl = "https://grafana.example.com/";
    };
  };
}
