import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/attraction_model.dart';

abstract class RemoteDataSource {
  Future<List<AttractionModel>> fetchAttractions();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<AttractionModel>> fetchAttractions() async {
    final response = await client.get(
      Uri.parse('https://www.travel.taipei/open-api/en/Attractions/All?categoryIds=12%2C34%2C124&page=1'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.map((item) => AttractionModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }
}
