include:
  - php.install
  - nginx.service
  - php.php-memcache

nginx-php-conf:
  file.managed:
    - name: /usr/local/nginx/conf/fastcgi_params
    - source: salt://html/files/fastcgi_params
    - user: nginx
    - group: nginx
    - mode: 755

html-www:
  file.managed:
    - name: /usr/local/nginx/conf/vhost/www.conf
    - source: salt://html/files/www.conf
    - user: root
    - group: root
    - mode: 644
    - require: 
      - service: php-service
    - watch_in:
      - service: nginx-service
