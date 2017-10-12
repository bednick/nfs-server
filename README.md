Docker NFS Server
================

Usage
----
```bash
docker network create nfs-network
```


```bash
docker run -d --name nfs --privileged --network=nfs-network  nikkollaii/nfs-server  
```

```bash
docker run -d --name nfs-client --privileged --network=nfs-network  nikkollaii/nfs-client  
``` 

