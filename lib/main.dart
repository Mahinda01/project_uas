import 'package:coba_app/controllers/data_provider.dart';
import 'package:coba_app/views/anime_detail_screen.dart';
import 'package:coba_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'komik_app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            // Tema app bar
            elevation: 0,
          ),
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.blue,
          ),
        ),
        home: HomeScreen(),
        routes: {
          // Daftar rute aplikasi
          AnimeDetailScreen.routeName: (context) =>
              AnimeDetailScreen(), // Rute untuk layar detail anime
        },
      ),
    );
  }
}
