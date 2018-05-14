# My Docker CheatSheet

## Dockerhub

* Login: ```sudo docker login``` (will ask for username and password...)
* Tag and image: sudo docker tag image dockerhubUsername/tag
* Push the tag: sudo docker push /dockerhubUsername/tag

## Launch args

* ***Delete container on stop***: ```--rm```

## Attaching and detaching

* **Attach to a container with a name or id of *name***: ```sudo docker attach name```
* **Detach from it without stopping**: ```CRTL+P CRTL+Q```
