sudo docker ps -a | awk '{print $1}' | grep -v CONTAINER | xargs -n 1 sudo docker kill
sudo docker ps -a | awk '{print $1}' | grep -v CONTAINER | xargs -n 1 sudo docker rm
