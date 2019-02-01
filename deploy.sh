docker build -t sefrota/multi-client:latest -t sefrota/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sefrota/multi-server:latest -t sefrota/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sefrota/multi-worker:latest -t sefrota/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sefrota/multi-client:latest
docker push sefrota/multi-client:$SHA
docker push sefrota/multi-server:latest
docker push sefrota/multi-server:$SHA
docker push sefrota/multi-worker:latest
docker push sefrota/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sefrota/multi-server:$SHA
kubectl set image deployments/client-deployment client=sefrota/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sefrota/multi-worker:$SHA
