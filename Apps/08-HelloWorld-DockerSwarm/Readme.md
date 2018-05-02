# Readme

This is based on [this article](https://codefresh.io/docker-tutorial/deploy-docker-compose-v3-swarm-mode-cluster/), being its purpose to learn the basics of docker swarms with compose files.
The docker-compose file of the article has been changed, so it does not limit resources.
We are using docker +1.13, so we are learning to work with the swarm and stack methodologies instead of the docker-compose one that we used to learn docker-compose.
\
**tl;dr**: run with:

```shell
docker deploy --compose-file docker-compose.yml VOTE
```

## Info

* Voting apps listen on *5000*
* Listing apps listen on *5001*