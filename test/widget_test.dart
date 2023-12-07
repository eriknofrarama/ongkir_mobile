import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://reqres.in/api/users/5");
  final response = await http.get(url);

  final data = (json.decode(response.body) as Map<String, dynamic>)["data"]
      as Map<String, dynamic>;

  print(data["first_name"] + " " + data["last_name"]);
}
