ß#!/bin/bash
# Bu skript ile, Ubuntu işletim sistemine yeni Kubernetes'in son sürümün yükleme işlemini gerçekleştirebilirsiniz.
echo
echo -------------------------------------------------------------------------------------
echo "Merhaba, Ben Kubernetes için Helm kuracak olan Droid'inim."
echo -------------------------------------------------------------------------------------
sleep 2
# Helm paketi indir
echo
echo -------------------------------------------------------------------------------------
echo "Github'dan helm skriptini indiriyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sleep 1

# Skripte çalışma izni ver
echo
echo -------------------------------------------------------------------------------------
echo "Helm skriptine çalışma izni veriyorum :)"
echo -------------------------------------------------------------------------------------
sleep 2
echo
chmod 700 get_helm.sh
sleep 1

# Helm kur
echo
echo -------------------------------------------------------------------------------------
echo "Helm'i kuruyorum"
echo -------------------------------------------------------------------------------------
sleep 2
echo
./get_helm.sh
sleep 1

# Kurulum tamam
echo
echo -------------------------------------------------------------------------------------
echo "Helm kurulumu tamamlandı"
echo -------------------------------------------------------------------------------------
sleep 2