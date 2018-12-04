# Dockerized REDUS framework

A Docker container that can make the life of research scientists at the Norwegian Institute of Marine Research easier.

Please visit our Docker Hub organization
[page](https://hub.docker.com/u/redusimr/) and our Docker source GIT [repository](https://github.com/REDUS-IMR/fishdocker)
for under the hood stuffs.

## Pre-requisite

A running Docker. For Windows and MacOS users, you may install [Docker Desktop](https://www.docker.com/products/docker-desktop). 
You can test your Docker installation by opening the designated Docker shell for your OS (e.g., PowerShell in Windows) and type:

```
docker run hello-world

Unable to find image 'hello-world:latest' locally
Trying to pull repository docker.io/library/hello-world ... 
sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788: Pulling from docker.io/library/hello-world
d1725b59e92d: Pull complete 
Digest: sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788
Status: Downloaded newer image for docker.io/hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

## Running local REDUS pipeline

1. Clone this repository.

2. Copy (or clone) TAF/stockassessment.org repository into `projects` sub-directory. You may have several repositories inside the sub-directory.

3. Run `./runREDUS.sh` script from this repository root directory. (NOTE: In Linux, you'll need to run the script using `sudo`).

4. After the script finished, the results are available in the `results` sub-directory.

5. (For Linux users) You may want to run `./fixpermission.sh` script to fix the result files permission.

## Example

Please run the below commands inside the designated Docker shell:

```
git clone https://github.com/REDUS-IMR/docker-redus-pipeline.git
cd docker-redus-pipeline/projects
git clone https://github.com/ices-taf/2016_cod-347d.git
cd ..
./runREDUS.sh
ls results/2016_cod-347d/report

```

