#!/bin/sh

start() 
{
    local dir=$(getDir $1)
    if [[ "$dir" == "" ]];
    then
      printfError
      exit
    fi

    echo "Start $dir"

    cd $dir
    docker-compose up -d
    cd ..
}

stop() 
{
    local dir=$(getDir $1)
    echo "Stop $dir"

    cd $dir
    docker-compose up -d
    cd ..
}

getDir() 
{
    infra=$1
    local dir=''

    case "$infra" in
    sonar|sonar_qube|sonarqube|sonar-qube)
        dir="sonar-qube"
        ;;
    mysql)
        dir="mysql"
        ;;
    kafka)
        dir="kafka"
        ;;
    esac

    echo $dir
}

printfError()
{
  echo "Usage: `basename $0` action infrastructure"
  echo "Usage: `basename $0` [start|stop|status] [sonar|mysql|kafka]"
}

main() 
{
    case "$1" in
        start)
            start $2
            ;;
        stop)
            start $2
            ;;
        status)
            ;;
        *)
            printfError
            exit 1
    esac

}

main $*