УСТАНОВКА И НАСТРОЙКА МАЙНИНГА НА LINUX

Системиные требования:
- Debian версии 9 и выше;
- Ubuntu версии 18.04 и выше;
- Linux Mint версии 19 и выше;
- Локальный кошелёк Tkeycoin Core версии не ниже 1.1.5
Добавим, что клиент вполне может заработать и в других debian-подобных системах - пробуйте, экспериментируйте)

Разберём установку клиента на чистую систему (только что установленную).
Везде по тексту будет использоваться команда sudo, если вы авторизованы под root, команду вводить необязательно.


ЭТАП 1 - Подготовка системы

Если кошелёк Tkeycoin Core версии не ниже 1.1.5 установлен и успешно запускается, можете пропускать данный этап и переходить к следующему.
Для начала установим последние обновления:
sudo apt-get update
sudo apt-get upgrade
sudo apt install wget ca-certificates
После установки всех обновлений выполняем перезагрузку.


ЭТАП 2 - Установка кошелька Tkeycoin Core

Если кошелёк Tkeycoin Core версии не ниже 1.1.5 установлен и успешно запускается, можете пропускать данный этап и переходить к следующему.

Устанавливаем Tkeycoin Core. Актуальную версию кошелька можно найти на официальном сайте:
https://tkeycoin.com/ru/download/index.html
На момнет написания поста актуальная версия - 1.1.6, скачиваем её:
wget https://tkeycoin.com/tkeycoin-1.1.6.deb

Устанавливаем:
sudo apt install ./tkeycoin-1.1.6.deb

На сборках системы, где в репозиторий не включен docker-ce, перед установкой кошелька потребуется добавить репозиторий docker.

Для Debian необходимо проделать следующие действия:
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common gpg-agent
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update

Для Ubuntu:
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common gpg-agent
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update

После выполнения этих действий заново запускаем установку Tkeycoin Core.

После уставновки запускаем Tkeycoin Core и синхронизируем его:
tkeycoind start


ЭТАП 3 - Установка Pool Client

Для начала устанавливаем Git, если он ещё не установлен:
sudo apt install git

Далее есть несколько вариантов. Вы можете скачать последнюю версию, бета-версию или произвольную.
Команды для загрузки:
Последняя версия: 
git clone --depth=1 --branch=master https://github.com/tkeymp/tkeycoin_pool_client_ubuntu pool_client_latest
Бета-версия: 
git clone --depth=1 --branch=pool_client_beta https://github.com/tkeymp/tkeycoin_pool_client_ubuntu pool_client_beta
Произвольная версия: 
git clone --depth=1 --branch=pool_client-x.x.x https://github.com/tkeymp/tkeycoin_pool_client_ubuntu pool_client-x.x.x
В рамках данной инструкции разберём установку последней версии. 
Загружаем последнюю версию Pool Client с нашего репозитория:
git clone --depth=1 --branch=master https://github.com/tkeymp/tkeycoin_pool_client_ubuntu pool_client_latest

Устанавливаем права на папку:
sudo chmod 777 pool_client_latest

Переходим в директорию с клиентом:
cd pool_client_latest

В ней мы увидим следующие файлы:
pool_client - исполняемый файл
tkeyapp.conf - файл конфигурации
install_dep.sh - скрипт для установки дополнительных зависимостей
launch.sh - скрипт для упрощённго запуска клиента с необходимыми параметрами

Устанавливаем права на все файлы:
sudo chmod 777 pool_client tkeyapp.conf install_dep.sh launch.sh


ЭТАП 4 - Запуск Pool Client и майнинг

Для запуска в фоновом режиме понадобится утилита screen. Устанавливаем:
sudo bash ./install_dep.sh

Имеется два варианта запуска.
Первый (рекомендуемый):
screen -L -dmS pool_client sudo ./pool_client IP:port ваш адрес

Второй (для профессионалов):
ВНИМАНИЕ: перед запуском отредактируйте launch.sh - замените адрес на свой.
sudo bash ./launch.sh

После запуска присоединяемся к клиенту:
screen -r pool_client
И вводим пароль пользователя, если нужно.
Если критических ошибок не возникнет, через некоторое время увидим поле для ввода команд:
Pool Client >

Даём команду на майнинг:
start

Через некоторое время станет доступен хэшрейт. Проверить его можно командой:
getlocalhashps

Для проверки баланса введите:
getbalance

Всё, майнинг идёт, можно отключиться от клиента - сначала нажмите Ctrl + A, затем D.

Чтобы остановить майнинг, подключитесь к клиенту и выполните команду exit.