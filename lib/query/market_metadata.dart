import 'package:flutter/material.dart';

class MarketMetadata {
  final String broker;
  final String assetPairs;
  final int intervalInSeconds;
  final DateTimeRange dateRange;
  MarketMetadata(
      this.broker, this.assetPairs, this.intervalInSeconds, this.dateRange);
}
