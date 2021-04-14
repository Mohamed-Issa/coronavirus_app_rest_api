import 'package:coronavirus_rest_api/app/repositories/endpoins_data.dart';
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
    /* try {
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
    }*/
    return await _getDataRefreshingToken<int>(
        onGetData: () => apiServices.getEndPointData(_accessToken, endpoint));
  }

  Future<EndPointsData> getAllEndPointData() async =>
      await _getDataRefreshingToken<EndPointsData>(
        onGetData: _getAllEndPointData,
      );

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiServices.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiServices.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndPointsData> _getAllEndPointData() async {
    //   final cases = await apiServices.getEndPointData(_accessToken, Endpoint.cases);

    final values = await Future.wait([
      apiServices.getEndPointData(_accessToken, Endpoint.cases),
      apiServices.getEndPointData(_accessToken, Endpoint.casesSuspected),
      apiServices.getEndPointData(_accessToken, Endpoint.casesConfirmed),
      apiServices.getEndPointData(_accessToken, Endpoint.deaths),
      apiServices.getEndPointData(_accessToken, Endpoint.recovered),
    ]);
    return EndPointsData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.casesConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
