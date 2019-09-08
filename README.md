## Create EKS cluster
```
$ cd ./terraform/local

# edit configuration
$ vi main.tf

$ terraform apply

$ make create-roleconfig
```

## Helm deploy dashboard
```
$ cd ./helm

$ make init

$ make install-dashboard
```
