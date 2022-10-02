import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Graphql extends InheritedWidget {
  static late Graphql instance;
  final ValueNotifier<GraphQLClient> client;

  Graphql({required this.client, required Widget child, Key? key})
      : super(child: GraphQLProvider(client: client, child: child), key: key) {
    instance = this;
  }

  static Future<ValueNotifier<GraphQLClient>> init() async {
    final HttpLink httpLink = HttpLink('http://graphql.brushed-charts.com');
    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
  }

  static Graphql? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: Graphql);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
