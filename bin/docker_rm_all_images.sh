sudo docker images | awk '{print $3}' | grep -v IMAGE | xargs -n 1 sudo docker rmi
