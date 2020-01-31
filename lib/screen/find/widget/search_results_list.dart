import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/diff/diff_applier.dart';
import 'package:meteo/common/diff/list_controller.dart';
import 'package:meteo/common/diff/myers_diff.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/screen/find/bloc/find_bloc.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';

class SearchResultList extends StatefulWidget {
  @override
  _SearchResultListState createState() => _SearchResultListState();

  Widget itemRemovedBuilder(
    Weather item,
    int index,
    BuildContext context,
    Animation<double> animation,
  ) {
    return FadeTransition(
      opacity: animation,
      child: _buildItem(item),
    );
  }

  Widget itemBuilder(
    Weather item,
    int index,
    BuildContext context,
    Animation<double> animation,
  ) {
    return FadeTransition(
      opacity: animation,
      child: _buildItem(item, context),
    );
  }

  Widget _buildItem(Weather weather, [BuildContext context]) {
    return ListTile(
      key: ValueKey<Weather>(weather),
      title: Text(weather.city.name),
      subtitle: Text(weather.city.voivodeship),
      onTap: () => (null == context)
          ? null
          : BlocProvider.of<FindBloc>(context).add(SelectWeather(weather)),
    );
  }
}

class _SearchResultListState extends State<SearchResultList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final DiffUtil<Weather> _diffUtil = DiffUtil<Weather>();

  ListController<Weather> _listController;
  DiffApplier<Weather> _diffApplier;

  @override
  void initState() {
    super.initState();
    _listController = ListController(
      key: _listKey,
      items: [],
      itemRemovedBuilder: widget.itemRemovedBuilder,
      duration: Duration(milliseconds: 200),
    );
    _diffApplier = DiffApplier(_listController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindBloc, FindState>(
      listener: (BuildContext context, FindState state) async {
        final SuggestionsState queryState = (state is FindComplete)
            ? state.suggestionsState
            : SuggestionsLoaded();

        if (queryState is SuggestionsLoaded) {
          final newItems = queryState.suggestedWeathers;
          final diff = await _diffUtil.calculateDiff(
            _listController.items,
            newItems,
          );
          _diffApplier.applyDiffs(diff);
        }
      },
      child: AnimatedList(
        key: _listKey,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          return widget.itemBuilder(
            _listController[index],
            index,
            context,
            animation,
          );
        },
      ),
    );
  }
}
