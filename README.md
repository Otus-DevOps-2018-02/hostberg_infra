# hostberg_infra
hostberg Infra repository

## Homework 4 (GCP Bastion)

bastion_IP = 35.204.227.119 
someinternalhost_IP = 10.164.0.3

#### Самостоятельное задание

ssh -i ~/.ssh/appuser -A -o ProxyCommand='ssh -W %h:%p appuser@35.204.227.119' appuser@10.164.0.3

или

ssh internalhost

Предварительно добавив в .ssh/config

Host bastion
    Hostname 35.204.227.119
    User appuser
    IdentityFile ~/.ssh/appuser

Host internalhost
    Hostname 10.164.0.3
    User appuser
    IdentityFile ~/.ssh/appuser
    ProxyCommand ssh bastion -W %h:%p

