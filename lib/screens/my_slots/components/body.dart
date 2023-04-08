import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/2product_card.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/footer.dart';
 import 'package:shop_ecommerce/screens/home/components/leader_board.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/winner_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/slot_selection/components/selection_box.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       child: Column( 
        children: [
          SizedBox(
            height: getProportionateScreenHeight(85),
          ),
          FirestoreQueryBuilder<UserPurchasedSlotsModel>(
              query: getUserPurchasedSlotsData(),
              builder: (context, snapshot, _) {
                if (snapshot.isFetching) {
                  return Padding(
                    padding: paddingMarginAll15,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        Simmer(
                          height: getProportionateScreenHeight(250),
                        ),
                      ],
                    ),
                  );
                }
                if (snapshot.docs.isEmpty) {
                  return   Center(
                     
                      child:  Column(
                        children: [ SizedBox(height: getProportionateScreenHeight(90),),
                          Text( "You have not booked\nany slots yet.",style: text16LightGrayFw400,textAlign: TextAlign.center,  ),
                      
                      ],
                      ),
                       
                     
                  );
                }
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                }

                return Column(
                  children: [
                    Padding(
                      padding: paddingMarginAll15,
                      child: Column(
                        children: [
                          ...List.generate(
                            snapshot.docs.length,
                            (index) {
                              UserPurchasedSlotsModel userPurchased =
                                  snapshot.docs[index].data();
                              String id = snapshot.docs[index].reference.id;
                              //  if (productController.products[index].isPopular) {
                              return userPurchased == null
                                  ? Expanded(child: Simmer())
                                  : FirestoreQueryBuilder<MinimumProduct>(
                                      query: muchMinimumProductQuery(true, id),
                                      builder: (context, snapshot, _) {
                                        if (snapshot.isFetching) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Simmer(
                                              height:
                                                  getProportionateScreenHeight(
                                                      200),
                                            ),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Something went wrong! ${snapshot.error}');
                                        }
                                        MinimumProduct product =
                                            snapshot.docs[0].data();

                                        return Column(
                                          children: [
                                            ...List.generate(
                                                snapshot.docs.length, (index) {
                                              MinimumProduct product =
                                                  snapshot.docs[index].data();

                                              return ProductCard2(
                                                  user: userPurchased,
                                                  product: product,
                                                  id: id);
                                            })
                                          ],
                                        );
                                      });
                              //  }
                              // return SizedBox
                              //     .shrink(); // here by default width and height is 0
                            },
                          ),
                        ],
                      ),
                    ),
                    Footer(height: 140)
                  ],
                );
              }),
        ],
      ),
    );
  }
}
