import 'dart:convert';

import 'package:flutter/services.dart';

class GQLMockPrice {
  final assetJsonPath = 'mock/oanda.json';
  GQLMockPrice();

  Future<dynamic> fetch() async {
    final assetContent = await rootBundle.loadString(assetJsonPath);
    final mockJsonData =
        await Future.delayed(const Duration(milliseconds: 500), () {
      return json.decode(assetContent);
    });

    return mockJsonData;
  }
}
