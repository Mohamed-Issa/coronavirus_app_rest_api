import 'dart:convert';

import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIServices {
  final API api;

  APIServices({@required this.api});

  Future<String> getAccessToken() async {
    final response = await http.post(api.tokenUri(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      print(data['access_token']);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed\n Response: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndPointData> getEndPointData(
    // ignore: invalid_required_positional_param
    @required String accessToken,
    // ignore: invalid_required_positional_param
    @required Endpoint endpoint,
  ) async {
    final url = api.endPointUrl(endpoint);
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endPointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int value = endPointData[responseJsonKey];
        final String dateString = endPointData['date'];
        final date = DateTime.tryParse(dateString);
        return EndPointData(value: value, date: date);
      }
    }
    print(
        'Request $url failed\n Response: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesConfirmed: 'data',
    Endpoint.casesSuspected: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}
