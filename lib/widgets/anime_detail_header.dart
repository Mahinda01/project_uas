import 'package:coba_app/model/anime_model.dart';
import 'package:flutter/material.dart';

class AnimeDetailsHeader extends StatelessWidget {
  late final AnimeModel animeData; // Data anime yang akan ditampilkan
  AnimeDetailsHeader(
      {required this.animeData}); 

  @override
  Widget build(BuildContext context) {
    // tampilan untuk widget
    return Row(
      // Baris untuk menyusun elemen header
      children: [
        Expanded(
          child: Container(
            // Kontainer untuk header
            child: Column(
              // Kolom untuk tata letak vertikal
              mainAxisAlignment: MainAxisAlignment
                  .spaceAround, // Penataan utama pada sumbu vertikal
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Penataan lintas sumbu dari kiri ke kanan
              children: [
                Text(
                  // Teks untuk judul anime
                  animeData.title, // Judul anime dari data
                  style: TextStyle(
                    // Gaya teks untuk judul
                    fontSize: 24, // Ukuran teks
                    fontWeight: FontWeight.w700, // Ketebalan teks
                  ),
                ),
                SizedBox(height: 2.5), // Jarak antar elemen
                Text(
                  // Teks untuk judul anime dalam bahasa Inggris
                  animeData
                      .titleEnglish, // Judul dalam bahasa Inggris dari data
                  style: TextStyle(
                    // Gaya teks untuk judul dalam bahasa Inggris
                    fontSize: 15, // Ukuran teks
                    color: Colors.grey[600], // Warna teks abu-abu
                    fontWeight: FontWeight.w600, // Ketebalan teks
                  ),
                ),
                SizedBox(height: 1), // Jarak antar elemen
                Text(
                  // Teks untuk tanggal tayang anime
                  animeData.airingDate, // Tanggal tayang dari data
                  style: TextStyle(
                    // Gaya teks untuk tanggal tayang
                    fontSize: 15, // Ukuran teks
                    fontWeight: FontWeight.w700, // Ketebalan teks
                  ),
                ),
                SizedBox(height: 1), // Jarak antar elemen
                Text(
                  // Teks untuk rating anime
                  animeData.rating, // Rating dari data
                  style: TextStyle(
                    // Gaya teks untuk rating
                    fontSize: 14, // Ukuran teks
                    fontWeight: FontWeight.w700, // Ketebalan teks
                  ),
                ),
                SizedBox(height: 1), // Jarak antar elemen
                Text(
                  // Teks untuk jumlah episode anime
                  animeData.episodes <=
                          0 // Memeriksa apakah jumlah episode tidak tersedia
                      ? 'Ongoing' // Teks jika anime sedang berlangsung
                      : animeData.episodes.toString() +
                          ' Episodes', // Jumlah episode jika tersedia
                  style: TextStyle(
                    // Gaya teks untuk jumlah episode
                    fontSize: 14, // Ukuran teks
                    fontWeight: FontWeight.w700, // Ketebalan teks
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          // Kolom untuk menampilkan elemen vertikal
          children: [
            Stack(
              // Stack untuk menumpuk elemen
              alignment: Alignment.center, // Posisi tengah dalam stack
              children: [
                Text(
                  // Teks untuk skor anime
                  '${animeData.score}', // Skor dari data
                  style: TextStyle(
                    // Gaya teks untuk skor
                    fontWeight: FontWeight.w900, // Ketebalan teks
                  ),
                ),
                SizedBox(
                  // Widget kotak untuk lingkaran progres
                  height: 50, // Tinggi kotak
                  width: 50, // Lebar kotak
                  child: CircularProgressIndicator(
                    // Indikator lingkaran progres
                    color: Colors.blue, // Warna lingkaran progres biru
                    backgroundColor: Colors.grey.withOpacity(
                        .35), // Warna latar belakang lingkaran progres
                    strokeWidth: 6.0, // Lebar garis lingkaran progres
                    value: animeData.score /
                        10, // Nilai progres lingkaran dari skor anime
                  ),
                ),
              ],
            ),
            Padding(
              // Padding untuk menambahkan jarak atas
              padding: const EdgeInsets.only(
                  top: 10), // Padding hanya di bagian atas
              child: Text(
                // Teks untuk peringkat anime
                animeData.rank != 0 // Memeriksa apakah peringkat tersedia
                    ? 'Ranked\n #${animeData.rank}' // Teks jika peringkat tersedia
                    : 'Ranked\n N/A', // Teks jika peringkat tidak tersedia
                textAlign: TextAlign.center, // Penataan teks ke tengah
                style: TextStyle(
                  // Gaya teks untuk peringkat
                  fontWeight: FontWeight.w700, // Ketebalan teks
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
