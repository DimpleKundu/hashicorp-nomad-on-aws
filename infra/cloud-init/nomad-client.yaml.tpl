#cloud-config
package_update: true
package_upgrade: true
packages:
  - unzip
  - docker.io

runcmd:
  # Install Nomad
  - NOMAD_VERSION="1.7.0"
  - wget "https://releases.hashicorp.com/nomad/$${NOMAD_VERSION}/nomad_$${NOMAD_VERSION}_linux_amd64.zip"
  - unzip "nomad_$${NOMAD_VERSION}_linux_amd64.zip"
  - mv nomad /usr/local/bin/
  - rm "nomad_$${NOMAD_VERSION}_linux_amd64.zip"

  # Enable Docker
  - systemctl enable docker
  - systemctl start docker

  # Create Nomad configuration
  - mkdir -p /etc/nomad.d
  - |
    cat <<EOF >/etc/nomad.d/nomad.hcl
    data_dir  = "/opt/nomad"
    name      = "nomad-client"
    bind_addr = "0.0.0.0"

    server {
      enabled = false
    }

    client {
      enabled = true
      servers = ["${server_ip}"]
      network_interface = "ens5"
    }

    advertise {
      http = "{{ GetInterfaceIP \"ens5\" }}"
      rpc  = "{{ GetInterfaceIP \"ens5\" }}"
      serf = "{{ GetInterfaceIP \"ens5\" }}"
    }
    EOF

  # Create systemd service for Nomad
  - |
    cat <<EOF >/etc/systemd/system/nomad.service
    [Unit]
    Description=Nomad
    After=network.target docker.service
    Requires=docker.service

    [Service]
    ExecStart=/usr/local/bin/nomad agent -config=/etc/nomad.d
    Restart=on-failure
    LimitNOFILE=65536

    [Install]
    WantedBy=multi-user.target
    EOF

  # Start Nomad service
  - systemctl daemon-reload
  - systemctl enable nomad
  - systemctl start nomad
