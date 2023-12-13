import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/province_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Pilih Provinsi",
            style: TextStyle(fontSize: 16),
          ),
          DropdownSearch<Province>(
            // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
            asyncItems: (String filter) async {
              Uri url =
                  Uri.parse("https://api.rajaongkir.com/starter/province");
              try {
                final response = await http.get(
                  url,
                  headers: {
                    "key": "5f7da4bea53f821ba98e4e568c6afc92",
                  },
                );

                var data = json.decode(response.body) as Map<String, dynamic>;
                print(data);

                var statusCode = data["rajaongkir"]["status"]["code"];

                if (statusCode != 200) {
                  throw data["rajaongkir"]["status"]["description"];
                }

                var listAllProvince =
                    data["rajaongkir"]["results"] as List<dynamic>;

                var models = Province.fromJsonList(listAllProvince);
                return models;
              } catch (err) {
                print(err);
                return List<Province>.empty();
              }
            },
            onChanged: (Province? value) => print(value?.province),
            itemAsString: (Province? province) => province?.province ?? "",
          ),
        ],
      ),
    );
  }
}
