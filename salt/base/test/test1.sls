define-variable:
  file.managed:
    - name: /tmp/test.sls
    - source: salt://init/files/test.txt
    - template: jinja
    - defaults:
      Server: {{ pillar['zabbix-agent']['Zabbix_Server'] }} 
  cmd.run:
    - name: echo '{{ grains['fqdn'] }}' >> /tmp/test.sls && echo '{{ grains['web'] }}'  >> /tmp/test.sls
