import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'modelo.dart';

Future<List<Post>> listarPost(http.Client client, String id) async {
  //final response =
  //    await client.get('https://desarolloweb2021a.000webhostapp.com/API/listarnotas.php');
  //var id = "2";
  final response = await http.post(
      Uri.parse(
          'https://desarolloweb2021a.000webhostapp.com/API/listarnotas.php'),
      body: {
        "idestudiante": id,
      });

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Post> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Post>((json) => Post.fromJson(json)).toList();
}
