import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../models/cat_image_model.dart';
import 'remote_constants.dart';

abstract class CatImageRemoteDataSource {
  Future<List<CatImageModel>> getCatImage();
}

class CatImageRemoteDataSourceImpl implements CatImageRemoteDataSource {
  final Client client;

  CatImageRemoteDataSourceImpl(this.client);

  @override
  Future<List<CatImageModel>> getCatImage() async {
    final response = await client.get(
      Uri.parse(RemoteConstants.catImageUri),
      headers: RemoteConstants.headers,
    );
    if (response.statusCode != 200) throw ServerException();

    final List listImage = json.decode(response.body);

    return listImage.map((item) => CatImageModel.fromJson(item)).toList();
  }
}
