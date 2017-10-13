include:
  - libevent.install

memcached-install:
  file.managed:
    - name: /usr/local/src/memcached-1.5.2.tar.gz
    - source: salt://memcached/files/memcached-1.5.2.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar xf memcached-1.5.2.tar.gz && cd memcached-1.5.2 && ./configure --prefix=/usr/local/memcached --enable-64bit --with-libevent=/usr/local/libevent/ && make && make install
    - unless: test -d /usr/local/memcached
    - require: 
      - cmd: libevent-install
      - file: /usr/local/src/memcached-1.5.2.tar.gz
