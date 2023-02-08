part of 'home_page.dart';

class _HomeHeadlinesSection extends StatelessWidget {
  const _HomeHeadlinesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      _TitleHeadlineSection(),
      _ListHeadlinesSection(),
    ]);
  }
}

class _TitleHeadlineSection extends StatelessWidget {
  const _TitleHeadlineSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            key : Keys.txtTopHeadlines,
            Strings.textTopHeadlines,
            style: TextStyles.bold16pt(),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.headlines),
          icon: SvgPicture.asset(Assets.icMore),
        )
      ],
    );
  }
}

class _ListHeadlinesSection extends StatelessWidget {
  const _ListHeadlinesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const HomeFetchHeadlines());
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (_, current) => current is HomeErrorState,
      listener: (context, state) {
        if (state is HomeErrorState) showSnackBar(context, state.message);
      },
      buildWhen: (_, current) =>
          current is HomeLoadingHeadlinesState ||
          current is HomeHeadlineHasDataState ||
          current is HomeErrorState,
      builder: (context, state) {
        if (state is HomeLoadingHeadlinesState) {
          return const ShimmerListWidget(enabled: true);
        } else if (state is HomeHeadlineHasDataState) {
          return ListView.builder(
            key: Keys.listHeadlines,
            itemCount: state.articles.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final article = state.articles[index];
              return ArticleWidget(article: article);
            },
          );
        }
        return const Center(key: Keys.articleWidget, child: Text(Strings.textEmptyData));
      },
    );
  }
}
