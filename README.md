# Docker container signal trap

You will need access to the demo organisation in Pulumi Cloud. Talk to Piers if you don't.
You will also need your Pulumi Cloud Access token in the env var `PULUMI_ACCESS_TOKEN`.

This will be run against an EKS cluster in an AWS account. The EKS cluster has no available nodes and so the deployment will time out waiting for the pods to be available. However, the container should be stopped before that happens. 

As long as you have access to the demo org in Pulumi Cloud, this uses ESC for credentials so you should be fine.

## Running

1. Build the docker image: `docker build -t container-stop .`
1. Run the container: `docker run -e PULUMI_ACCESS_TOKEN=$PULUMI_ACCESS_TOKEN --name container-stop -v "$(pwd)":/pulumi/projects container-stop`
1. In another terminal window (or docker desktop or other GUI if you're using that) stop the container: `docker stop container-stop`
