create-file:
  cmd.run:
    - name: touch /tmp/test.txt && echo "saltstack" >> /tmp/test.txt
