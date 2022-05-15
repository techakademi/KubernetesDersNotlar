#!/bin/sh

echo isleme baslama zamani:
date +"%H:%M:%S"

echo Mevcut Firewall kurallarinin yedegini aliyorum.
echo --------------------------------------
sudo iptables-save > ~/iptables-kurallar-yedek
sleep 2
echo yedek Kontrolünü gerceklestiriyorum
ls | grep iptables-kurallar-yedek
sleep 2
echo -----------------------------------------------------------------
echo Kurallari degistiriyorum, DROP ve REJECT kurallarını temizliyorum.
echo -----------------------------------------------------------------
grep -v "DROP" iptables-kurallar-yedek > tmpfile && mv tmpfile iptables-kurallar-degisen
grep -v "REJECT" iptables-kurallar-degisen > tmpfile && mv tmpfile iptables-kurallar-degisen
sleep 2
echo Yeni kurallari uyguluyorum.
echo ---------------------------
sudo iptables-restore < ~/iptables-rules-degisen
# Kubernetes & Weave'in ihtiyaç duyduğu TCP portları. 
sudo iptables -A INPUT -p tcp -m multiport --dports 80,443,2379,2380,6443,8090,8091,10250,10251,10252,10255,6783  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --dports 80,443,2379,2380,6443,8090,8091,10250,10251,10252,10255,6783 -m conntrack --ctstate ESTABLISHED -j ACCEPT
# Pod & Servislerin ihtiyaç duyduğu TCP portlar. 
sudo iptables -A INPUT -p tcp -m multiport --dports 30000:32767  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --dports 30000:32767 -m conntrack --ctstate ESTABLISHED -j ACCEPT
# Weave'in ihtiyaç duyduğu UDP portlar.
sudo iptables -A INPUT -p udp -m multiport --dports 6783,6784,8472  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p udp -m multiport --dports 6783,6784,8472 -m conntrack --ctstate ESTABLISHED -j ACCEPT
# Ssh bağlantısı için ihtiyaç duyulan port.
sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sleep 2
echo Yeni kurallari kontrol ediyorum.
echo ---------------------------
sudo iptables -L
sleep 2
echo Degisiklikleri kayit ediyorum.
echo ---------------------------
sudo netfilter-persistent save
sudo /sbin/iptables-save
sleep 2
echo Iptables servisini restart ediyorum.
echo ---------------------------
sudo systemctl restart iptables
echo islemi tamamlama zamani:
date +"%H:%M:%S"