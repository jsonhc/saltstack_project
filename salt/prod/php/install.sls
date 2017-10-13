pkg-php:
  pkg.installed:
    - names:
      - libxml2
      - libxml2-devel
      - bzip2
      - bzip2-devel
      - libjpeg-turbo
      - libjpeg-turbo-devel
      - libpng
      - libpng-devel
      - freetype
      - freetype-devel
      - zlib
      - zlib-devel
      - libcurl
      - libcurl-devel

php-install:
  file.managed:
    - name: /usr/local/src/php-5.6.30.tar.bz2
    - source: salt://php/files/php-5.6.30.tar.bz2
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar xf php-5.6.30.tar.bz2 && cd php-5.6.30 && ./configure --prefix=/usr/local/php --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-openssl --enable-mbstring --with-freetype-dir --with-jpeg-dir --with-png-dir --with-mcrypt --with-zlib --with-libxml-dir=/usr --enable-xml  --enable-sockets --enable-fpm --with-config-file-path=/usr/local/php/etc --with-bz2 --with-gd && make && make install
    - unless: test -d /usr/local/php
    - require:
      - pkg: pkg-php
      - file: /usr/local/src/php-5.6.30.tar.bz2

pdo-plugin:
  cmd.run:
    - name: cd /usr/local/src/php-5.6.30/ext/pdo_mysql && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make&& make install 
    - unless: test -f /usr/local/php/lib/php/extensions/*/pdo_mysql.so
    - require:
      - file: php-install

php-ini:
  file.managed:
    - name: /usr/local/php/etc/php.ini
    - source: salt://php/files/php.ini-production
    - user: root
    - group: root
    - mode: 644

php-fpm:
  file.managed:
    - name: /usr/local/php/etc/php-fpm.conf
    - source: salt://php/files/php-fpm.conf.default
    - user: root
    - group: root
    - mode: 644

php-service:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://php/files/init.d.php-fpm
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add php-fpm
    - unless: chkconfig --list|grep php-fpm
    - require:
      - file: /etc/init.d/php-fpm
  service.running:
    - name: php-fpm
    - enable: True
    - require: 
      - cmd: php-service
    - watch:
      - file: php-ini
      - file: php-fpm
