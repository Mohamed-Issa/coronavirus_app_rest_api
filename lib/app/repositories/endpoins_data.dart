import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndPointsData {
  final Map<Endpoint, EndPointData> values;

  EndPointsData({@required this.values});

  EndPointData get cases => values[Endpoint.cases];
  EndPointData get casesSuspected => values[Endpoint.casesSuspected];
  EndPointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndPointData get deaths => values[Endpoint.deaths];
  EndPointData get recovered => values[Endpoint.recovered];

  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
