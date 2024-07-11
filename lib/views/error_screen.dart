import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba_app/controllers/data_provider.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMessage;
  ErrorScreen(this.errorMessage); // Constructor untuk menerima pesan kesalahan

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  Future<void> getData(CategoryType category) async {
    await Provider.of<DataProvider>(context, listen: false).getHomeData(
        category:
            category); // Fungsi untuk mengambil data kategori home dari provider
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.black,
            size: 100,
          ), // Icon error.
          SizedBox(height: 10),
          Text(
            'Terjadi Kesalahan', // Teks informasi kesalahan
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              widget.errorMessage, // Tampilkan pesan kesalahan
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              shadowColor: Colors.blue,
            ),
            child: Text('Return Home'), // Tombol kembali ke halaman utama
            onPressed: () {
              getData(CategoryType
                  .top); // Panggil fungsi getData dengan kategori top
            },
          ),
        ],
      ),
    );
  }
}
