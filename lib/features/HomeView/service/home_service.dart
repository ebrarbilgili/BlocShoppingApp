import 'dart:io';

import 'package:dio/dio.dart';

import '../model/home_model.dart';

class HomeService {
  final Dio service;

  HomeService({required this.service});

  Future<List<HomeModel>> getHomeModel() async {
    final response = await service.get('/users');

    if (response.statusCode == HttpStatus.ok) {
      final data = response.data;

      if (data is List) {
        return data.map((e) => HomeModel.fromJson(e)).toList();
      }
    }

    return [];
  }
}
