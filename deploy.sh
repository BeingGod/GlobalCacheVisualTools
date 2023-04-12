#!/bin/bash
set -x
SCRIPT_HOME=$(cd $(dirname $0)/; pwd)

BACKEND_PATH=$SCRIPT_HOME/backend
FRONTEND_PATH=$SCRIPT_HOME/frontend
SCRIPTS_PATH=$SCRIPT_HOME/scripts

# === mysql ===
MYSQL_USER=mysql_user # mysql用户
MYSQL_PWD=mysql_pwd # mysql密码
# === redis ===
REDIS_PWD=redis_pwd # redis密码
# === xxl-job ===
XXL_JOB_ADMIN_PASSWD=admin_passwd # xxl-job admin密码
PATH_TO_XXL_JOB=$BACKEND_PATH/log/xxl-job # xxl-job日志路径
# === others ===
PUBLIC_IP=192.168.1.1 # 集群公网IP
DEPLOY_PATH=$SCRIPT_HOME # 部署路径

function usage() 
{
    printf "Usage: deploy.sh <command> \n support command: conf, install, run \n"
}

function conf_global_cache_web_server()
{
    BACKEND_YML=$BACKEND_PATH/src/main/resources/application.yml
    LOGBACK_XML=$BACKEND_PATH/src/main/resources/logback.xml 

    # === redis ===
    sed -i "s#redis_passwd#$REDIS_PWD#g" $BACKEND_YML

    # === mysql ===
    sed -i "s#mysql_passwd#$MYSQL_PWD#g" $BACKEND_YML 
    sed -i "s#mysql_user#$MYSQL_USER#g" $BACKEND_YML

    # === xxl-job ===
    sed -i "s#path_to_xxl-job#$PATH_TO_XXL_JOB#g" $BACKEND_YML
    sed -i "s#admin_passwd#$XXL_JOB_ADMIN_PASSWD#g" $BACKEND_YML
    
    # === sl4j ===
    sed -i "s#<deploy path of GlobalCacheWebServer>#$DEPLOY_PATH#g" $LOGBACK_XML

} 

function conf_global_cache_visual()
{
    CONF_JS=$FRONTEND_PATH/vue.config.js

    sed -i "s#0.0.0.0#$PUBLIC_IP#g" $CONF_JS

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
}

function conf_xxl_job()
{
    XXL_JOB_CONF=$BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/src/main/resources/application.properties
    XXL_JOB_LOGBACK=$BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/src/main/resources/logback.xml

    # === port ===
    sed -i "s#server.port=8080#server.port=9090#g" $XXL_JOB_CONF

    # === mysql ===
    sed -i "s#spring.datasource.username=root#spring.datasource.username=$MYSQL_USER#g" $XXL_JOB_CONF
    sed -i "s#spring.datasource.password=root_pwd#spring.datasource.password=$MYSQL_PWD#g" $XXL_JOB_CONF

    # === sl4j ===
    sed -i "s#/data/applogs#$BACKEND_PATH/log#g" $XXL_JOB_LOGBACK 
}

function install()
{
    cd $BACKEND_PATH
    bash $BACKEND_PATH/build.sh

    cd $FRONTEND_PATH
    bash $FRONTEND_PATH/build.sh

    cp -r $SCRIPTS_PATH /home/GlobalCacheScripts
}

function run()
{
    # === run xxl-job ===
    cd $BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/target
    jar=$(ls *.jar)
    java -jar $BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/target/$jar &
    
    # === run web server ===
    cd $BACKEND_PATH/target
    jar=$(ls *.jar)
    java -jar $BACKEND_PATH/target/$jar & 
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

    rm -rf $FRONTEND_PATH/node_modules
    rm -rf $FRONTEND_PATH/dist 
}

function main()
{
    case $1 in
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
        clean)
            clean
            ;;
        *)
            usage
    esac
}
main $1