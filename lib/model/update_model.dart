import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateFood(
    int id, String image, String name, String price, String cookingtime, String rate) async {
  final response = await http.post(
    Uri.parse('http://192.168.229.30/api_penjualan/update.php'),
    body: {
      'id': id.toString(),
      'image': image,
      'nama': name,
      'price': price,
      'cookingtime': cookingtime,
      'rate': rate,
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['message'] == 'updated!') {
      print('Food updated successfully');
    } else {
      throw Exception('Failed to update food');
    }
  } else {
    throw Exception('Failed to update food');
  }
}
