getshell:
  file.managed:
    - name: /tmp/echo.sh
    - source: salt://init/files/echo.sh
  cmd.run:
    - name: /bin/bash /tmp/echo.sh
    - unless: test -f /tmp/if_unless.sh
    - require:
      - file: /tmp/echo.sh
