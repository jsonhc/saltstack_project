libmcrypt-install:
  file.managed:
    - name: /usr/local/src/libmcrypt-2.5.7.tar.gz
    - source: salt://libmcrypt/files/libmcrypt-2.5.7.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar xf libmcrypt-2.5.7.tar.gz && cd libmcrypt-2.5.7 && ./configure && make && make install
    - unless: test -d /usr/local/src/libmcrypt-2.5.7
    - require:
      - file: /usr/local/src/libmcrypt-2.5.7.tar.gz
