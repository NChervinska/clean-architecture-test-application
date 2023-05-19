import 'package:flutter/material.dart';

import 'cat_fact_app.dart';
import 'core/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();

  runApp(const CatFactApp());
}
