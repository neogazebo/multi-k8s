docker build -t neogazebo/multi-client:latest -t neogazebo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t neogazebo/multi-server:latest -t neogazebo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t neogazebo/multi-worker:latest -t neogazebo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push neogazebo/multi-client:latest
docker push neogazebo/multi-server:latest
docker push neogazebo/multi-worker:latest

docker push neogazebo/multi-client:$SHA
docker push neogazebo/multi-server:$SHA
docker push neogazebo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=neogazebo/multi-server:$SHA
kubectl set image deployments/client-deployment client=neogazebo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=neogazebo/multi-worker:$SHA