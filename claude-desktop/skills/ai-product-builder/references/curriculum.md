# Kurikulum Detail — AI Product Builder

## Overview

Kurikulum ini dirancang untuk 12 minggu, tapi pace bisa disesuaikan dengan user. Yang penting bukan kecepatan, tapi pemahaman.

Setiap modul punya:
- **Objective**: apa yang user bisa lakukan setelah modul ini
- **Konsep kunci**: istilah-istilah yang harus dipahami
- **Analogi**: cara menjelaskan tanpa jargon
- **Latihan**: hal yang user coba sendiri
- **Visual wajib**: diagram yang HARUS dibuat saat mengajarkan modul ini

---

## FASE 1 — Website & Fondasi Digital

### Modul 1.1 — Cara kerja website

**Objective:** User paham bahwa website terdiri dari 3 layer dan bisa menjelaskan fungsi masing-masing.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| HTML | Kerangka rumah | Struktur dan konten — tulisan, gambar, tombol |
| CSS | Cat dan dekorasi | Tampilan — warna, ukuran, posisi, font |
| JavaScript | Listrik dan instalasi | Interaksi — klik tombol, animasi, hitung data |
| Browser | Mandor yang baca blueprint | Software yang membaca code dan menampilkan hasilnya |
| Server | Gudang penyimpanan | Komputer yang menyimpan file website kamu |

**Visual wajib:** Diagram "rumah website" — kerangka (HTML), cat (CSS), listrik (JS) dalam satu gambar.

**Latihan:**
1. Buka website favorit mereka
2. Tanya: "Menurut kamu, bagian mana yang HTML, mana CSS, mana JavaScript?"
3. Minta AI buatkan halaman sederhana, user identifikasi setiap bagian

**Pertanyaan Socratic:**
- "Kalau kamu hapus semua CSS dari sebuah website, apa yang tersisa?"
- "Kenapa website butuh JavaScript kalau HTML dan CSS sudah cukup untuk tampilan?"

---

### Modul 1.2 — AI sebagai developer kamu

**Objective:** User bisa menulis prompt yang menghasilkan output berkualitas dari AI.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| Prompt | Pesanan ke restoran | Instruksi yang kamu kasih ke AI |
| Context | Cerita di balik pesanan | Info tambahan supaya AI paham situasinya |
| Iterasi | Revisi desain | Minta AI ubah/perbaiki hasil sebelumnya |
| Spesifik | Detail pesanan | Makin detail instruksi, makin akurat hasil |

**Visual wajib:** Perbandingan side-by-side: prompt buruk vs prompt bagus dan hasilnya.

**Framework prompt yang efektif (WSCF):**
1. **W**hat — Apa yang mau dibikin? (landing page, dashboard, form)
2. **S**tyle — Tampilannya gimana? (warna, tone, referensi)
3. **C**ontent — Isinya apa? (text, gambar, data)
4. **F**unction — Bisa ngapain? (klik, submit, hitung)

**Contoh perbandingan:**

Prompt buruk: "Buatin website"
→ Hasil: generic, ga sesuai kebutuhan

Prompt bagus: "Buatkan landing page untuk kursus online 'Belajar Excel untuk Pemula'. Warna utama biru navy dan putih. Ada headline besar, 3 bullet point keunggulan, testimonial dari 2 orang, dan tombol 'Daftar Sekarang' yang mencolok warna kuning. Mobile-friendly."
→ Hasil: spesifik, langsung bisa dipakai

**Latihan:**
1. User tulis prompt untuk website/app impian mereka
2. Review bersama — apa yang kurang?
3. Revisi dan bandingkan hasilnya

---

### Modul 1.3 — Deploy pertamamu

**Objective:** User punya website live yang bisa diakses siapa saja lewat internet.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| Deploy | Pindah rumah dari maket ke tanah asli | Bikin website kamu bisa diakses orang |
| Hosting | Tanah tempat rumah berdiri | Komputer yang menyimpan website 24/7 |
| Domain | Alamat rumah | URL yang orang ketik (misalnya namakamu.com) |
| SSL | Gembok di pintu | Enkripsi supaya data aman (https://) |

**Visual wajib:** Flow dari "file di laptop" ke "website live di internet."

**Platform deploy yang direkomendasikan:**
- Vercel — paling gampang untuk pemula, gratis
- Netlify — alternatif Vercel, sama mudahnya
- GitHub Pages — gratis, tapi perlu sedikit setup

**Latihan:**
1. Ambil website yang sudah dibuat di modul sebelumnya
2. Deploy ke Vercel (step by step dengan guidance)
3. Share link ke teman/keluarga — ini momen "wow" pertama

---

## FASE 2 — Vibe Coding & App Building

### Modul 2.1 — Apa itu vibe coding

**Objective:** User paham konsep vibe coding dan bisa memilih tool yang tepat.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| Vibe coding | Ngobrol sama arsitek | Kamu jelasin maunya, AI yang gambar dan bangun |
| IDE | Meja kerja arsitek | Tempat kamu dan AI kerja bareng |
| Component | Lego block | Bagian kecil yang bisa disusun jadi app besar |
| Framework | Cetakan kue | Template yang mempercepat pembuatan app |

**Visual wajib:** Perbandingan "coding tradisional vs vibe coding" — timeline dan effort.

**Tools landscape:**
| Tool | Cocok untuk | Level |
|------|------------|-------|
| Claude Artifacts | Prototype cepat, widget interaktif | Pemula |
| v0 by Vercel | UI component, landing page | Pemula |
| Bolt.new | Full app dari prompt | Pemula-Menengah |
| Replit | App dengan backend | Menengah |
| Cursor | Full development | Menengah-Advanced |
| Lovable | SaaS product | Menengah |

**Latihan:**
1. Buat komponen sederhana di 2 tools berbeda
2. Bandingkan pengalaman — mana yang lebih cocok?

---

### Modul 2.2 — Database dan data

**Objective:** User paham kapan butuh database dan bisa memilih jenis yang tepat.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| Database | Lemari arsip digital | Tempat simpan data yang terorganisir |
| CRUD | Buat-Baca-Ubah-Hapus | 4 hal dasar yang bisa dilakukan ke data |
| API | Pelayan restoran | Penghubung antara app kamu dan database |
| Schema | Desain laci lemari | Struktur data — kolom apa aja yang ada |

**Visual wajib:** Diagram "kapan butuh database vs kapan cukup spreadsheet."

**Panduan memilih:**
- Google Sheets → Data kecil, <1000 baris, ga perlu real-time
- Supabase → App serius, perlu user login, data relasional
- Firebase → Real-time (chat, live update), mobile app

---

### Modul 2.3 — Bikin app pertama

**Objective:** User punya app fungsional yang menyelesaikan masalah nyata.

Modul ini sangat tergantung pada project user. Tanyakan dulu apa yang mau dibikin, lalu breakdown jadi:

1. **Tampilan** — apa yang user lihat? (halaman apa aja, layout gimana)
2. **Data** — data apa yang disimpan/ditampilkan? (user, produk, transaksi)
3. **Logika** — apa yang terjadi kalau user klik sesuatu? (submit form, hitung total)

**Visual wajib:** Diagram breakdown app user — tampilan, data, logika.

**Approach:**
- Mulai dari tampilan dulu (yang bisa dilihat = motivasi)
- Tambah data (supaya tampilan hidup)
- Tambah logika (supaya app berguna)

---

### Modul 2.4 — Iterasi dan debugging

**Objective:** User bisa mendiagnosa masalah dan meminta AI untuk fix dengan efektif.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| Bug | Kerusakan di rumah | Sesuatu yang ga jalan sesuai harapan |
| Error message | Laporan inspektur | Petunjuk di mana dan apa masalahnya |
| Console | Jendela belakang | Tempat lihat apa yang terjadi di balik layar |
| Debug | Investigasi | Proses cari tahu kenapa ada masalah |

**Visual wajib:** Flow "ketemu error → baca → pahami → fix."

**Framework komunikasi error ke AI (SREF):**
1. **S**ituation — "Saya lagi bikin X"
2. **R**esult — "Yang terjadi adalah Y"
3. **E**xpected — "Harusnya Z"
4. **F**eedback — Lampirkan error message atau screenshot

---

## FASE 3 — Integrasi AI & Product Thinking

### Modul 3.1 — API: cara bicara antar sistem

**Objective:** User paham konsep API dan bisa menginstruksikan AI untuk menghubungkan 2 sistem.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| API | Pelayan restoran | Kamu pesan (request), dia bawakan (response) |
| Endpoint | Menu spesifik | URL tertentu untuk fungsi tertentu |
| Request | Pesanan kamu | Data yang kamu kirim ke API |
| Response | Makanan yang datang | Data yang API kirim balik |
| API Key | Kartu member restoran | Identitas kamu supaya bisa pesan |
| JSON | Bon pesanan terstruktur | Format data yang API pakai untuk komunikasi |

**Visual wajib:** Diagram request-response antara app dan API.

**Contoh API yang bisa langsung dicoba:**
- OpenWeatherMap — ambil data cuaca
- Gemini API — kirim teks, dapat jawaban AI
- Telegram Bot API — kirim pesan otomatis

---

### Modul 3.2 — Menambahkan AI ke product

**Objective:** User bisa menambahkan fitur AI ke product mereka.

**Visual wajib:** Diagram arsitektur "app + AI API."

**Use case berdasarkan kebutuhan:**
| Kebutuhan | Solusi AI | Contoh |
|-----------|-----------|--------|
| Jawab pertanyaan user | Chatbot + KB | Customer support bot |
| Ringkas dokumen panjang | Summarization | Rangkum laporan meeting |
| Generate konten | Text generation | Bikin deskripsi produk |
| Analisa data | Data analysis | Insight dari spreadsheet |
| Klasifikasi | Classification | Sortir email/feedback |

**Cara hitung biaya AI:**
- Token = satuan teks (sekitar 4 karakter = 1 token)
- Input token (yang kamu kirim) + Output token (yang AI jawab) = total biaya
- Gemini Flash = murah, cocok untuk volume besar
- GPT-4 / Claude = lebih mahal, cocok untuk tugas kompleks

---

### Modul 3.3 — Automation dan workflow

**Objective:** User bisa menghubungkan beberapa sistem dan membuat automation.

**Visual wajib:** Diagram automation flow dengan trigger → action → output.

**Konsep kunci:**
| Istilah | Analogi | Penjelasan simpel |
|---------|---------|-------------------|
| Trigger | Bel pintu | Event yang memulai automation |
| Action | Respon terhadap bel | Apa yang terjadi setelah trigger |
| Webhook | Kurir instan | Cara sistem kirim notifikasi ke sistem lain |
| Workflow | SOP digital | Rangkaian langkah otomatis |

**Platform automation:**
- Google Apps Script → Gratis, integrasi Sheets/Docs/Gmail
- Zapier → Mudah, drag-and-drop, 5000+ integrasi
- Make (Integromat) → Lebih fleksibel dari Zapier
- n8n → Self-hosted, gratis, paling fleksibel

---

### Modul 3.4 — Product thinking

**Objective:** User bisa berpikir seperti product builder, bukan cuma coder.

**Visual wajib:** Diagram "idea → MVP → feedback → iterate."

**Framework MVP (Minimum Viable Product):**
1. Tulis 10 fitur yang kamu mau
2. Coret 7 — sisakan 3 yang paling penting
3. Dari 3 itu, mana yang paling cepat dibikin dan paling banyak dampaknya?
4. Bikin itu dulu. Deploy. Ukur. Baru tambah fitur lain.

**Pertanyaan yang harus dijawab sebelum build:**
- Siapa yang akan pakai ini?
- Masalah apa yang diselesaikan?
- Bagaimana cara mengukur sukses?
- Apa alternatif yang sudah ada?

---

## Tracking progress

Setelah menyelesaikan setiap modul, update mental checklist:

**Fase 1 checklist:**
- [ ] Paham HTML/CSS/JS secara konsep
- [ ] Bisa menulis prompt efektif (framework WSCF)
- [ ] Punya website live yang di-deploy sendiri

**Fase 2 checklist:**
- [ ] Familiar dengan minimal 2 vibe coding tools
- [ ] Paham kapan butuh database
- [ ] Punya app fungsional
- [ ] Bisa baca error dan komunikasikan ke AI

**Fase 3 checklist:**
- [ ] Paham konsep API dan bisa instruksikan AI untuk integrasi
- [ ] Punya product dengan fitur AI
- [ ] Punya minimal 1 automation yang berjalan
- [ ] Bisa breakdown ide jadi MVP
