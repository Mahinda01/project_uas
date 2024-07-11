import 'package:coba_app/model/anime_model.dart';
import 'package:flutter/material.dart';

class AnimeDetailsGenres extends StatelessWidget {
  late final AnimeModel animeData; // Data anime yang akan ditampilkan
  AnimeDetailsGenres(
      {required this.animeData}); 

  Widget moveLabel(String text, dynamic pokeData) {
    // Widget untuk membuat label genre
    return Container(
      decoration: BoxDecoration(
        // Dekorasi kontainer label
        color: Colors.blue, // Warna latar belakang biru
        borderRadius:
            BorderRadius.circular(15), // Border radius untuk sudut melengkung
      ),
      child: Center(
        // Tengah-tengah kontainer
        child: Text(
          // Teks label
          text, // Teks dari genre
          style: TextStyle(
            // Gaya teks untuk label
            fontWeight: FontWeight.w600, // Ketebalan teks
            color: Colors.white, // Warna teks putih
            shadows: <Shadow>[
              // Efek bayangan teks
              Shadow(
                // Bayangan dengan offset dan blur radius
                offset: Offset(2, 2), // Offset bayangan
                blurRadius: 7, // Radius blur bayangan
                color: Colors.grey, // Warna bayangan abu-abu
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // tampilan untuk widget
    final List genreList =
        animeData.genres; // Mendapatkan daftar genre dari data anime
    return GridView.count(
      // Grid view untuk menampilkan genre
      shrinkWrap: true, // Menyesuaikan ukuran secara otomatis
      padding: EdgeInsets.zero, // Padding nol untuk tepi grid
      crossAxisCount: 3, // Jumlah kolom dalam grid
      mainAxisSpacing: 4, // Spasi utama antar elemen
      childAspectRatio:
          6 / 1.5, // Rasio aspek antara lebar dan tinggi setiap elemen
      crossAxisSpacing: 4, // Spasi antar kolom
      children: genreList
          .map((item) => moveLabel(item, animeData))
          .toList(), // Membuat label untuk setiap genre
    );
  }
}
