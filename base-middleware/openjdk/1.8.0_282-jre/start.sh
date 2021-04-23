#!/bin/sh -x
LANG=zh_CN.UTF-8
APP_PATH=/axs/appsystems
LOG_PATH=/axs/applogs
service_name=${SERIVCE_NAME}
server_port=${SERVER_PORT}

JAVA_HOME="/axs/middleware/openjdk"
PATH=${PATH}:$JAVA_HOME/bin
JAVA=$JAVA_HOME/bin/java

JVM_OPTS="${JAVA_MEM_OPTS:--Xms1024M -Xmx1024M -Xmn256M}"
GC_OPTS="-XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:+CMSInitiatingOccupancyFraction=70 -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -verbose:gc -Xloggc:$LOG_PATH/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=200M -Djava.net.perferIPv4Stack=true"

#SW_OPTS="-javaagent:$SW_JAR_FILE -Dskywalking.agent.service_name=$service_name -Dskywalking.collector.backend_service=$SW_BACKEND_SERVICES"

USER_OPTS="-Dfile.encoding=utf-8"

CLASSPATH="$APP_PATH/config/:$JAVA_HOME/lib/tools.jar:`ls $APP_PATH/lib/*.jar 2>/dev/null | awk '{print $1":"}'`:`ls $JAVA_HOME/lib/*.jar 2>/dev/null | awk '{print $1":"}'`"

EXTRA_JAVA_OPTS="org.springframework.boot.loader.JarLauncher"

export $APP_PATH $LOG_PATH $JAVA_HOME $JVM_OPTS $GC_OPTS $SW_OPTS $USER_OPTS $CLASSPATH $EXTRA_JAVA_OPTS

echo "====runing===="
JAVA_COMMAND="$JAVA $JVM_OPTS $GC_OPTS $SW_OPTS $USER_OPTS $CLASSPATH $EXTRA_JAVA_OPTS"
echo $JAVA_COMMAND
exec $JAVA_COMMAND
