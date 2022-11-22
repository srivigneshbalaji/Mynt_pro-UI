import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/constants.dart';
import '../../../model/index_list_model.dart';
import '../../../themes/theme_model.dart';

class MobileAppBar extends StatelessWidget with PreferredSizeWidget {
  final List<IndexListItem> indexLists;
  const MobileAppBar({
    Key? key,
    required this.indexLists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const String find = " ";
    const String rePlace = "\n";
    String symbolName1 = (indexLists[0].symbolName).replaceAll(find, rePlace);
    String symbolName2 = (indexLists[1].symbolName).replaceAll(find, rePlace);
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: .4,
        title: Container(
          padding: themeNotifier.isDark
              ? const EdgeInsets.only(bottom: 12)
              : const EdgeInsets.only(bottom: 0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white10,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => indexShowBottom(context, size, themeNotifier),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbolName1,
                            style: listTitle(size),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${indexLists[0].ltp}",
                                style: ltpUpTextStyle(size),
                              ),
                              Text(
                                "${indexLists[0].change} (${indexLists[0].perChange}%)",
                                style: pcDownTextStyle(size),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    indexShowBottom(context, size, themeNotifier);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbolName2,
                            style: listTitle(size),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${indexLists[1].ltp}",
                                style: ltpDownTextStyle(size),
                              ),
                              Text(
                                "${indexLists[1].change} (${indexLists[1].perChange}%)",
                                style: pcUpTextStyle(size),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<dynamic> indexShowBottom(
      BuildContext context, Size size, ThemeModel themeNotifier) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.64,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stock Index',
                      style: watchListTextStyle(size),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 1,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 68),
                    itemCount: indexLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      const String find = " ";
                      const String rePlace = "\n";
                      var symbolName = (indexLists[index].symbolName)
                          .replaceAll(find, rePlace);
                      return Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 243, 242, 248),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                symbolName,
                                style: themeNotifier.isDark
                                    ? listTitle2(size)
                                    : listTitle(size),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${indexLists[index].ltp}",
                                    style: ltpUpTextStyle(size),
                                  ),
                                  Text(
                                    "${indexLists[index].change} (${indexLists[index].perChange}%)",
                                    style: pcDownTextStyle(size),
                                  )
                                ],
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
