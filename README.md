# docker-opengrok

The one-liner to spin up a code search engine

OpenGrok is a code search engine made by Sun (and now Oracle). It provides
similar functions to [LXR](http://lxr.linux.no/) but more. This project
encapsulated OpenGrok into a docker container. Allowing you to start an
instance of OpenGrok by one command.

## Usage

To start the OpenGrok, simply run:

```sh
docker run -d -v [source to be indexed on host]:/src -p [public port]:8080 steinwaywhw/opengrok
```

It may take a while for the indexer to finish the first-time indexing, after
that, the search engine is available at `http://host:[public port]/source/`.

## Note

The project supports dynamic index updating through `inotifywait` recursively on the source folder. However, `touch` doesn't help. You should add or delete or modify the content of some source file to make it happen.

## Radde, build and run docker
```
git clone git@github.com:lekanovic/docker-opengrok.git
cd docker-opengrok
sudo docker build -t lekanovic/radovan .
sudo docker run -v /home/radovan/projects/git-1.9.1:/src -v /home/radovan/projects/index/:/reindex -p 9090:8080 lekanovic/radovan
```
