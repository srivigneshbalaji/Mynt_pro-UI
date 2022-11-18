import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constants.dart';
import '../../../../constant/model/models.dart';
import '../../../../themes/theme_model.dart';

class EditWatchList extends StatefulWidget {
  final List<WatchListModel> watchlists;

  const EditWatchList({super.key, required this.watchlists});

  @override
  State<EditWatchList> createState() => _EditWatchListState();
  static const String routeName = 'editWatchlist';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => EditWatchList(
        watchlists: WatchListModel.watchlistDatas,
      ),
    );
  }
}

class _EditWatchListState extends State<EditWatchList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: .4,
          title: Text(
            "Edit Watchlist",
            style: watchListTextStyle(size),
          ),
        ),
        body: ReorderableListView.builder(
          shrinkWrap: true,
          // reverse: true,
          onReorder: (int oldIndex, int newIndex) {},
          itemCount: widget.watchlists.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              key: ValueKey(widget.watchlists[index]),
              leading: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                ),
                onPressed: () {},
              ),
              title: Text(
                widget.watchlists[index].symbolName,
                style: listTitle(size),
              ),
              trailing: const Icon(
                Icons.drag_handle,
              ),
            );
          },
        ),
      );
    });
  }
}
