import 'package:flutter/material.dart';

import 'features/fact_trivia/presentation/pages/fact_trivia_page.dart';

class CatFactApp extends StatelessWidget {
  const CatFactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FactTriviaPage.create(),
    );
  }
}
