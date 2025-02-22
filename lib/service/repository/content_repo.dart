import 'package:app/service/api/api_client.dart';
import 'package:app/utils/app_resources.dart';
import 'package:get/get.dart';



class ContentRepo {
  final APIRequestClient apiRequestClient;
  
  ContentRepo({required this.apiRequestClient});
  
  Future<dynamic> getSingleContent([int? id]) async {
    try {
      if (id == null) throw Exception("Required id argument");
      var response = await apiRequestClient.fetchData('content/$id');
      return response;
    } catch (e) {
      logger.e(e);
    }
  }
  Future<dynamic> getAllContent([String? difficulty]) async {
    try {
      if(difficulty == null) throw Exception("Required difficulty argument");
      var response =  await apiRequestClient.fetchData('content_difficulty/$difficulty');
      return response;
    } catch (e) {
      logger.e(e);
    }
  }
}