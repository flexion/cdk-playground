```
docker build -t cdktf .
mkdir hello-terraform
cd hello-terraform
../run-via-docker.sh 'cdktf init --template="python" --local'
```