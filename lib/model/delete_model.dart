import 'package:http/http.dart' as http;
import 'dart:convert';

// URL endpoint API
const String apiUrl = 'http://192.168.229.30/api_penjualan/delete.php';

// Fungsi untuk menghapus dokter
Future<void> deleteFood(int id) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'id': id.toString(),
    },
  );

  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    if (responseBody['message'] == 'deleted!') {
      print('Food deleted successfully');
    } else {
      throw Exception('Failed to delete food');
    }
  } else {
    throw Exception('Failed to connect to the API');
  }
}
