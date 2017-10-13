pkg_group-init:
  cmd.run:
    - name: yum groupinstall "Development tools" "Server Platform Development"
    - unless: yum grouplist|grep "Development tools"
