import 'dart:convert';

import 'package:cubit_example/core/model/cats_model.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<Cats>> getCatsFromApi();
}

class SampleCatsRepository implements CatsRepository {
  final baseUrl = Uri.parse('https://hwasampleapi.firebaseio.com/http.json');

  @override
  Future<List<Cats>> getCatsFromApi() async {
    final response = await http.get(baseUrl);
    return (jsonDecode(response.body) as List).map((e) => Cats.fromJson(e)).toList();
  }
}
