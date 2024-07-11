import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:coba_app/model/anime_model.dart';
import 'package:coba_app/model/home_card_model.dart';

// Inisialisasi var enum CategoryType
enum CategoryType { top, movie }

// set api url nya
const api_url = 'https://api.jikan.moe/v4/anime';
const top_url = 'https://api.jikan.moe/v4/anime?status=airing';
const movie_url = 'https://api.jikan.moe/v4/anime?status=airing&type=movie';

class DataProvider with ChangeNotifier {
  bool isLoading = false; // proses load data atau tidak
  bool isError = false; // proses terjadi error atau tidak
  String errorMessage = ''; // Pesan error yang ditampilkan
  List<HomeCardModel> searchList = []; // Menyimpan hasil pencarian
  late int genreId; // ID genre
  late AnimeModel animeData = AnimeModel(); // Data model

  // Mengambil data home (default kategori 'top')
  Future<void> getHomeData({CategoryType category = CategoryType.top}) async {
    final String url;

    // Menentukan URL berdasarkan kategori
    if (category == CategoryType.top) {
      url = top_url;
    } else if (category == CategoryType.movie) {
      url = movie_url;
    } else {
      return; // Jika kategori tidak valid, hentikan proses
    }

    try {
      isLoading = true; // proses load data
      isError = false; // tidak ada error
      var dio = Dio(); // inisiasi dio
      var response = await dio.get(url); // Mengirim permintaan GET ke URL
      List<HomeCardModel> tempData =
          []; // List sementara untuk menyimpan hasil parsing
      List items = response.data['data']; // Mendapatkan data dari respons JSON
      tempData = items
          .map((data) => HomeCardModel.fromJson(data))
          .toList(); // Mapping data ke model HomeCardModel
      searchList = tempData; // Menyimpan hasil pencarian ke searchList
      isLoading = false; // proses load data selesai
      notifyListeners(); // Memberitahu listener bahwa data telah berubah
    } on DioError catch (e) {
      handleError(e); // Mengelola error pada Dio
    } catch (e) {
      print(e); // Menangani kesalahan umum
    }
  }

  // Mencari data berdasarkan query
  Future<void> searchData(String query) async {
    final String url = Uri.encodeFull(api_url +
        '?q=$query&page=1&limit=12'); // Membuat URL pencarian dengan query
    try {
      isLoading = true; // proses load data
      isError = false; // tidak ada error
      var dio = Dio(); // inisiasi dio
      var response = await dio.get(url); // Mengirim permintaan GET ke URL
      List<HomeCardModel> tempData =
          []; // List sementara untuk menyimpan hasil parsing
      List items = response.data['data']; // Mendapatkan data dari respons JSON
      tempData = items
          .map((data) => HomeCardModel.fromJson(data))
          .toList(); // Mapping data ke model HomeCardModel
      searchList = tempData; // Menyimpan hasil pencarian ke searchList
      isLoading = false; // proses load data selesai
      notifyListeners(); // Memberitahu listener bahwa data telah berubah
    } on DioError catch (e) {
      handleError(e);
    } catch (e) {
      print(e);
    }
  }

  // Mendapatkan data anime berdasarkan ID
  Future<void> getAnimeData(int malId) async {
    final String url =
        'https://api.jikan.moe/v4/anime/$malId'; // URL untuk mendapatkan data anime berdasarkan ID
    try {
      isLoading = true; // proses load data
      isError = false; // tidak ada error
      var dio = Dio(); // inisiasi dio
      var response = await dio.get(url); // Mengirim permintaan GET ke URL
      animeData = AnimeModel.fromJson(
          response.data['data']); // Parsing data JSON ke model AnimeModel
      isLoading = false; // proses load data selesai
      notifyListeners(); // Memberitahu listener bahwa data telah berubah
    } on DioError catch (e) {
      handleError(e);
    } catch (e) {
      print(e);
    }
  }

  // Mengelola jenis-jenis error yg bisa terjadi
  void handleError(DioError e) {
    if (e.type == DioErrorType.badResponse) {
      errorMessage =
          'Terjadi kesalahan. Silakan coba lagi.'; // Kesalahan jika respons tidak valid
    } else if (e.type == DioErrorType.connectionTimeout) {
      errorMessage =
          'Koneksi Anda telah terputus'; // Kesalahan jika koneksi time out
    } else if (e.type == DioErrorType.receiveTimeout) {
      errorMessage =
          'Tidak dapat terhubung ke server'; // Kesalahan jika tidak dapat terhubung ke server
    } else {
      errorMessage = 'Silakan periksa koneksi Anda'; // Kesalahan umum lainnya
    }
    isError = true; // ada error
    isLoading = false; // proses load data selesai
    notifyListeners(); // Memberitahu listener bahwa data telah berubah
  }
}
