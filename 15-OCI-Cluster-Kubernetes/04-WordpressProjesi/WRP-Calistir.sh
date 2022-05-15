#!/bin/sh
echo "Calistirmaya Başlıyorum :)"

sleep 1
echo ""
kubectl apply -f 00-Mysql-Secret.yml

sleep 1
echo ""
kubectl apply -f 01-Mysql-Configmap.yml

sleep 1
echo ""
kubectl apply -f 02-Mysql-Pv-Pvc.yml

sleep 1
echo ""
kubectl apply -f 03-Mysql-Deployment.yml

sleep 1
echo ""
kubectl apply -f 04-Mysql-Service.yml

sleep 1
echo ""
kubectl apply -f 06-Wordpress-Configmap.yml

sleep 1
echo ""
kubectl apply -f 07-Wordpress-Pv-Pvc.yml

sleep 1
echo ""
kubectl apply -f 08-Wordpress-Deployment.yml

sleep 5
echo ""
kubectl apply -f 09-Wordpress-Service.yml

sleep 1
echo "Calisma Tamamlandı :)"