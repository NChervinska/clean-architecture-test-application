import 'package:flutter/material.dart';

import 'cat_fact_app.dart';
import 'core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();

  runApp(const CatFactApp());
}
