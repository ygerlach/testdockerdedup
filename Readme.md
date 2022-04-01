# Testdocker dedup

Are shared librarys shared over the bundary of containers or even images?

-> YES

This test creates 3 test images to prove that.
One Baseiamge (with 100mb shared library)
Two Appimages (that extend Baseimage)

After building the images a few containers of each type can be created and started.
Watching the hosts memory usage shows, that there is no big increase. So the containers have successfully shared the library across container and image boundarys.

commands for building:

```
docker build -f base.Dockerfile . -t testingbase
docker build -f app.Dockerfile . -t testingapp
docker build -f app2.Dockerfile . -t testingapp2
```

commands for testing (this assumes, no other containers are available):
```
# spawn containers (repeat commands x tiems)
docker container create testingapp:latest
docker container create testingapp2:latest

# start containers (watch mem usage)
docker container start $(docker ps -aq)

# check memusage of each container with 
docker stats
# or
sudo htop

# notice, how every container has ~100 MB shared Mem but the system memory usage is not going up by x * 100 MB so its realy shared and not only looking like it.

# stop and remove containers
docker container kill $(docker ps -aq)
docker container rm $(docker ps -aq)
```

This was tested with docker 20.10.7 using the btrfs storage driver on Ubuntu 21.10 (linux 5.13.0-39-generic)
