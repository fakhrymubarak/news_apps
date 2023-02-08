import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_apps/core/utils/view_utils.dart';
import 'package:news_apps/features/home/presentation/widgets/article_widget.dart';
import 'package:news_apps/features/home/presentation/widgets/shimmer_list.dart';
import 'package:news_apps/features/top_headlines/presentation/bloc/top_headlines_bloc.dart';
import 'package:news_apps/injection.dart' as di;
import 'package:news_apps/themes/themes.dart';
import 'package:provider/provider.dart';

class TopHeadlinesPage extends StatelessWidget {
  const TopHeadlinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => di.injector<TopHeadlinesBloc>(),
      builder:(context, _) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              const _TopHeadlineAppBar(),
              Expanded(
                child : NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollEnd) {
                    final metrics = scrollEnd.metrics;
                    if (metrics.atEdge) {
                      bool isTop = metrics.pixels == 0;
                      if (!isTop) {
                        context.read<TopHeadlinesBloc>().add(const TopHeadlineFetchNextPage());
                      }
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: const [
                          _ListHeadlinesSection(),
                          _ShimmerLoadingHeadlines(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
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
    return BlocConsumer<TopHeadlinesBloc, TopHeadlinesState>(
      listenWhen: (_, current) => current is TopHeadlineErrorState,
      listener: (context, state) {
        if (state is TopHeadlineErrorState) {
          showSnackBar(context, state.message);
        }
      },
      buildWhen: (_, current) =>
          current is TopHeadlineHasDataState ||
          current is TopHeadlineErrorState,
      builder: (context, state) {
        if (state is TopHeadlineHasDataState) {
          return ListView.builder(
            itemCount: state.articles.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final article = state.articles[index];
              return ArticleWidget(article: article);
            },
          );
        } else if (state is TopHeadlineInitialState) {
          return const SizedBox.shrink();
        }
        return const Center(child: Text(Strings.textEmptyData));
      },
    );
  }
}

class _ShimmerLoadingHeadlines extends StatelessWidget {
  const _ShimmerLoadingHeadlines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopHeadlinesBloc, TopHeadlinesState>(
      builder: (context, state) {
        if (state is TopHeadlineLoadingState) {
          return const ShimmerListWidget(enabled: true);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
