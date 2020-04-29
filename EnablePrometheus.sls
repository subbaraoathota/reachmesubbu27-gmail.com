{% set ipaddress = salt['pillar.get']('prometheus:ip') %}
{% set vm = salt['pillar.get']('prometheus:vm') %}
{% set role = salt['pillar.get']('prometheus:role') %}
{% set port = salt['pillar.get']('prometheus:port') %}
{% set nodenumber = salt['cmd.shell']('sudo grep -n  node_exporter_centos /etc/prometheus/prometheus.yml | cut -d: -f1')|int %}
{% set nodenumber1 = nodenumber + 2 %}
{% set nodenumber2 = nodenumber + 3 %}
{% set nodenumber3 = nodenumber + 4 %}
{% set nodenumber4 = nodenumber + 5 %}
{%- set status = salt["file.contains"]('/etc/prometheus/prometheus.yml',salt['pillar.get']('prometheus:ip')) -%}
{%- if status -%}
stringnot:
  cmd.run:
    - name: echo "String {{ status }} exists."
{% else %}
string:
  cmd.run:
    - name: |
        echo "status {{ status }}"
        sudo sed -i "{{ nodenumber1 }} a \            - targets: ['{{ ipaddress }}:{{ port }}']" /etc/prometheus/prometheus.yml
        sudo sed -i '{{ nodenumber2 }} a \              labels:' /etc/prometheus/prometheus.yml
        sudo sed -i '{{ nodenumber3 }} a \                instance: {{ vm }}' /etc/prometheus/prometheus.yml
        sudo sed -i '{{ nodenumber4 }} a \                group: {{ role }}' /etc/prometheus/prometheus.yml
        sudo systemctl restart prometheus
{% endif %}