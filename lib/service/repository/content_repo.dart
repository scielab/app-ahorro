import 'package:app/service/api/api_client.dart';
import 'package:get/get.dart';

class ContentRepo {
  final APIRequestClient apiRequestClient;
  ContentRepo({required this.apiRequestClient});

  Future<dynamic> getContent([int? id]) async {
    return id == null ? await apiRequestClient.fetchData('content/') : await apiRequestClient.fetchData('content/$id');
  }
}