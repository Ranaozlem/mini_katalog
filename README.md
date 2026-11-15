# Mini Katalog Uygulaması

Flutter ve Dart kullanılarak geliştirilmiş, ürünlerin listelenmesini, incelenmesini ve sepete eklenmesini sağlayan örnek bir mobil katalog uygulamasıdır.

## Kullanılan Teknolojiler
- Flutter 3.50.0
- Dart 3.14.0
- Material Design 3
- JSON veri yapısı

## Uygulama Özellikleri
- JSON dosyasından ürün verilerini okuma
- GridView ile ürünleri listeleme
- Ürün görsellerini görüntüleme
- Ürün arama ve kategori filtreleme
- Ürün detay sayfası
- Navigator ile sayfa geçişleri
- Route Arguments ile veri aktarımı
- Sepete ürün ekleme ve çıkarma
- Sepetteki toplam fiyatı hesaplama
- StatefulWidget ve ValueNotifier ile durum yönetimi

## Projeyi Çalıştırma

1. Flutter SDK'yı bilgisayarınıza kurun.
2. Projeyi bilgisayarınıza indirin.
3. Proje klasöründe terminal açın.
4. Bağımlılıkları yükleyin:

   `flutter pub get`

5. Android emülatörünü başlatın.
6. Uygulamayı çalıştırın:

   `flutter run`

## Proje Klasör Yapısı

- `lib/main.dart` — Ana uygulama ve ürün listesi
- `lib/models/` — Ürün modeli ve sepet yönetimi
- `lib/pages/` — Ürün detay ve sepet sayfaları
- `assets/data/` — JSON ürün verileri
- `assets/images/` — Ürün görselleri

## Açıklama

Bu proje Flutter eğitimi kapsamında hazırlanmıştır. Ürün verileri yerel JSON dosyasından okunmaktadır. Sepet işlemleri eğitim amaçlı simülasyondur; gerçek ödeme altyapısı içermez.