ß#!/bin/bash
# Bu skript ile, Ubuntu işletim sistemine yeni Kubernetes'in son sürümün yükleme işlemini gerçekleştirebilirsiniz.
echo
echo -------------------------------------------------------------------------------------
echo "Merhaba, Ben Kubernetes için K9s kuracak olan Droid'inim."
echo -------------------------------------------------------------------------------------
sleep 2
echo -------------------------------------------------------------------------------------
echo "!!Dikkat, ((ARM)) işlemci tipine göre tasarlandım!!!"
echo -------------------------------------------------------------------------------------

# local bin klasörüne git
echo
echo -------------------------------------------------------------------------------------
echo "Local bin klasörüne gidiyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
cd /usr/local/bin/
sleep 1

# Github'dan paket indirme işlemi
echo
echo -------------------------------------------------------------------------------------
echo "https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_arm.tar.gz paketini indiriyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo wget https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_arm.tar.gz
sleep 1

# Arşivi çıkar
echo
echo -------------------------------------------------------------------------------------
echo "k9s_Linux_arm.tar.gz Arşivi çıkarıyorum"
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo tar zxf k9s_Linux_arm.tar.gz
sleep 1

# K9s'i yeni bir ekran da çalıştır
echo
echo -------------------------------------------------------------------------------------
echo "K9s'i çalıştırmak için yeni bir ekran açmalısın."
echo -------------------------------------------------------------------------------------
sleep 2
echo "Yeni ekranda kullanacğımız komut: k9s"
sleep 1