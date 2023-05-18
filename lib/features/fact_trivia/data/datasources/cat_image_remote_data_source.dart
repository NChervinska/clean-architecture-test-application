import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../models/cat_image_model.dart';
import 'remote_constants.dart';

abstract class CatImageRemoteDataSource {
  Future<CatImageModel> getCatImage();
}

class CatImageRemoteDataSourceImpl implements CatImageRemoteDataSource {
  final Client client;

  CatImageRemoteDataSourceImpl(this.client);

  @override
  Future<CatImageModel> getCatImage() async {
    final response = await client.get(
      Uri.parse(RemoteConstants.catImageUri),
      headers: RemoteConstants.headers,
    );
    if (response.statusCode != 200) throw ServerException();

    final List listCat = json.decode(response.body);
    if (listCat.isEmpty) throw ServerException();

    return CatImageModel.fromJson(listCat.first);
  }
}
