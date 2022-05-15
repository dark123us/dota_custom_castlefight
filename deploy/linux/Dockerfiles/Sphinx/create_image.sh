VER=v1
NAME=doc-builder
REGISTER=hub.cap.by:443
# PATHBACK=/home/dark123us/projects/services/back
# PATHTO=/home/dark123us/projects/services/deploy/build/deploy/back

# mkdir -p $PATHTO
# echo "sudo mount -o bind $PATHBACK $PATHTO "
# sudo mount -o bind $PATHBACK $PATHTO 
# docker system prune -a
# sleep 30

docker build . -t $NAME:$VER
docker tag $NAME:$VER $REGISTER/$NAME:$VER
docker push $REGISTER/$NAME:$VER

# sudo umount $PATHTO

