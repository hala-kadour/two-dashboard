import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:two_dashboard/config/constants/base_uri.dart';

Future<Uint8List?> fetchImage(String filename) async {
  final response = await http.post(
    Uri.parse('$baseUri/api/get/image?filename=$filename'),
  );

  if (response.statusCode == 200) {
    return response.bodyBytes;
  }
  return null;
}
