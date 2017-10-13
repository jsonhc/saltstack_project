vm.swappiness:
  sysctl.present:
    - value: 0

net.ipv4.ip_local_port_range:
  sysctl.present:
    - value: 10000 61000

fs.file-max:
  sysctl.present:
    - value: 186981
