---
title:      Programlamaya Giriş
audience:   OMÜ Bilgisayar Mühendisliği Bölümü
numerology: BIL103
---

# Programlamaya Giriş

Bu derste, Bilgisayar Mühendisliği mesleğinin en temel becerisi olan "Programlama"yı giriş seviyesinde öğrenmeniz
hedeflenmektedir.  Bir programlama dilinin öğrenilmesiyle, olağan bir yabancı dilin öğrenilmesi arasında paralellikler
bulunur.  Ancak bol pratik yaparak öğrenilebilecek yeni bir yabancı dilde ilk hedef o dilde aklınızda olanı ifade
edebilme yani "meramı ifade" ("derdini/isteğini anlatma") olduğu gibi programlama dillerinde de durum budur:
karşılaştığınız "hesaplama" probleminin kafanızdaki çözümünü bilgisayara anlatabilmek için bilgisayarın anladığı bir
dilin, bir programlama dilinin kurallarını ve sözcüklerini öğrenmek ve kullanmak.  Yeni bir dili öğrenmek o dilde
ustalaşmak, dili edebi anlamda en doğru ve güzel şekilde kullanmak anlamına gelmediği gibi bu derste de hedefimiz
seçilen dilde her yönüyle ustalaşmak olmayacak.  Ama ders boyunca ustalaşmanın ipuçlarına da yeri geldikçe değineceğiz.

"Programlamaya Giriş"i somut olarak [Ruby](https://www.ruby-lang.org/tr/) programlama dili özelinde yapacağız. Github,
Shopify, Basecamp, (ilk günleri itibarıyla) Twitter gibi büyük firmalarda yaygın şekilde kullanılan tam nesne yönelimli,
Japon orijinli bu dil günümüzde "start-up" dediğimiz genç girişim firmaları tarafından kısa sürede bir fikri hayata
geçirmek amacıyla yaygın şekilde tercih edilmektedir.

### İzlence

Derste 2021-2022 eğitim/öğretim yarıyılı itibarıyla çeşitli revizyonlar planlandığından ders izlencesi (Syllabus) zaman
içinde netleşecektir.  Bu sayfaları düzenli olarak kontrol etmeyi unutmayın.

### Kaynaklar

Derslerde rijit olarak izleyeceğimiz bir kaynak kitap bulunmuyor.  Var olan kaynakların da büyük bir bölümü İngilizce.
Aşağıdaki kaynak listesi ders dışında ilave bir pekiştirici kaynak beklentisini karşılamak üzere verilmiştir.

- The Well-Grounded Rubyist; David A. Black, Joseph Leo III; 2019

- The Ruby Programming Language: Everything You Need to Know; David Flanagan, Yukihiro Matsumoto; 2008 (eski bir kaynak)

- Practical Object-Oriented Design: An Agile Primer Using Ruby; Sandi Metz; 2018 (ileri seviye bir kaynak)

- [Standart Ruby Kitaplığı](https://ruby-doc.org/)

### İşleyiş

- Dersle ilgili tüm duyurular (bu sayfa değil) Google Classroom üzerinden yapılacaktır.

- Çevrimiçi dersler, bağlantısına Google Classroom sayfası üzerinden erişebileceğiniz, Google Meet ile
  gerçekleştirilecektir. Dersin etkileşimini artırmak için çevrimiçi ders süresince çekinmeden soru sorabilirsiniz.

- Derste sunulan içeriğin büyük bir bölümü: çevrimiçi ders kayıtları, slaytlar, derste verilen örnekler bu sayfalarda
  "MATERYAL" başlığı altında listelenecektir.

- Dersin teorik saatlerinde Bölüm Bilgisayar laboratuvarları açık halde tutulacaktır.  Çevrimiçi derse bir nedenle
  erişim olanağı olmayan öğrenciler dersi Laboratuvarda takip edebilir.

- Dersin uygulama saatlerinde Bölüm Bilgisayar laboratuvarları açık halde tutulacaktır.  Ödevler başta olmak üzere
  takıldığınız hususlarda asistan hocalarınızdan yüz yüze yardım alabilirsiniz.

- Programlama sadece ve sadece bizzat programlama yapmakla öğrenilen bir beceridir.  Bu nedenle size çeşitli aralıklarla
  ödevler verilerek somut programlama yapmanız beklenecektir.  Ödevlerin başarı notunuza katkısı büyüktür.  Kesin katkı
  oranı Google Classroom duyurularında daha sonra ilan edilecektir.

- Ders kapsamında [Ruby](https://www.ruby-lang.org/tr/) programlama dili yorumlayıcısını ve bir programlama editörü
  olarak tercihen [Visual Studio Code](https://code.visualstudio.com/) programını kişisel bilgisayarınıza kurmanız
  beklenmektedir.  Kişisel bilgisayarınız yoksa veya bilgisayarınız yeterli kaynaklara sahip değilse Bilgisayar
  Laboratuvarı olanaklarından yararlanabilirsiniz (bu konuda zorluk yaşayan arkadaşlar lütfen özelden benimle temasa
  geçsinler).

- Ödevler başta olmak üzere çalışmalarınızı [Github'ta hesap açarak](https://github.com/signup) gerçekleştirmeniz
  beklenmektedir.  Önceki maddeyle ilişkili olarak, dileyenler ders süresince Github'ın sunduğu [Github
  Codespace](https://github.com/features/codespaces) sanal ortamında çalışmalarını yürütebilir.  (Bu konular derste
  şifahen anlatılacak ve daha sonra bu sayfalarda "MATERYAL" bölümünde dokümante edilecektir.)

- Derste düzenli yoklama alınmayacaktır.  (Fakat derse katılım sağlamayan öğrencilerin sayısının arttığı gözlenirse bu
  karar değişebilir.)

- Dönem içi ve dönem sınavına ilave olarak bazı derslerde önceden duyuru yapılmadan kısa sınavlar gerçekleştirilebilir.

### Kurallar

1. Dersle ilgili tüm duyuruların yapıldığı Google Classroom sayfalarını (bu sayfa değil) düzenli takip etmekle ve size
   iletilen talepleri yerine getirmekle sorumlusunuz.

2. Uygulama saatlerinde Bölüm Bilgisayar laboratuvarlarında geçirdiğiniz süre başta olmak üzere ders saatlerinde sadece
   dersle ilgilenmelisiniz.   Bilgisayar laboratuvarında size ayrılan bilgisayarı uygulama süresince sadece ders için
   kullanın.  Laboratuvardan ayrılırken masanızı düzenleyin ve geride **asla** çöp bırakmayın.

3. Derste anlatılan konularla ilgili sorularınızı ders saatleri dışında özelden yazmak veya konuşmak yerine lütfen dersin
   [Soru-Cevap forumunda](https://github.com/roktas/classroom/discussions/categories/programlamaya-giri%C5%9F-om%C3%BC-bilgisayar-m%C3%BChendisli%C4%9Fi-b%C3%B6l%C3%BCm%C3%BC)
   yazılı olarak sorun.  Bu sayede verilen cevaplardan herkes yararlanabilecektir.

4. Derste zaten açık şekilde değinilmiş konular hakkında lütfen iletişim kurmayın.  Derste sunulan içeriğe ait
   materyalleri bu sitede bulabilirsiniz (derslerin büyük bir çoğunluğunun çevrimiçi kaydı da zaten sunulmaktadır).
   İletişime girmeden önce bu materyalleri dikkatli şekilde inceleyin, gerekirse arkadaşlarınıza sorun.

5. Yukarıda değinilen konular dışında dersin işleyişiyle alakalı **teknik olmayan soruları** özelden asistan hocalarınıza
   veya bana eposta yoluyla iletebilirsiniz.  Fakat lütfen "not pazarlığı" anlamına gelen diplomatik yazışmalar yapmayın.
   Bu tür iletilere geri dönüş yapılmayacaktır.

6. Gerek dersin işleyişinde gerekse ödevlerde bazı bulut servislerinde (ör. Github) hesap açmanız ve kullandığınız
   bilgisayarda çeşitli kurulumlar ve ayarlar yapmanız beklenmektedir.  Bu koşulları ivedi şekilde sağlamadan derse
   devam etmeye çalışmayın.

7. Zamanında teslim edilmeyen veya sizden istenen biçimin dışında teslim edilen ödevler değerlendirmeye alınmayacaktır.
   Lütfen bu konuda herhangi bir talepte bulunmayın.

8. Ders süresince verilen ödevlerde öncelikle dikkate alınan husus sizin öğrenme konusunda çaba gösterip
   göstermediğinizdir.  Ödevde hata veya eksiklikler olsa bile aslolan sizin kişisel çabanızdır ve bu çaba mutlaka
   dikkate alınacaktır.  Herhangi bir çaba sarfetmeden Genel ağdan (İnternet) veya bir başka arkadaşınızdan kopyalama
   yoluyla yapılan ödevler değerlendirmeye alınmayacağı gibi bu kişilere eksi ödev puanı vermekle başlamak üzere
   hocalarınız tarafından takdir edilen müeyyideler uygulanacaktır.
