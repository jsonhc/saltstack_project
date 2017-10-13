include:
  - keepalived.install

keepalived-service:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/haproxy-outside-keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    {% if grains['fqdn'] == 'node1' %}
    - ROUTEID: haproxy_node1
    - STATEID: MASTER
    - PRIORITYID: 150
    {% elif grains['fqdn'] == 'node2' %}
    - ROUTEID: haproxy_node2
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - reload: True
    - watch:
      - file: keepalived-service
