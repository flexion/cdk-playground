# Setup
```
docker build -t cdktf .
```

# To run `cdktf` commands
You can use the `./run-via-docker.sh`, e.g.:
```
./run-via-docker.sh 'cdktf init --template="python" --local'
```
or, you can use your IDE's ability to run your workspace in Docker (e.g. vscode's remote containers) - just select the Dockerfile in the workspace.
