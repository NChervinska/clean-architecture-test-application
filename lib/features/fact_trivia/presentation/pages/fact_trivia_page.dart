import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../bloc/cat_image_cubit.dart';
import '../bloc/fact_trivia_cubit.dart';
import '../fact_trivia_strings.dart';
import '../widgets/image_view.dart';
import '../widgets/widgets.dart';

class FactTriviaPage extends StatelessWidget {
  static Widget create() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FactTriviaCubit>(
          create: (_) => locator.get<FactTriviaCubit>(),
        ),
        BlocProvider<CatImageCubit>(
          create: (_) => locator.get<CatImageCubit>(),
        ),
      ],
      child: const FactTriviaPage._(),
    );
  }

  const FactTriviaPage._();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FactTriviaStrings.catFact),
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(child: _buildFactState()),
          const SizedBox(height: 12),
          Expanded(child: _buildCatState()),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<FactTriviaCubit>().getTriviaFact();
              context.read<CatImageCubit>().getCatImage();
            },
            child: const Text(FactTriviaStrings.getRandomFact),
          ),
        ],
      ),
    );
  }

  Widget _buildFactState() {
    return BlocBuilder<FactTriviaCubit, FactTriviaState>(
      builder: (context, state) {
        if (state is FactTriviaError) {
          return MessageDisplay(message: state.errorMessage);
        }
        if (state is FactTriviaLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FactTriviaLoaded) {
          return MessageDisplay(message: state.trivia.fact);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCatState() {
    return BlocBuilder<CatImageCubit, CatImageState>(
      builder: (context, state) {
        if (state is CatImageLoaded) return ImageView(url: state.image.url);

        return const SizedBox.shrink();
      },
    );
  }
}
