{% set vm = 'ipaddress' %}

BackupPrometheus:
  file.managed:
    - name: '/etc/prometheus/prometheus.yml'
    - backup: minion
    
Disableprometheus:
  file.replace:
    - name: '/etc/prometheus/prometheus.yml'
    - pattern: '[\s-]+[a-z]+[a-z]+\W\s\W+{{ vm }}+[:9100]+\W\D+\s[a-zA-Z0-9][^a-z]+[a-z]+\D*$'
    - repl: ''

RestartPrometheus:
  service.running:
    - name: prometheus
    - enable: True
    - reload: True
