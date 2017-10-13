zabbix-agent-install:
  file.managed:
    - name: /usr/local/src/zabbix-agent-3.0.10-1.el6.x86_64.rpm
    - source: salt://init/files/zabbix-agent-3.0.10-1.el6.x86_64.rpm
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && yum install -y zabbix-agent-3.0.10-1.el6.x86_64.rpm
    - unless: rpm -qa zabbix-agent|grep zabbix-agent
    - require:
      - file: /usr/local/src/zabbix-agent-3.0.10-1.el6.x86_64.rpm  

zabbix-agent-service:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://init/files/zabbix_agentd.conf
    - template: jinja
    - defaults:
      Server: {{ pillar['zabbix-agent']['Zabbix_Server'] }}
  service.running:
    - name: zabbix-agent
    - enable: True
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf
