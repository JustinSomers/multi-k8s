docker build -t justinsomers/multi-client:latest -t justinsomers/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t justinsomers/multi-server:latest -t justinsomers/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t justinsomers/multi-worker:latest -t justinsomers/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push justinsomers/multi-client:latest
docker push justinsomers/multi-server:latest
docker push justinsomers/multi-worker:latest

docker push justinsomers/multi-client:$SHA
docker push justinsomers/multi-server:$SHA
docker push justinsomers/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=justinsomers/multi-server:$SHA
kubectl set image deployments/client-deployment client=justinsomers/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=justinsomers/multi-worker:$SHA
