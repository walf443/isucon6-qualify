#!/bin/bash -ex

echo "start deploy by $USER" | slackboard-cli -t general -s 127.0.0.1:29800
GOOS=linux make
for server in tester
do
    echo $server
    scp ./isuda isucon@$server:/home/isucon/webapp/go/isuda_new
    ssh -t $server "sudo -u isucon mv /home/isucon/webapp/go/isuda_new /home/isucon/webapp/go/isuda"
    ssh -t $server "sudo systemctl restart isuda.service"
    scp ./isutar isucon@$server:/home/isucon/webapp/go/isutar_new
    ssh -t $server "sudo -u isucon mv /home/isucon/webapp/go/isutar_new /home/isucon/webapp/go/isutar"
    ssh -t $server  "sudo systemctl restart isutar.service"
done
echo "finish deploy @here by $USER" | slackboard-cli -t general -s 127.0.0.1:29800
