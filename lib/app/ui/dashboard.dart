import 'package:coronavirus_rest_api/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api/app/repositories/endpoins_data.dart';
import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndPointsData _endPointsData;

  @override
  void initState() {
    super.initState();
    // _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endPointData = await dataRepository.getAllEndPointData();
    setState(() {
      _endPointsData = endPointData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            for (var endpoint in Endpoint.values)
              EndPointCard(
                endpoint: endpoint,
                value: _endPointsData != null
                    ? _endPointsData.values[endpoint]
                    : null,
              )
          ],
        ),
      ),
    );
  }
}
