import 'package:coba_app/model/anime_model.dart';
import 'package:coba_app/controllers/data_provider.dart';
import 'package:coba_app/widgets/anime_detail_genre.dart';
import 'package:coba_app/widgets/anime_detail_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeDetailScreen extends StatefulWidget {
  static const routeName =
      '/animedetailscreen'; // Nama rutenya buat navigasi ke halaman detail anime.

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  var _isInit = true; // Var inisialisasi widget

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      late int animeId = ModalRoute.of(context)!.settings.arguments
          as int; // Ambil argumen animeId dari rute navigasi
      Provider.of<DataProvider>(context, listen: false).getAnimeData(
          animeId); // Panggil fungsi buat ambil data anime berdasarkan animeId
    }
    _isInit = false; // Setelah inisialisasi, set jadi false
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(
        context); // Ambil DataProvider dari controllers
    final AnimeModel animeData =
        dataProvider.animeData; // Ambil data anime dari DataProvider
    final device =
        MediaQuery.of(context); // Dapetin info perangkat yang lagi dipake
    final screenWidth = device.size.width; // Dapetin lebar layar perangkat

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Latar belakang appbar transparan
        iconTheme: IconThemeData(
          color: Colors.white, // Ikon appbar warna putih
        ),
      ),
      extendBodyBehindAppBar:
          true, // Latar belakang appbar menyebar sampe ke body
      backgroundColor: Colors.blue, // Latar belakang utama halaman warna biru

      body: !dataProvider.isLoading
          ? Container(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: screenWidth /
                        1.3, // Tinggi kontainer gambar anime di latar belakang
                    width:
                        screenWidth, // Lebar kontainer gambar anime di latar belakang
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode
                              .multiply), // Efek warna pada gambar latar belakang
                      child: Hero(
                        tag: animeData
                            .malId, // Tag hero buat animasi widget hero
                        child: Image.network(
                          animeData
                              .imageUrl, // URL gambar anime dari model AnimeModel
                          fit: BoxFit
                              .cover, // Gambar menutupi seluruh area kontainer
                        ),
                      ),
                    ),
                    color: Colors
                        .blue, // Warna latar belakang kontainer gambar anime
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                        top: screenWidth /
                            1.5), // Padding untuk konten di atas gambar anime
                    clipBehavior: Clip.none,
                    child: Container(
                      width:
                          screenWidth, // Lebar kontainer untuk konten detail anime
                      decoration: BoxDecoration(
                        color: Colors
                            .white, // Warna latar belakang kontainer detail anime
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              25), // Sudut melengkung kiri atas kontainer detail
                          topRight: Radius.circular(
                              25), // Sudut melengkung kanan atas kontainer detail
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25)
                                .copyWith(
                                    top:
                                        25), // Padding untuk judul dan header detail anime
                            child: AnimeDetailsHeader(
                              animeData:
                                  animeData, // Tampilin header detail anime
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25)
                                .copyWith(
                                    top: 25), // Padding untuk sinopsis anime
                            child: Text(
                              animeData.synopsis, // Tampilin sinopsis anime
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 16, // Ukuran teks sinopsis
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 15), // Padding untuk genre anime
                            child: AnimeDetailsGenres(
                                animeData:
                                    animeData), // Tampilin genre-genre anime
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
              color: Colors.white, // Warna loading putih
              strokeWidth: 5, // Lebar garis loading
            )),
    );
  }
}
