import 'dart:convert';
// import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrroadways/models/bus_route_model.dart';

class RoutesSearchProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<BusRoute> _allRoutes = [];
  List<BusRoute> _searchResult = [];
  List<BusRoute> get searchResult => _searchResult;

  Future<void> searchRoutes(String from, String to) async {
    _isLoading = true;
    _searchResult = [];
    notifyListeners();

    if (_allRoutes.isEmpty) {
      _allRoutes = await loadRoutes();
    }

    // Separate lists for sorting
    List<BusRoute> directRoutes = [];
    List<BusRoute> fromViaRoutes = [];
    List<BusRoute> viaToRoutes = [];

    for (var route in _allRoutes) {
      if (route.from.toLowerCase() == from.toLowerCase() &&
          route.to.toLowerCase() == to.toLowerCase()) {
        // Direct route (From → To)
        directRoutes.add(route);
      } else if (route.from.toLowerCase() == from.toLowerCase() &&
          route.via.toLowerCase() == to.toLowerCase()) {
        // From → Via
        fromViaRoutes.add(route);
      } else if (route.via.toLowerCase() == from.toLowerCase() &&
          route.to.toLowerCase() == to.toLowerCase()) {
        // Via → To
        viaToRoutes.add(route);
      }
    }

    // Merge lists in priority order
    _searchResult = [...directRoutes, ...fromViaRoutes, ...viaToRoutes];

    _isLoading = false;
    notifyListeners();
  }

  Future<List<BusRoute>> loadRoutes() async {
    final String response = await rootBundle.loadString('assets/master.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => BusRoute.fromJson(json)).toList();
  }
}
