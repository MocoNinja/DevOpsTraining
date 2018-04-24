# Useful pieces of code

## Docker

### Remove all exited containers

```shell
	sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm
```
