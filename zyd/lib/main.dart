import 'package:flutter/material.dart';
import 'package:zyd/router/router.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: RouterConfig.initRouteName,
    onGenerateRoute: RouterConfig.onGenerateRoute,
  )
);

