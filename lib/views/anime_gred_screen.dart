import 'package:auto_animated/auto_animated.dart';
import 'package:coba_app/controllers/data_provider.dart';
import 'package:coba_app/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'error_screen.dart';

class AnimeGridPage extends StatefulWidget {
  @override
  _AnimeGridPageState createState() => _AnimeGridPageState();
}

class _AnimeGridPageState extends State<AnimeGridPage> {
  @override
  void initState() {
    super.initState();
    getData(); // Panggil fungsi getData
  }

  Future<void> getData() async {
    await Provider.of<DataProvider>(context, listen: false)
        .getHomeData(); // Ambil data home dari provider
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final screenHeight = device.size.height; // Tinggi layar perangkat
    final screenWidth = device.size.width; // Lebar layar perangkat

    final homeData =
        Provider.of<DataProvider>(context); // Ambil data home dari provider

    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang putih
      body: Container(
        height: screenHeight, // Set tinggi kontainer sama dengan tinggi layar
        width: screenWidth, // Set lebar kontainer sama dengan lebar layar
        child: homeData.isError
            ? ErrorScreen(homeData
                .errorMessage) // Tampilkan layar error jika terjadi kesalahan
            : homeData.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue, // Warna loading biru
                      strokeWidth: 5, // Lebar garis loading
                    ),
                  )
                : RefreshIndicator(
                    onRefresh:
                        getData, // Fungsi refresh saat layar ditarik ke bawah
                    color: Colors.blue, // Warna refresh biru
                    strokeWidth: 2.5, // Lebar garis refresh
                    child: LiveGrid.options(
                      padding: EdgeInsets.all(15).copyWith(
                          left: 20, right: 20), // Padding untuk LiveGrid
                      options: LiveOptions(
                        showItemInterval: Duration(
                            milliseconds: 100), // Interval tampilan item
                      ),
                      itemCount:
                          homeData.searchList.length, // Jumlah item dalam grid
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Jumlah item dalam satu baris
                        childAspectRatio: 1.5 / 2.5, // Rasio aspek item grid
                        crossAxisSpacing:
                            15, // Jarak antar item secara horizontal
                        mainAxisSpacing: 15, // Jarak antar item secara vertikal
                      ),
                      itemBuilder: (context, index, animation) =>
                          FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation), // Animasi opacity item
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, -0.1),
                            end: Offset.zero,
                          ).animate(animation), // Animasi slide item
                          child: HomeCard(
                            homeData: homeData
                                .searchList[index], // Tampilkan kartu anime
                            cardIndex: index, // Index kartu anime
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
