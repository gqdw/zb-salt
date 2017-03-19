zabbix-agent-install:
  cmd.run:
    - name: rpm -ivh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm
    - unless: test -e /etc/yum.repos.d/zabbix.repo
  pkg.installed:
    - names: 
      - zabbix-agent

zabbix-agent-config:
  file.managed:
    - name:  /etc/zabbix/zabbix_agentd.conf
    - source: salt://zabbix/zabbix_agentd.conf
    - template: jinja
    - defaults: 
      ZABBIX_HOST: {{ pillar['zabbix']['ZABBIX_HOST'] }}

enable-zabbix-agent:
  service.running:
    - name: zabbix-agent
    - enable: True
    - require:
      - file: zabbix-agent-config
