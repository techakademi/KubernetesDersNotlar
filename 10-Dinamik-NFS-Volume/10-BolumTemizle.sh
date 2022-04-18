#!/bin/sh
echo "Temizliğe Başlıyorum :)"
sleep 0.5

echo ""
echo "Loglama Konteynerini siliyorum..."
kubectl delete -f 19-PVC_Loglama_Containeri.yml

sleep 1

echo ""
echo "Veri Konteynerini siliyorum..."
kubectl delete -f 18-PVC_Containeri.yml

sleep 1
echo ""
echo "Log'lama Cliem'ını siliyorum..."
kubectl delete -f 19-Dinamik-Nfs-pvc-log.yml

sleep 1

echo ""
echo "Veri Cliem'ını siliyorum..."
kubectl delete -f 18-Dinamik-Nfs-pvc.yml


sleep 1
echo ""
echo "Temizlik Tamamlandı :)"

sleep 0.5