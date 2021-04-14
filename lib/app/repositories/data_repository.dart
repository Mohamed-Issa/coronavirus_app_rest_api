import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIServices apiServices;

  String _accessToken;

  // ignore: invalid_required_positional_param
  DataRepository({@required this.apiServices});

  Future<int> getEndPointData(Endpoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiServices.getAccessToken();
      }
      return await apiServices.getEndPointData(_accessToken, endpoint);
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiServices.getAccessToken();
        return await apiServices.getEndPointData(_accessToken, endpoint);
      }
      rethrow;
    }
  }
}
