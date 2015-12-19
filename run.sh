#!/bin/sh
service tomcat7 start

# link mounted source directory to opengrok
ln -s /src $OPENGROK_INSTANCE_BASE/src

#Reindex listener. This folder is used to signal the docker
#container when to do a OpenGrok index.
ln -s /reindex $OPENGROK_INSTANCE_BASE/reindex

# first-time index
echo "** Running first-time indexing"
cd /opengrok/bin
./OpenGrok index

# ... and we keep running the indexer to keep the container on
echo "** Waiting for source updates..."
touch $OPENGROK_INSTANCE_BASE/reindex
inotifywait -mr -e CLOSE_WRITE $OPENGROK_INSTANCE_BASE/reindex | while read f; do
  printf "*** %s\n" "$f"
  echo "*** Updating index"
  ./OpenGrok index
done
