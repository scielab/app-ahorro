

import 'package:app/service/api/api_client.dart';
import 'package:get/get.dart';

class GuildRepo {
  final APIRequestClient apiRequestClient;
  GuildRepo({required this.apiRequestClient});

  Future<dynamic> getGuild([int? id]) async {
    if (id == null) {
      return await apiRequestClient.fetchData('courses/');
    } else {
      return await apiRequestClient.fetchData('courses/$id/');
    }  
  }
}