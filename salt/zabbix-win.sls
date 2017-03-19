extract-zabbix-zip:
  archive.extracted:
    - name: e:\zabbix-agent
    - source: salt://zabbix/zabbix_agents_3.0.4.win.zip

zabbix-agent-config:
  file.managed:
    - name:  c:\zabbix_agentd.conf
    - source: salt://zabbix/zabbix_agentd.win.conf
    - template: jinja
    - defaults: 
      ZABBIX_HOST: {{ pillar['zabbix']['ZABBIX_HOST'] }}

install-zabbix-service:
  cmd.run:
    - name: 'e:\zabbix-agent\bin\win64\zabbix_agentd -i'
    - stateful: True
    - require:
      - file: zabbix-agent-config
    - check_cmd:
      - echo 123

enable-zabbix-agent:
  service.running:
    - name: Zabbix Agent
    - enable: True
    - require:
      - file: zabbix-agent-config
