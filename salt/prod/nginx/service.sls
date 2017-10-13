include:
  - nginx.install

/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - user: nginx
    - group: nginx
    - mode: 644

nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/vhost
    - require:
      - file: nginx-install
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require: 
      - file: /etc/init.d/nginx
      - cmd: nginx-init
    - watch:
      - file: /usr/local/nginx/conf/nginx.conf
