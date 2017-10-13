include:
  - php.install

memcache-plugin:
  file.managed:
    - name: /usr/local/src/memcache-2.2.7.tgz
    - source: salt://php/files/memcache-2.2.7.tgz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar xf memcache-2.2.7.tgz && cd memcache-2.2.7 && /usr/local/php/bin/phpize && ./configure --enable-memcache --with-php-config=/usr/local/php/bin/php-config && make&& make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/memcache.so
    - require:
      - cmd: php-install
      - file: /usr/local/src/memcache-2.2.7.tgz

append-memcache-php:
  file.append:
    - name: /usr/local/php/etc/php.ini
    - text:
      - extension=memcache.so
  cmd.run:
    - name: /etc/init.d/php-fpm restart
