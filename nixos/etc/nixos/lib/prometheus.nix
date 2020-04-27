{ pkgs, lib, config, ... }:
{
  networking = {
    firewall.allowedTCPPorts = [
      # 3000  # grafana
      # 9090  # prometheus
    ];
  };

  services = {
    prometheus = {
      enable = true;
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
        enable = true;
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
      enable = true;
      addr = "0.0.0.0";
      domain = "grafana.example.com";
      rootUrl = "https://grafana.example.com/";
    };
  };
}
