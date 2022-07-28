#! /bin/bash

tag=latest

while [[ $1 != "" ]]; do
    case $1 in
        --tag )
            tag=$2
            ;;
    esac
    shift
done

docker build -t lamastex/minimal:$tag ./minimal/
docker build -t lamastex/base:$tag ./base/
docker build -t lamastex/zeppelin:$tag ./zeppelin/
docker build -t lamastex/jupyter:$tag ./jupyter/
docker build -t lamastex/kafka:$tag ./kafka/
