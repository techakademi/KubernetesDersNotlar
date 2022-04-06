#!/bin/sh

servisadi=httpd

echo ""
echo "--------------------------------------"
echo "    Merhaba, ben Init Droid v1 :)     "
echo "--------------------------------------"
sleep 3
echo ""
echo "--------------------------------------"
echo "$servisadi Kontrolüne başladım."
echo "--------------------------------------"
echo ""
sleep 3

if ps ax | grep -v grep | grep $servisadi > /dev/null
then
    echo ""    
    echo "Tebrikler, $servisadi servisi çalışıyor."
    echo ""
else
    echo ""    
    echo "Üzgünüm, $servisadi servisi çalışmıyor."
    echo ""
fi
sleep 3
echo "--------------------------------------"
echo "$servisadi Servisini başlatıyorum."
echo "--------------------------------------" 

busybox httpd

if ps ax | grep -v grep | grep $servisadi > /dev/null
sleep 3
then    
    echo "$servisadi Servisi başlattım, şu an çalışıyor."
else    
    echo "Üzgünüm, $servisadi servisi Başlatamadım."
fi
sleep 3
echo "**************************************" 
echo "         Kontrol tamamlandı.          "
echo "**************************************"  