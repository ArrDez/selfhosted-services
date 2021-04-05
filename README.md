# Selfhosted Services

Selfhosted services i am using, running on a VPS

## Services

  - [Traefik](https://github.com/traefik/traefik) - load balancer, with LetsEncrypt and DNS-01 challenge (Cloudflare)
  - [Firefly III](https://github.com/firefly-iii/firefly-iii) - personal finance manager 
  - [Wallabag](https://github.com/wallabag/wallabag) - read later list
  - [Shaarli](https://github.com/shaarli/Shaarli) - bookmarking service
  - [linkding](https://github.com/sissbruecker/linkding) - another bookmarking service (don't ask why)

## Description 

Traefik service lives in the root folder. Others services live in their own directory and represented by a docker-compose.yml file.
    
## Using script

Repo includes `service.sh` script. It's a wrapper around docker-compose with some additions. All arguments after the service name are passed directly to docker-compose.

```shell
$ ./service.sh fireflyiii up -d
$ ./service.sh fireflyiii logs
$ ./service.sh fireflyiii backup # Exec backup.sh script in the service dir
```

## Starting from scratch
1. Get your Cloudflare API token ([more info](https://go-acme.github.io/lego/dns/cloudflare/#api-tokens))
2. Put Cloudflare API token under `secrets/cf_dns_api_token.secret`
3. Run Traefik service
    
  ```shell
    $ docker-compose up -d
  ```

4. Start running other services

```shell
$ ./service.sh fireflyiii up -d
$ ./service.sh wallabag up -d
...
```