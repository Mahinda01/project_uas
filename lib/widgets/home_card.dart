import 'package:coba_app/model/home_card_model.dart';
import 'package:coba_app/views/anime_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final HomeCardModel homeData; // Data beranda anime
  final int cardIndex; // Indeks kartu, defaultnya 0

  HomeCard({
    required this.homeData, // Parameter wajib data beranda
    this.cardIndex = 0, // Nilai default untuk indeks kartu
  });

  @override
  Widget build(BuildContext context) {
    // tampilan untuk widget
    return InkWell(
      // Widget untuk mendeteksi ketukan
      onTap: () => Navigator.of(context).pushNamed(
        // Aksi navigasi ke layar detail anime
        AnimeDetailScreen.routeName, // Nama route detail anime
        arguments: homeData.malId, // Argumen yang dikirimkan: ID anime
      ),
      child: Column(
        // Kolom untuk tata letak vertikal
        children: [
          Expanded(
            child: ClipRRect(
              // Widget untuk membulatkan sudut gambar
              borderRadius:
                  BorderRadius.circular(10), // Membuat sudut gambar bulat
              child: Hero(
                // Hero widget untuk animasi hero
                tag: homeData.malId, // Tag untuk animasi hero
                child: Image.network(
                  // Gambar dari jaringan
                  homeData.imageUrl, // URL gambar dari data
                  fit: BoxFit.cover, // Menyesuaikan gambar ke kotak
                ),
              ),
            ),
          ),
          Padding(
            // Padding untuk menambahkan jarak
            padding: const EdgeInsets.symmetric(
                horizontal: 15), // Padding horizontal
            child: Row(
              // Baris untuk menampilkan teks judul
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Penataan di antara elemen
              children: [
                Flexible(
                  // Widget untuk menyesuaikan lebar
                  child: Text(
                    // Teks untuk judul anime
                    homeData.title, // Judul anime dari data
                    maxLines: 2, // Batas maksimal 2 baris teks
                    overflow: TextOverflow.ellipsis, // saat teks berlebihan
                    style: TextStyle(
                      // Gaya teks untuk judul
                      fontWeight: FontWeight.w700, // Ketebalan teks
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
