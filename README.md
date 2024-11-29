# Aplikasi Counter Flutter

---

Proyek ini adalah aplikasi Counter yang dibuat menggunakan _framework_ Flutter yang menunjukkan bagaimana mengelola state secara **lokal** dan **global**, serta implementasi fitur-fitur UI yang canggih. Aplikasi ini mendukung beberapa counter, masing-masing dengan properti unik dan fungsi interaktif, sehingga cocok untuk mempelajari manajemen state dan pembuatan UI yang interaktif.

---

## **Approach**

### **Manajemen State Lokal**
- Membuat fitur **increment** dan **decrement** menggunakan StatefulWidget untuk satu counter.
- Menambahkan validasi agar nilai counter tidak bisa kurang dari nol.

### **Manajemen State Global**
- Membuat kelas `GlobalState` untuk mengelola daftar counter dan properti terkait secara global.
- Menggunakan **Provider** untuk menyebarkan state dan perubahan ke seluruh aplikasi.
- Implementasi fitur:
  - **Menambah counter baru.**
  - **Menghapus counter yang ada.**
  - **Memisahkan state untuk setiap counter dalam daftar global.**

### **UI dan Interaktivitas Lanjutan**
- Memperkaya UI dengan fitur-fitur berikut:
  - **Warna Unik:** Setiap counter memiliki warna latar belakang yang berbeda.
  - **Ganti Warna:** Menambahkan dialog untuk mengubah warna counter.
  - **Animasi:** Menambahkan transisi halus menggunakan `AnimatedContainer`.
  - **Drag-and-Drop:** Memungkinkan pengguna mengatur ulang urutan counter dengan `ReorderableListView`.

---

## **Tantangan yang Dihadapi**
1. **Manajemen State saat Drag-and-Drop:**
   - Memastikan daftar counter dan properti seperti warna tetap sinkron saat diatur ulang.
   - Diselesaikan dengan memperbarui kedua daftar (`counters` dan `colors`) secara bersamaan.

2. **Kesalahan pada Widget Key:**
   - Error karena `Key` yang hilang pada `CounterItem`.
   - Diperbaiki dengan menambahkan parameter `key` pada konstruktor dan menggunakan `ValueKey` di daftar.

3. **Sinkronisasi Properti Counter:**
   - Mencegah inkonsistensi indeks dengan memastikan pembaruan state global selalu selaras.

4. **Interaktivitas Lanjutan:**
   - Membuat fitur pemilih warna (color picker) yang intuitif dalam dialog.
   - Menggunakan `Wrap` dan `GestureDetector` untuk antarmuka pemilihan warna.

---

## **Fitur yang Diimplementasikan**

### **Fitur Dasar**
- Increment dan decrement pada nilai counter.
- Validasi agar nilai counter tidak bisa negatif.

### **Manajemen State Global**
- Mengelola daftar counter dan warna global dengan menggunakan `Provider`.
- Menambah dan menghapus counter secara dinamis.

### **Fitur Lanjutan**
1. **Warna Unik per Counter:**
   - Warna default untuk setiap counter dipilih dari palet `Colors.primaries`.

   **Potongan Kode:**
   ```dart
   _colors.add(Colors.primaries[_counters.length % Colors.primaries.length]);
   ```

2. **Kustomisasi Warna:**
   - Pengguna dapat mengubah warna setiap counter melalui dialog pengaturan.

   **Potongan Kode Dialog:**
   ```dart
   void _showSettingsDialog(BuildContext context, int index) {
     Color selectedColor = globalState.colors[index];
     showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Text('Edit Counter'),
           content: Wrap(
             children: Colors.primaries.map((color) {
               return GestureDetector(
                 onTap: () => selectedColor = color,
                 child: Container(width: 30, height: 30, color: color),
               );
             }).toList(),
           ),
           actions: [
             TextButton(
               onPressed: () {
                 globalState.changeColor(index, selectedColor);
                 Navigator.of(context).pop();
               },
               child: Text('Save'),
             ),
           ],
         );
       },
     );
   }
   ```

3. **Animasi Halus:**
   - Menggunakan `AnimatedContainer` untuk transisi saat nilai counter berubah.

   **Potongan Kode:**
   ```dart
   AnimatedContainer(
     duration: Duration(milliseconds: 300),
     color: globalState.colors[index],
   );
   ```

4. **Drag-and-Drop:**
   - Menggunakan `ReorderableListView` untuk memungkinkan pengguna mengatur ulang counter.

   **Potongan Kode:**
   ```dart
   ReorderableListView(
     onReorder: (oldIndex, newIndex) {
       if (newIndex > oldIndex) newIndex--;
       final item = globalState.counters.removeAt(oldIndex);
       final color = globalState.colors.removeAt(oldIndex);
       globalState.counters.insert(newIndex, item);
       globalState.colors.insert(newIndex, color);
       globalState.notifyListeners();
     },
     children: List.generate(
       globalState.counters.length,
       (index) => CounterItem(key: ValueKey(index), index: index),
     ),
   );
   ```
---

## **Cara Menjalankan**
1. Clone repositori ini.
2. Jalankan `flutter pub get` untuk mengambil semua dependensi.
3. Jalankan aplikasi dengan perintah `flutter run`.

---

## **Dependensi**
- `flutter`
- `provider` untuk manajemen state global.
