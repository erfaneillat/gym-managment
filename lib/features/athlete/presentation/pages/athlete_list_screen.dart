import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/loading_widget.dart';
import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';
import 'package:manage_gym/features/athlete/domain/usecases/get_athletes_use_case.dart';
import 'package:manage_gym/features/athlete/presentation/widgets/athlete_item.dart';
import 'package:manage_gym/params/input_params.dart';

import '../../../../locator.dart';
import '../../domain/entities/athlete_list_search_entity.dart';
import '../widgets/search_bar.dart';

final athleteListKey = GlobalKey<_ListState>();

class AthleteListScreen extends StatelessWidget {
  const AthleteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationFlow.toAddAthlete();
          },
          backgroundColor: context.colorScheme.primary,
          child: Icon(
            Icons.add,
            color: context.colorScheme.onPrimary,
          )),
      body: SafeArea(
          child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    floating: true,
                    leadingWidth: 0,
                    toolbarHeight: 80,
                    leading: const SizedBox(),
                    snap: true,
                    title: SearchBar(
                      onSearch: (val) {
                        athleteListKey.currentState!
                            .updateFilter(AthleteListSearchEntity(name: val));
                      },
                    ),
                  ),
                ];
              },
              body: _List(
                key: athleteListKey,
              ))),
    );
  }
}

class _List extends StatefulWidget {
  const _List({
    super.key,
  });

  @override
  State<_List> createState() => _ListState();
}

late PagingController<int, ShortAthleteDataEntity> _pagingController;

class _ListState extends State<_List> {
  void refresh() {
    _pagingController.refresh();
  }

  void updateFilter(AthleteListSearchEntity newFilter) async {
    filter = newFilter;
    await Future.delayed(const Duration(milliseconds: 300));
    _pagingController.refresh();
  }

  bool isFetching = false;
  AthleteListSearchEntity filter = AthleteListSearchEntity();
  Future<void> _fetchPage(int pageKey) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final either = await sl<GetAthletesUseCase>()(
        AthleteListInputParams(key: pageKey, searchParameters: filter));
    either.fold((l) => _pagingController.error == l.message, (r) {
      final isLastPage = r.data.length < r.pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(r.data);
      } else {
        _pagingController.appendPage(r.data, r.page + 1);
      }
    });
  }

  @override
  void initState() {
    _pagingController = sl();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: PagedListView<int, ShortAthleteDataEntity>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ShortAthleteDataEntity>(
            noItemsFoundIndicatorBuilder: (val) => Center(
                  child: Text(
                    'not_found'.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                ),
            firstPageProgressIndicatorBuilder: (val) =>
                const Center(child: LoadingWidget()),
            newPageProgressIndicatorBuilder: (val) =>
                const Center(child: LoadingWidget()),
            firstPageErrorIndicatorBuilder: (val) => Center(
                  child: Text(
                    'unexpected_failure_message'.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                ),
            itemBuilder: (context, item, index) => AthleteItem(
                  onTap: () {
                    NavigationFlow.toAthleteInfo(item.id);
                  },
                  athlete: item,
                ).animate().fadeIn(
                    duration: Duration(milliseconds: index * 50),
                    delay: Duration(milliseconds: index * 50))),
      ),
    );
  }
}
