Mutfak
======

## VS Code Yapılandırmaları

Verilen yapılandırma ayarlarını yapılandırmanıza uygulamak için mevcut VS Code yapılandırma dosyasını (`settings.json`) açın

- Menüden "Görünüm → Komut Paletini" seçin

- `Open Settings (JSON)` girin

---

Yapılandırma dosyası açıldığında ekte her dil için verilen yapılandırmalardan birini seçerek kopyala yapıştır yoluyla (kısmen veya tamamen) aktarın

- Yapılandırmalar tüm dosya halinde verilmiştir

- Yapılandırmayı tümüyle kullanmak için eski içeriği silin ve verilen yapılandırmayı (`{}` parantezlerini koruyarak)
  olduğu gibi yapıştırın

- Kısmen kullanmak istiyorsanız sadece ilgili satırları seçerek yapıştırın

- Yapılandırmayı proje özelinde kullanmak istiyorsanız içeriği proje kökünde `.vscode` adında bir dizin oluşturarak
  `.vscode/settings.json` dosyası halinde kaydedin

---

### Ruby

```json
{
  "editor.wordWrapColumn":   120,
  "editor.wordWrap":         "on",
  "terminal.integrated.cwd": "${fileDirname}",
  "ruby.useLanguageServer":  true,
  "ruby.lint":               { "rubocop": true  },
  "[ruby]":                  { "editor.tabSize": 2 }
}
```
