include:
  - pkg.pkg-init

keepalived-install:
  file.managed:
    - name: /usr/local/src/keepalived-1.3.6.tar.gz
    - source: salt://keepalived/files/keepalived-1.3.6.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar xf keepalived-1.3.6.tar.gz && cd keepalived-1.3.6 && ./configure --prefix=/usr/local/keepalived --disable-fwmark && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - pkg: pkg-init
      - file: keepalived-install
  
keepalived-init:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://keepalived/files/keepalived.init
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list|grep keepalived
    - require:
      - file: /etc/init.d/keepalived
      
/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644

/etc/keepalived:
  file.directory:
    - user: root
    - group: root
    - mode: 755
