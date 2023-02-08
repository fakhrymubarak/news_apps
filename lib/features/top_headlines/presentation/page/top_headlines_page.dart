import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_apps/core/utils/view_utils.dart';
import 'package:news_apps/features/home/presentation/widgets/article_widget.dart';
import 'package:news_apps/features/home/presentation/widgets/shimmer_list.dart';
import 'package:news_apps/features/top_headlines/presentation/bloc/top_headlines_bloc.dart';
import 'package:news_apps/injection.dart' as di;
import 'package:news_apps/themes/themes.dart';

class TopHeadlinesPage extends StatelessWidget {
  const TopHeadlinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.injector<TopHeadlinesBloc>(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  _TopHeadlineAppBar(),
                  _ListHeadlinesSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopHeadlineAppBar extends StatelessWidget {
  const _TopHeadlineAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(Assets.icBack),
        ),
        Expanded(
          child: Text(
            Strings.textTopHeadlines,
            style: TextStyles.bold16pt(),
          ),
        ),
      ],
    );
  }
}

class _ListHeadlinesSection extends StatelessWidget {
  const _ListHeadlinesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TopHeadlinesBloc>().add(const TopHeadlineFetch());
    return BlocConsumer<TopHeadlinesBloc, TopHeadlineState>(
      listenWhen: (_, current) => current is TopHeadlineErrorState,
      listener: (context, state) {
        if (state is TopHeadlineErrorState) showSnackBar(context, state.message);
      },
      buildWhen: (_, current) =>
          current is TopHeadlineLoadingState ||
          current is TopHeadlineHasDataState ||
          current is TopHeadlineErrorState,
      builder: (context, state) {
        if (state is TopHeadlineLoadingState) {
          return const ShimmerListWidget(enabled: true);
        } else if (state is TopHeadlineHasDataState) {
          return ListView.builder(
            itemCount: state.articles.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final article = state.articles[index];
              return ArticleWidget(article: article);
            },
          );
        }
        return const Center(child: Text(Strings.textEmptyData));
      },
    );
  }
}
