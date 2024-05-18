#!/bin/bash
if docker ps | grep -q dheera_ml
then
    docker exec -it dheera_ml /bin/bash
else
    echo "(starting)"
    docker rm dheera_ml 2>/dev/null
    docker run \
        -e DISPLAY \
        -e DBUS_SESSION_BUS_ADDRESS \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /home/dheera:/home/dheera \
        -v $XAUTHORITY:/root/.Xauthority \
        --net=host \
        --name dheera_ml \
        --privileged \
        --runtime nvidia \
        -it dheera:ml /bin/bash
fi

