#!/bin/bash
set -x
SCRIPT_HOME=$(cd $(dirname $0)/; pwd)
BACKEND_PATH=$SCRIPT_HOME/backend
FRONTEND_PATH=$SCRIPT_HOME/node_modules/GlobalCacheVisual
SCRIPTS_PATH=$SCRIPT_HOME/scripts

# === mysql ===
MYSQL_USER=mysql_user # mysql用户
MYSQL_PWD=mysql_pwd # mysql密码
# === redis ===
REDIS_PWD=redis_pwd # redis密码
# === xxl-job ===
PATH_TO_XXL_JOB=$BACKEND_PATH/log/xxl-job # xxl-job日志路径
# === others ===
PUBLIC_IP=192.168.1.1 # 集群公网IP
DEPLOY_PATH=$SCRIPT_HOME # 部署路径

function usage() 
{
    printf "Usage: deploy.sh <command> \n support command: conf, install, run \n"
}

function install_nginx()
{
    echo "[WARN] install nginx start"

    yum install -y nginx

    setenforce permissive
    sed -i 's#SELINUX=enforcing#SELINUX=permissive#g' /etc/selinux/config

    systemctl start nginx														   
    systemctl enable nginx

    echo "[WARN] install nginx end"
}

function install_mongodb()
{
    echo "[WARN] install mongodb start"

    cd /home

    yum -y install python2 python2-setuptools python2-devel net-tools

    if [ ! -f "/home/mongo-4.0.12-1.el7.aarch64.rpm" ]; then
        wget https://mirrors.huaweicloud.com/kunpeng/yum/el/7/aarch64/Packages/database/mongo-4.0.12-1.el7.aarch64.rpm --no-check-certificate
    fi

    if [ ! -f "/home/mongodb-tools-4.0.6-1.aarch64.rpm" ]; then
        wget https://mirrors.huaweicloud.com/kunpeng/yum/el/7/aarch64/Packages/database/mongodb-tools-4.0.6-1.aarch64.rpm --no-check-certificate
    fi

    yum install -y mongo-4.0.12-1.el7.aarch64.rpm mongodb-tools-4.0.6-1.aarch64.rpm 

    mkdir -p /data/mongo

    rm -f /etc/mongodb.cnf

    echo "dbpath=/data/mongo
logpath=/data/mongo/mongo.log
logappend=true
port=27017
fork=true
auth=false
bind_ip=0.0.0.0" > /etc/mongodb.cnf

    echo "[WARN] install mongodb end"
}

function install_redis()
{
    echo "[WARN] install redis start"

    cd /home

    if [ ! -f "/home/redis-6.2.11.tar.gz" ]; then
        wget https://download.redis.io/releases/redis-6.2.11.tar.gz --no-check-certificate
    fi

    tar -xzvf redis-6.2.11.tar.gz

    mv redis-6.2.11 redis
    
    cd redis
    make -j
    make install

    sed -i "s/# ignore-warnings ARM64-COW-BUG/ignore-warnings ARM64-COW-BUG/g" redis.conf
    sed -i "s/# bind 127.0.0.1 -::1/bind 127.0.0.1 -::1/g" redis.conf
    sed -i "s/protected-mode yes/protected-mode no/g" redis.conf
    sed -i "s/daemonize no/daemonize yes/g" redis.conf 
    sed -i "s/# requirepass foobared/requirepass $REDIS_PWD/g" redis.conf
    sed -i 's#logfile ""#logfile "/var/log/redis/redis.log"#g' redis.conf

    mkdir -p /var/log/redis

    echo "[WARN] install redis end"
}

function install_mysql()
{
    echo "[WARN] install mysql start"

    cd /home

    mkdir -p /data/mysql
    cd /data/mysql
    if [ -d "/data/mysql/data" ]; then
        rm -rf /data/mysql/data
    fi

    mkdir data tmp run log relaylog

    chown -R mysql:mysql /data/mysql

    yum install -y mysql

    echo "[mysqld_safe]
log-error=/data/mysql/log/mysql.log
pid-file=/data/mysql/run/mysqld.pid
[mysqldump]
quick
[mysql]
no-auto-rehash
[client]
default-character-set=utf8
[mysqld]
basedir=/usr/local/mysql
socket=/data/mysql/run/mysql.sock
tmpdir=/data/mysql/tmp
datadir=/data/mysql/data
default_authentication_plugin=mysql_native_password
port=3306
user=mysql" > /etc/my.cnf

    chown mysql:mysql /etc/my.cnf
    chmod 755 /data/mysql/data/

    if [ $(cat "/etc/profile" | grep -oe "export PATH=$PATH:/usr/local/mysql/bin" | wc -l ) -eq 0 ]; then
        echo "export PATH=$PATH:/usr/local/mysql/bin" >> /etc/profile
        source /etc/profile
    fi

    echo "[WARN] install mysql end"
}

function conf_global_cache_web_server()
{
    echo "[WARN] configure global cache web server start"

    BACKEND_YML=$BACKEND_PATH/src/main/resources/application.yml
    LOGBACK_XML=$BACKEND_PATH/src/main/resources/logback.xml 

    # === redis ===
    sed -i "s#redis_passwd#$REDIS_PWD#g" $BACKEND_YML

    # === mysql ===
    sed -i "s#mysql_passwd#$MYSQL_PWD#g" $BACKEND_YML 
    sed -i "s#mysql_user#$MYSQL_USER#g" $BACKEND_YML

    # === xxl-job ===
    sed -i "s#path_to_xxl-job#$PATH_TO_XXL_JOB#g" $BACKEND_YML
    sed -i "s#admin_passwd#123456#g" $BACKEND_YML
    
    # === sl4j ===
    sed -i "s#<deploy path of GlobalCacheWebServer>#$DEPLOY_PATH#g" $LOGBACK_XML

    # === scripts path ===
    sed -i "s#<path to GlobalCacheScripts>#$SCRIPT_HOME/scripts#g" $BACKEND_YML 

    echo "[WARN] configure global cache web server end"
} 

function conf_global_cache_visual()
{
    echo "[WARN] configure global cache visual start"

    cd $SCRIPT_HOME

    if [ -f "$SCRIPT_HOME/GlobalCacheVisual.tgz" ]; then
        FRONTEND_PATH=$SCRIPT_HOME/node_modules/GlobalCacheVisual
        npm install --offline ./GlobalCacheVisual.tgz
    fi

    CONF_JS=$FRONTEND_PATH/vue.config.js
    API_JS=$FRONTEND_PATH/src/api/port.js

    sed -i "s#0.0.0.0#$PUBLIC_IP#g" $CONF_JS
    sed -i "s#0.0.0.0#$PUBLIC_IP#g" $API_JS

    cp /etc/nginx/nginx.conf /etc/nginx/nginx.bak

    echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       5000;
        listen       [::]:80 default_server;
        server_name  _;
        root         $FRONTEND_PATH/dist;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
}" > /etc/nginx/nginx.conf

    systemctl start nginx
    nginx -s reload

    echo "[WARN] configure global cache visual end"
}

function conf_xxl_job()
{
    echo "[WARN] configure xxl job start"

    XXL_JOB_CONF=$BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/src/main/resources/application.properties
    XXL_JOB_LOGBACK=$BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/src/main/resources/logback.xml

    # === port ===
    sed -i "s#server.port=8080#server.port=9091#g" $XXL_JOB_CONF

    # === mysql ===
    sed -i "s#spring.datasource.username=root#spring.datasource.username=$MYSQL_USER#g" $XXL_JOB_CONF
    sed -i "s#spring.datasource.password=root_pwd#spring.datasource.password=$MYSQL_PWD#g" $XXL_JOB_CONF

    # === sl4j ===
    sed -i "s#/data/applogs#$BACKEND_PATH/log#g" $XXL_JOB_LOGBACK 

    echo "[WARN] configure xxl job end"
}

function install()
{
    echo "[WARN] install global cache visual tools start"

    cd $BACKEND_PATH
    bash $BACKEND_PATH/build.sh

    cd $FRONTEND_PATH
    bash $FRONTEND_PATH/build.sh

    chmod 777 -R $SCRIPTS_PATH/data

    echo "[WARN] install global cache visual tools end"
}

function run()
{
    if [ ! -d "/var/log/gcache_vis_tools" ]; then
        mkdir -p /var/log/gcache_vis_tools/
    fi

    # launch redis
    if [[ $(ps -ef | grep "redis-server" | grep -v "grep" | wc -l) -eq 0 ]]; then
        redis-server /home/redis/redis.conf
    fi

    # launch mongo
    if [[ $(ps -ef | grep "/usr/local/mongo/bin/mongo" | grep -v "grep" | wc -l) -eq 0 ]]; then
        nohup /usr/local/mongo/bin/mongod -f /etc/mongodb.cnf > /var/log/gcache_vis_tools/mongod.log &
    fi 

    # launch mysql
    if [[ $(ps -ef | grep "mysqld --defaults-file=/etc/my.cnf &" | grep -v "grep" | wc -l) -eq 0 ]]; then
        mysqld --defaults-file=/etc/my.cnf &
    fi  

    # run xxl-job
    jar=$(ls $BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/target/*.jar)
    if [[ $(ps -ef | grep "$jar" | grep -v "grep" | wc -l) -eq 1 ]]; then
        pid=$(ps -ef | grep "$jar" | grep -v "grep" | awk -F " " {'print $2'})
        kill -9 $pid
    fi
    nohup java -jar $jar > /var/log/gcache_vis_tools/xxl-job.log &
    
    # run web server
    jar=$(ls $BACKEND_PATH/target/*.jar)
    if [[ $(ps -ef | grep "$jar" | grep -v "grep" | wc -l) -eq 1 ]]; then
        pid=$(ps -ef | grep "$jar" | grep -v "grep" | awk -F " " {'print $2'})
        kill -9 $pid
    fi
    nohup java -jar $jar > /var/log/gcache_vis_tools/hwbackend.log &
}

function stop()
{
    # === run web server ===
    jar=$(ls $BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/target/*.jar)
    if [[ $(ps -ef | grep "$jar" | grep -v "grep" | wc -l) -eq 1 ]]; then
        pid=$(ps -ef | grep "$jar" | grep -v "grep" | awk -F " " {'print $2'})
        kill -9 $pid
    fi

    # === stop xxl-job ===
    jar=$(ls $BACKEND_PATH/target/*.jar)
    if [[ $(ps -ef | grep "$jar" | grep -v "grep" | wc -l) -eq 1 ]]; then
        pid=$(ps -ef | grep "$jar" | grep -v "grep" | awk -F " " {'print $2'})
        kill -9 $pid
    fi
}

function clean()
{
    cd $BACKEND_PATH
    mvn clean

    cd $BACKEND_PATH/3rdparty/GlobalCacheSDK
    mvm clean

    cd $$BACKEND_PATH/3rdparty/xxl-job
    mvn clean

    cd $$BACKEND_PATH/3rdparty/xxl-job-auto-register
    mvn clean

    rm -rf $FRONTEND_PATH/dist
}

function main()
{
    case $1 in
        deps)
            install_nginx
            install_mongodb
            install_redis
            install_mysql
            ;;
        conf)
            conf_global_cache_visual
            conf_global_cache_web_server
            conf_xxl_job 
            ;;
        install)
            install
            ;;
        run)
            run
            ;;
        stop)
            stop
            ;;
        clean)
            clean
            ;;
        *)
            usage
    esac
}
main $1
