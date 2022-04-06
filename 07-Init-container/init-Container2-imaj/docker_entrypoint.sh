#!/bin/sh
repoadres=https://github.com/techakademi/merhaba_kube.git
repoad=Merhaba_Kubernetes

echo "--------------------------------------"
echo "    Merhaba, ben Init Droid v2 :)     "
echo "--------------------------------------"
sleep 3
echo ""
echo "--------------------------------------"
echo "$repoad Repo Kontrolüne başladım."
echo "--------------------------------------"
echo ""
sleep 3

git ls-remote ${repoadres} -h
gitExitCode=$?

if [ $gitExitCode = 0 ]; then
  echo "Tebrikler, $repoad Repo mevcut."
  echo "**************************************" 
  echo "         Kontrol tamamlandı.          "
  echo "**************************************" 
  exit 0
else
  echo "Üzgünüm, $repoad Repo mevcut değil !!!."
  echo "**************************************" 
  echo "         Kontrol tamamlandı.          "
  echo "**************************************" 
  exit 1
fi
