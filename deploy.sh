docker build -t alexyey/multi-client:latest -t alexyey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexyey/multi-server:latest -t alexyey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexyey/multi-worker:latest -t alexyey/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alexyey/multi-client:latest
docker push alexyey/multi-server:latest
docker push alexyey/multi-worker:latest
docker push alexyey/multi-client:$SHA
docker push alexyey/multi-server:$SHA
docker push alexyey/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexyey/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexyey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexyey/multi-worker:$SHA