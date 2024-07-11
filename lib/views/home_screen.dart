import 'package:coba_app/views/anime_gred_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba_app/controllers/data_provider.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() =>
      _HomeScreenState(); // Membuat state untuk HomeScreen
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index terpilih pada bottom navigation bar
  bool isSiWibuVisible =
      true; // State untuk menentukan apakah nama 'Si Wibu' ditampilkan

  final List<CategoryType> _categories = [
    // Daftar kategori untuk top dan movie
    CategoryType.top,
    CategoryType.movie,
  ];

  Future<void> getData(CategoryType category) async {
    // Fungsi untuk mengambil data berdasarkan kategori
    await Provider.of<DataProvider>(context, listen: false).getHomeData(
        category: category); // Memanggil provider untuk mengambil data
  }

  void searchData(String query) {
    // Fungsi untuk melakukan pencarian
    Provider.of<DataProvider>(context, listen: false)
        .searchData(query); // Memanggil provider untuk melakukan pencarian
  }

  void _onItemTapped(int index) {
    // Callback saat item pada bottom navigation bar dipilih
    setState(() {
      _selectedIndex = index; // Mengubah index terpilih
      getData(_categories[
          index]); // Memanggil fungsi getData berdasarkan index kategori yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    // tampilan HomeScreen
    return Scaffold(
      body: FloatingSearchAppBar(
        // FloatingSearchAppBar sebagai app bar dengan fitur pencarian
        colorOnScroll: Colors.blue, // Warna app bar saat discroll
        liftOnScrollElevation: 0, // Elevation saat discroll
        elevation: 0, // Elevation app bar
        hideKeyboardOnDownScroll:
            true, // Menyembunyikan keyboard saat discroll ke bawah
        title: Container(), // Kontainer kosong untuk judul app bar
        hint: 'Search anime or manga', // Hint untuk field pencarian
        iconColor: Colors.blue, // Warna ikon pencarian
        autocorrect: false, // Tidak melakukan koreksi otomatis
        onFocusChanged: (isFocused) {
          // Callback saat focus pada pencarian berubah
          if (!isFocused) {
            // Jika tidak dalam fokus
            setState(() {
              getData(_categories[
                  _selectedIndex]); // Memanggil getData berdasarkan kategori terpilih
            });
          }
        },
        leadingActions: [
          // bagian kiri app bar
          Visibility(
            // Menampilkan atau menyembunyikan 'Si Wibu' tergantung pada kondisi isSiWibuVisible
            visible: isSiWibuVisible,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  IconButton(
                    // Tombol ikon untuk 'Si Wibu'
                    icon: Icon(
                      Icons.dashboard,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    splashRadius: 25,
                    onPressed: () {
                      setState(() {
                        _selectedIndex =
                            0; // Mengubah index terpilih menjadi 0 (top)
                        getData(CategoryType
                            .top); // Memanggil getData untuk kategori top
                      });
                    },
                  ),
                  Text(
                    // Teks 'Si Wibu'
                    'Si Wibu',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        onSubmitted: (query) {
          // Callback saat pencarian disubmit
          setState(() {
            searchData(query); // Memanggil fungsi pencarian
          });
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  AnimeGridPage(), // Halaman AnimeGridPage sebagai konten utama
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Bottom navigation bar
        items: <BottomNavigationBarItem>[
          // Item-item pada bottom navigation bar
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ikon untuk kategori top
            label: 'Top', // Label untuk kategori top
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie), // Ikon untuk kategori movie
            label: 'Movies', // Label untuk kategori movie
          ),
        ],
        currentIndex:
            _selectedIndex, // Index terpilih pada bottom navigation bar
        selectedItemColor: Colors.white, // Warna item terpilih
        unselectedItemColor: const Color.fromARGB(
            255, 55, 115, 164), // Warna untuk item belum dipilih
        onTap:
            _onItemTapped, // Callback saat item pada bottom navigation bar dipilih
      ),
    );
  }
}
