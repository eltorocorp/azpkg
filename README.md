# Amazon Linux pkg

## building the docker

1. install docker on your system
2. ```sh
git clone git@github.com:eltorocorp/azpkg.git
cd azpkg
docker build .
```
3. Note the container ID on the last line.

## Running the docker

```sh
docker run -it [container_id] bash
```
