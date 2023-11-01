import 'dart:convert';

import 'package:apollo/object/graph.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockProvider with ChangeNotifier {
  String _currentStock = 'HII';
  Map<String, dynamic> data = <String, dynamic>{};
  String get currentStock => _currentStock;
  List<GraphData> chartData = [];
  List<GraphData> predictedDataUp = [];
  List<GraphData> predictedDataMid = [];
  List<GraphData> predictedDataLow = [];

  StockProvider() {
    getJson(_currentStock).then((value) {
      if (value != null) {
        data = value;
        List<dynamic> arr = data["price"];
        double tmp = arr.first["Close"] ?? 0;
        chartData = loadSalesData(arr);
        predictedDataUp = loadPredictedData(tmp, tmp + 10);
        predictedDataMid = loadPredictedData(tmp, tmp);
        predictedDataLow = loadPredictedData(tmp, tmp - 10);
        notifyListeners();
      }
    });
  }

  void setCurrentStock(String stock) {
    _currentStock = stock;
    getJson(stock).then((value) {
      if (value != null) {
        data = value;
        List<dynamic> arr = data["price"];
        double tmp = arr.first["Close"] ?? 0;
        chartData = loadSalesData(arr);
        predictedDataUp = loadPredictedData(tmp, tmp + 10);
        predictedDataMid = loadPredictedData(tmp, tmp);
        predictedDataLow = loadPredictedData(tmp, tmp - 10);
      }
      notifyListeners();
    });
  }

  Future<Map<String, dynamic>?> getJson(String stockID) async {
    final url = Uri.parse("http://3.1.30.54:8080/all?code=$stockID");
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode != 200) {
      return null;
    }
    return json.decode(response.body);
  }

  List<GraphData> loadSalesData(List<dynamic> arr) {
    List<GraphData> res = [];
    DateTime current = DateTime.now();

    for (int i = 0; i < arr.length; i++) {
      GraphData t =
          GraphData(current.subtract(Duration(hours: i)), arr[i]["Close"] ?? 0);
      res.add(t);
    }

    return res;
  }

  List<GraphData> loadPredictedData(double start, double end) {
    List<GraphData> res = [];
    res.add(GraphData(DateTime.now().add(const Duration(hours: 9)), end));
    res.add(GraphData(DateTime.now(), start));

    return res;
  }
}
