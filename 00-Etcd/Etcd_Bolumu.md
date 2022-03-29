
# Etcd'ye Giris
![14_etcd_demo](https://user-images.githubusercontent.com/66215655/143530621-e6654df1-166d-413a-84d3-02e97216a2b3.png)

----------------------------------------------------------------------
### Bu eğitim bölümünde, version 3.2 kullanıldığından, şu anki versiyonlar ile komutlar aynı olmayabilir, bu bölümün amacı ***etcd*** egitimi olmayip, ***etcd*** hakkında kısa bir bilgilendirmeden ibarettir.
---


**[etcd](https://etcd.io/)**, herhangi bir zaman noktasında clusterın  genel durumunu temsil eden, cluster yapılandırma verilerini güvenilir bir şekilde depolayan, CoreOS tarafından geliştirilmiş kalıcı, yüksek düzeyde kullanılabilir anahtar-değer ( key-value store) deposudur.


----------------------------------------------------------------------
## 1. Bölüm Etcd Kurulumunda, Sırası ile uygulayacağımız adımlar:
----------------------------------------------------------------------

Kurulum öncesi, mevcut ortamda yüklü olan ***etcd***'nin versiyonunu kontrol edelim:

```
etcd --version
```

Version kontrolü sonucu ekranda aşağıda ki gibi **'etcd'** bulunamadı yüklemek isterseniz
**"apt install etcd-server"** komutunu kullanabilirsiniz şeklinde yazı belirecektir.

Bu komut çıktısı, şu an bu sunucuda etcd'nin yüklü olmadığını belirtmektedir.

```
$ etcd --version

Command 'etcd' not found, but can be installed with:

apt install etcd-server
```

**etcd** kurulumunu gerçekleştirmek için aşağıdaki komutu kullanalım:

```
apt install etcd -y
```

Mevcut ekranı temizleyelim.

```
clear
```

Kurulumun tamamlanmasının ardından tekrar version kontrolünü gerçekleştirelim.

```
etcd --version
```

Kontrolün sonucu, aşağıda ki gibi ekran çıktısı oluşacaktır.
```
etcd --version
etcd Version: 3.2.26
Git SHA: Not provided (use ./build instead of go build)
Go Version: go1.13.7
Go OS/Arch: linux/amd64
```

Bu sonuçla, **etcd** kurulumunun başarılı bir şekilde gerçekleştiğini teyit edebiliriz.

Mevcut ekranı tekrar temizleyelim.

```
clear
```

----------------------------------------------------------------------
## 2. Bölüm Etcd'de veri oluşturma
----------------------------------------------------------------------

Etcd'de anahtar-değer deposu örneği için, Pod isimleri, Node ip ve Podların portlarını tanımlayacağımız anahtarlar oluşturalım.

Birinci Pod:

```
etcdctl set POD1 192.168.1.2:80
```

İkinci Pod:
```
etcdctl set POD2 192.168.1.2:88
```

Üçüncü Pod:
```
etcdctl set POD3 192.168.1.3:80
```

Dördüncü Pod:
```
etcdctl set POD4 192.168.1.3:88
```

Besinci Pod:
```
etcdctl set POD5 192.168.1.5:8080
```

Altinci Pod:
```
etcdctl set POD6 192.168.1.5:8081
```

Yedinci Pod:

Bu anahtar değeri oluştururken **-ttl**, ***("time to live",yaşama zamanı denmektedir)*** operatörünü kullanmaktayız, time to live, bir sistemde bir şeyin ne kadar süre yaşayacağını tayin etmek için kullanılır, bizim örneğimiz de belirttiğimiz süre **-ttl 10**  on saniyedir. Bu kayit, on saniye etcd'de var olup, sonrasında imha edilecektir.
```
etcdctl set POD7 192.168.1.5:8082 -ttl 10
```

Kayıt giriş işlemlerimizi bu şekilde tamamladıktan sonra, ilgili kayıtların okunması bölümüne gecelim.

Mevcut ekranı tekrar temizleyelim.
```
clear
```

----------------------------------------------------------------------
## 3. Bölüm Degerleri okuma
----------------------------------------------------------------------
Etcd'de kayıtlı anahtarların değerlerini okumak için aşağıdaki komutları kullanabiliriz.

Birinci Pod'a ait bilgileri okumak icin:
```
etcdctl get POD1
```

İkinci Pod'a ait bilgiler:
```
etcdctl get POD2
```

Üçüncü Pod'a ait bilgiler:
```
etcdctl get POD3
```

Dördüncü Pod'a ait bilgiler:
```
etcdctl get POD4
```

Besinci Pod'a ait bilgiler:
```
etcdctl get POD5
```

```
192.168.1.5:8080
```

Bu şekilde, oluşturduğumuz kayıt anahtarlarına ait değerleri okuyabiliriz.
Bu aşamaya kadar kullandigimiz kayıt okuma ile, o anahtara atanmış olan kaydı okuyabiliyorduk, ancak **etcd**'de tutulan kayıtlar bunlarla sınırlı değildir.
Herhangi bir kayda ait tüm bilgilere erişmek için, -o extended operatörü kullanilarak ek meta verilene erişebiliriz.

----
Altinci Pod'a ait bilgiler:
```
etcdctl -o extended get POD6
```

```
Key: /POD6
Created-Index: 100
Modified-Index: 100
TTL: 0
Index: 100

192.168.1.5:8081
```

-o extended ile, ilgili kayda ait detaylı bilgiye ulaşabilmekteyiz.
Bunun haricinde, ilgili kaydın çıktısını json olarak da almamız mümkün,

```
curl  -L http://127.0.0.1:2379/v2/keys/POD1
```

```
{"action":"get","node":{"key":"/POD5","value":"192.168.1.5:8080","modifiedIndex":95,"createdIndex":95}}
```

-o extended'den tek farki, bilgileri json formatinda vermesidir.

Tek bir kaydın json çıktısına ulaşabildiğimiz gibi, tüm kayıtlara ait bilgileri de ayni sekilde json olarak ulaşabilmekteyiz.
```
curl  -L http://127.0.0.1:2379/v2/keys/
```

```
{"action":"get","node":{"dir":true,"nodes":[{"key":"/POD4","value":"192.168.1.3:88","modifiedIndex":94,"createdIndex":94},{"key":"/POD5","value":"192.168.1.5:8080","modifiedIndex":95,"createdIndex":95},{"key":"/POD6","value":"192.168.1.5:8081","modifiedIndex":100,"createdIndex":100},{"key":"/POD1","value":"192.168.1.2:80","modifiedIndex":91,"createdIndex":91},{"key":"/POD2","value":"192.168.1.2:88","modifiedIndex":92,"createdIndex":92},{"key":"/POD3","value":"192.168.1.3:80","modifiedIndex":93,"createdIndex":93}]}}
```
Mevcut kayıtların tamamını listelemek icin "ls" operatörünü kullanabiliriz:
```
etcdctl ls / --recursive
```
Herhangi bir anahtari silmek icin ise "rm" operatörünü kullanabiliriz:
```
etcdctl rm /POD6 --recursive
```
Bir sonraki bölüme geçmeden önce, tüm kayıtlarımızı listeleyelim.
Gördüğünüz gibi daha önce oluşturmuş olduğumuz **POD7** yaşama zamanını tamamlamış ve aramızdan ayrılmıştır :).

```
etcdctl ls --recursive
```

#### ***etcd*** ile ilgili kısa bilgilendirme eğitimini burada tamamlamış bulunmaktayız. Bir sonraki bölümde küçük bir alistirma yapacagiz.


----------------------------------------------------------------------
## Sayfanın başında gösterilen resimdeki senaryonun anahtar değerlerini oluşturalım.
----------------------------------------------------------------------
Bu bölümde beklenen, etcd'ye 5 adet kayıt girmenizdir.

 **İpucu:**
 ```
 $ etcdctl set POD1 192.168.1.2:80
 ```
 ---
Kayıt işlemlerini tamamladığınızda, **etcdctl ls** komutu ile tüm kayıt anahtarlarını listeleyebilirsiniz.

***Dersin kontrolünü hazirlamis oldugum scripti kullanarak gerçekleştirebilirsiniz.***

Scripti çalıştırmak için:

```
./etcd-kontrol.sh
```

Scriptin kontrolü sonucunda ekranda aşağıdaki gibi kontrol sonucunu listeleyecektir.

![etcdkontrol](https://user-images.githubusercontent.com/66215655/143533976-19df0e6a-4f97-49ff-a5cb-e99aa186ce63.gif)

[ETCD Interaktif Senaryosu](https://www.katacoda.com/techakademi/scenarios/etcd) Linki yeni pencerede açmak için ***ctrl+click*** kullanmalısın.

[Kubernetes Derlser'e geri dön ](https://github.com/techakademi/KubernetesDersler)
