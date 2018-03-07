#!/usr/bin/env bash

export ORG="bluelens"
export IMAGE="bl-crawl"
export TAG='prod'
export NAMESPACE="prod"

docker login

docker build --no-cache -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $ORG/$IMAGE:$TAG
docker push $ORG/$IMAGE:$TAG

kubectl --namespace=$NAMESPACE set image deployment/$IMAGE $IMAGE=$ORG/$IMAGE:$TAG
kubectl --namespace=$NAMESPACE rollout status deployment/$IMAGE

#restart pod
kubectl --namespace=$NAMESPACE delete pod -l name=$IMAGE

