include:
  - pkg.pkg-init

nginx-install:
  file.managed:
    - name: /usr/local/src/nginx-1.8.1.tar.gz
    - source: salt://nginx/files/nginx-1.8.1.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: useradd -M -s /sbin/nologin nginx && cd /usr/local/src && tar xf nginx-1.8.1.tar.gz && cd nginx-1.8.1 && yum install libxslt-devel -y gd gd-devel GeoIP GeoIP-devel pcre pcre-devel && ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-file-aio --with-ipv6 --with-http_ssl_module  --with-http_spdy_module --with-http_realip_module    --with-http_addition_module    --with-http_xslt_module   --with-http_image_filter_module    --with-http_geoip_module  --with-http_sub_module  --with-http_dav_module --with-http_flv_module    --with-http_mp4_module --with-http_gunzip_module  --with-http_gzip_static_module  --with-http_auth_request_module  --with-http_random_index_module   --with-http_secure_link_module   --with-http_degradation_module   --with-http_stub_status_module && make && make install && chown -R nginx:nginx /usr/local/nginx/
    - unless: test -d /usr/local/nginx
    - require:
      - pkg: pkg-init
      - file: /usr/local/src/nginx-1.8.1.tar.gz

nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx.init
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list|grep nginx
    - require:
      - file: /etc/init.d/nginx

