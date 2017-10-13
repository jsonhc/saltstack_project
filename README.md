# saltstack_project
satstack project

使用saltstack自动化安装keepalived+haproxy的高可用
自动化安装nginx+php，安装memcached


提供php连接memcached服务器的测试页面：
[root@node1 memcached]# cat /usr/local/nginx/html/test.php 
<?php
  $memcache = new Memcache;
  $memcache->connect('192.168.44.134',11211) or die ("could not connect");
  $memcache->set('key','test');
  $get_value = $memcache->get('key');
  echo $get_value;
?>

memcached服务器只有一台，位于node1节点上（192.168.44.134）
