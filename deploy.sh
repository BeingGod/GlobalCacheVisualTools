#!/bin/bash
set -x
SCRIPT_HOME=$(cd $(dirname $0)/; pwd)

BACKEND_PATH=$SCRIPT_HOME/backend
FRONTEND_PATH=$SCRIPT_HOME/frontend
SCRIPTS_PATH=$SCRIPT_HOME/scripts

# === mysql ===
MYSQL_USER=mysql_user
MYSQL_PWD=mysql_pwd
# === redis ===
REDIS_PWD=redis_pwd
# === xxl-job ===
XXL_JOB_ADMIN_PASSWD=admin_passwd
PATH_TO_XXL_JOB=$BACKEND_PATH/log/xxl-job
# === others ===
PUBLIC_IP=192.168.1.1
DEPLOY_PATH=$SCRIPT_HOME

function usage() 
{
    printf "Usage: deploy.sh <command> \n support command: conf, install, run \n"
}

function conf_global_cache_web_server()
{
    BACKEND_YML=$BACKEND_PATH/src/main/resources/application.yml
    LOGBACK_XML=$BACKEND_PATH/src/main/resources/logback.xml 

    # === redis ===
    sed -i '' "s#redis_passwd#$REDIS_PWD#g" $BACKEND_YML

    # === mysql ===
    sed -i '' "s#mysql_passwd#$MYSQL_PWD#g" $BACKEND_YML 
    sed -i '' "s#mysql_user#$MYSQL_USER#g" $BACKEND_YML

    # === xxl-job ===
    sed -i '' "s#path_to_xxl-job#$PATH_TO_XXL_JOB#g" $BACKEND_YML
    sed -i '' "s#admin_passwd#$XXL_JOB_ADMIN_PASSWD#g" $BACKEND_YML
    
    # === sl4j ===
    sed -i '' "s#<deploy path of GlobalCacheWebServer>#$DEPLOY_PATH#g" $LOGBACK_XML

} 

function conf_global_cache_visual()
{
    CONF_JS=$FRONTEND_PATH/vue.config.js

    sed -i '' "s#0.0.0.0#$PUBLIC_IP#g" $CONF_JS
}

function conf_xxl_job()
{
    XXL_JOB_CONF=$BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/src/main/resources/application.properties
    XXL_JOB_LOGBACK=$BACKEND_PATH/3rdparty/xxl-job/xxl-job-admin/src/main/resources/logback.xml

    # === mysql ===
    sed -i '' "s#spring.datasource.username=root#spring.datasource.username=$MYSQL_USER#g" $XXL_JOB_CONF
    sed -i '' "s#spring.datasource.password=root_pwd#spring.datasource.password=$MYSQL_PWD#g" $XXL_JOB_CONF

    # === sl4j ===
    sed -i '' "s#/data/applogs#$BACKEND_PATH/log#g" $XXL_JOB_LOGBACK 
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
        *)
            usage
    esac
}
main $1