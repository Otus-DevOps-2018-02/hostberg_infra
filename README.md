# hostberg_infra
hostberg Infra repository

## Homework 4 (GCP Bastion)

bastion_IP = 35.204.227.119  
someinternalhost_IP = 10.164.0.3

#### Самостоятельное задание

`ssh -i ~/.ssh/appuser -A -o ProxyCommand='ssh -W %h:%p appuser@35.204.227.119' appuser@10.164.0.3`

или

`ssh internalhost`

Предварительно добавив в .ssh/config

```
Host bastion
    Hostname 35.204.227.119
    User appuser
    IdentityFile ~/.ssh/appuser
```

```
Host internalhost
    Hostname 10.164.0.3
    User appuser
    IdentityFile ~/.ssh/appuser
    ProxyCommand ssh bastion -W %h:%p
```

## Homework 5 (Cloud TestApp)

testapp_IP = 35.204.134.27  
testapp_port = 9292

#### Самостоятельное задание

В рамках дополнительного задания был создан `startup_script.sh`, приводятся 3 варианта его использования и пример удаления/добавления правил firewall через gcloud.

###### Вариант --metadata-from-file startup-script=FILE

```
# gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup_script.sh
```

###### Вариант --metadata startup-script=CONTENTS

```
# gist --raw ./startup_script.sh
https://gist.github.com/hostberg/4daa4a8c957473b52c8b0fffb1c79c2a/raw

# gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script='wget -O - https://gist.github.com/hostberg/4daa4a8c957473b52c8b0fffb1c79c2a/raw | sudo /bin/bash'
```

###### Вариант --metadata startup-script-url=URL

```
# gsutil mb gs://hostberg_infra
# gsutil cp startup_script.sh gs://hostberg_infra 

# gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script-url=gs://hostberg_infra/startup_script.sh
```

###### Удаляем/добавляем правила firewall через gcloud

```
# gcloud --quiet compute firewall-rules delete default-puma-server
# gcloud --quiet compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags puma-server
```

## Homework 6 (Packer base)

#### Самостоятельное задание

В рамках дополнительного задания некоторые параметры (_project_id_ и _source_image_family_) были вынесены в отдельный файл `variables.json` и добавлены дополнительные параметры (_image_description_,_disk_size_,_disk_type_,_network_ и _tags_) Google Compute Builder'а.

#### Задание со *

* Создан дополнительный шаблон `immutable.json`;
* Дополнительные файлы (`mongodb-org-3.2.list` и `puma.service`) размещены в директории `packer/files`;
* В `config-scripts` созданы дополнительный скрипты (`create-reddit-vm.sh` и `check-reddit-vm.sh`) для создания и проверки инстанса из image'а _reddit-full_.

## Homework 7 (Trraform 1)

#### Самостоятельное задание

* Определена переменная private_key_path;
* Определена переменна zone с дефолтным значением
* Все конфиги отформатированы с помощью [vscode-terraform](https://github.com/mauve/vscode-terraform/);
* Создан шаблон конфига terraform.tfvars.example.

#### Задание со *

Добавление ключей в проект можно организовать с помощью `google_compute_project_metadata` и `google_compute_project_metadata_item`. Примеры реализации находятся в файле `metadata.tf.example`. В процессе добавления ключей проблем обнаружено не было, но стоит обратить внимание на то, что изменения внесенные через web-интерфейс (_appuser_web_) после `terraform apply` будут утеряны.

#### Задание с **

* В конфиге `lb.tf` описан балансировщик для создаваемых инстансов;
* Количество инстансов определяется в переменной `count`;
* Создано 2 _output_ переменные (`app_external_ip` и `lb_external_ip`).
