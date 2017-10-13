include:
  - memcached.install

memcached-service:
  cmd.run:
    - name: /usr/local/memcached/bin/memcached -d -m 64 -p 11211 -c 1024 -u nginx
    - unless: netstat -tunlp|grep 11211
    - require:
      - cmd: memcached-install
