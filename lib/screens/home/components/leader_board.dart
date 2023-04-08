import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/winner_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/has_won.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/components/section_title.dart';
import 'package:shop_ecommerce/screens/no_data_found/no_data_found.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;

      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 5,
          _scrollController1);
    });
    super.initState();
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         FirestoreQueryBuilder<MinimumProduct>(
              query: minimumProductQueryWinnerList(true),
              builder: (context, snapshot, _) {
                return Column(children: [
                  if (snapshot.docs.length > 0)
                    ...List.generate(snapshot.docs.length, (index) {
                      MinimumProduct product = snapshot.docs[index].data();
                      String id = snapshot.docs[index].reference.id;

                      return FirestoreQueryBuilder<UserModel>(
                          query: globalUserMinimalInfo(product.winnerUid!),
                          builder: (context, snapshot2, _) {
                            if (snapshot2.isFetching || snapshot2.hasError) {
                              Simmer();
                            }
                          if (snapshot.docs.length == 0) {
                            return NoDataFound();
                          }
                            if (snapshot2.hasData) {
                              int i;
                              for (i = 0; i < snapshot2.docs.length; i++)
                                HasWon().addItem(
                                    snapshot2.docs[i].data().firstName!);
                            }
                            return WinnerCard( 
                                user: snapshot2, product: product, id: id);
                          });
                    })
                ]);
              }),
         
      ],
    );
  }
}
