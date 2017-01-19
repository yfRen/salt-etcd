etcd-install:
  pkg.installed:
    - names:
      - epel-release
      - etcd

etcd-config:
  file.managed:
    - name: /etc/etcd/etcd.conf
    - source: salt://etcd/file/etcd.conf
    - template: jinja
    - defaults:
      CLUSTER_IP1: {{ pillar['etcd']['CLUSTER_IP1'] }}
      CLUSTER_IP2: {{ pillar['etcd']['CLUSTER_IP2'] }}
      CLUSTER_IP3: {{ pillar['etcd']['CLUSTER_IP3'] }}
      CLUSTER_HOSTNAME1: {{ pillar['etcd']['CLUSTER_HOSTNAME1'] }}
      CLUSTER_HOSTNAME2: {{ pillar['etcd']['CLUSTER_HOSTNAME2'] }}
      CLUSTER_HOSTNAME3: {{ pillar['etcd']['CLUSTER_HOSTNAME3'] }}
      LOCAL_IP: {{ grains['ipv4'][1] }}
      LOCAL_HOSTNAME: {{ grains['fqdn'] }}

etcd-service:
  service.running:
    - name: etcd
    - enable: True
    - require:
      - pkg: etcd-install
      - file: etcd-config
