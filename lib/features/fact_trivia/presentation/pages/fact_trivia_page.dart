import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection_container.dart';
import '../bloc/cat_image_bloc.dart';
import '../bloc/fact_trivia_bloc.dart';
import '../widgets/image_view.dart';
import '../widgets/widgets.dart';

class FactTriviaPage extends StatelessWidget {
  static Widget create() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FactTriviaBloc>(
          create: (context) {
            return locator.get<FactTriviaBloc>()..add(GetTriviaFactEvent());
          },
        ),
        BlocProvider<CatImageBloc>(
          create: (context) {
            return locator.get<CatImageBloc>()..add(GetCatImageEvent());
          },
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
        title: const Text('Cat Fact'),
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
              BlocProvider.of<FactTriviaBloc>(context)
                  .add(GetTriviaFactEvent());
              BlocProvider.of<CatImageBloc>(context).add(GetCatImageEvent());
            },
            child: const Text('Get random fact'),
          ),
        ],
      ),
    );
  }

  Widget _buildFactState() {
    return BlocBuilder<FactTriviaBloc, FactTriviaState>(
      builder: (context, state) {
        if (state is FactTriviaError) {
          return MessageDisplay(message: state.errorMessage);
        }
        if (state is FactTriviaLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
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
    return BlocBuilder<CatImageBloc, CatImageState>(
      builder: (context, state) {
        if (state is CatImageLoaded) return ImageView(url: state.image.url);

        return const SizedBox.shrink();
      },
    );
  }
}
