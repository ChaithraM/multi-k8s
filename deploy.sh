docker build -t chaimailankody/multi-client:latest -t chaimailankody/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chaimailankody/multi-server:latest -t chaimailankody/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chaimailankody/multi-worker:latest -t chaimailankody/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chaimailankody/multi-client:latest
docker push chaimailankody/multi-server:latest
docker push chaimailankody/multi-worker:latest

docker push chaimailankody/multi-client:$SHA
docker push chaimailankody/multi-server:$SHA
docker push chaimailankody/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chaimailankody/multi-server:$SHA
kubectl set image deployments/client-deployment client=chaimailankody/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chaimailankody/multi-worker:$SHA