import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/product_card.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/screens/home/components/section_title.dart';
import 'package:shop_ecommerce/screens/see_all_screen/see_all_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({
    Key? key, this.needGrid,
  }) : super(key: key);
  final bool? needGrid;

   
  @override
  Widget build(BuildContext context) {  ScrollController _scrollController = ScrollController();

    double _crossAxisSpacing = 1,
        _mainAxisSpacing = 12,
        _aspectRatio = 5 / 7,
    _aspectRatio2 = 5 / 7.4 ;
    int _crossAxisCount = 2;
    return FirestoreQueryBuilder<MinimumProduct>(
        query: minimumProductQuery(true),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return Padding(
              padding:   paddingMarginTLR15,
              child: Simmer(
                height: getProportionateScreenHeight(230),
              ),
            );
          }
           

          return needGrid==true?
          Row(
             children:[ 
              SizedBox(width: getProportionateScreenHeight(10),),
              Expanded(
               child: GridView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.docs.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: _crossAxisCount,
                          crossAxisSpacing: _crossAxisSpacing,
                          mainAxisSpacing: _mainAxisSpacing,
                          childAspectRatio: _aspectRatio2,
                          ),
                          itemBuilder: (context, index) {
                            MinimumProduct product = snapshot.docs[index].data();
                            String id = snapshot.docs[index].reference.id;
                            //  if (productController.products[index].isPopular) {
                            return ProductCard(
                              product: product,
                              id: id,
                            );
                          }),
             ),]
          ):
           Column(
            children: [
               SectionTitle(
                text: "Live Slots",
                press: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.theme,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      child: SeeAllScreen()));
                },
                needSeeMore: true,
              ),
              SizedBox(height: getProportionateScreenWidth(4)),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    ...List.generate(
                      snapshot.docs.length,
                      (index) {
                        MinimumProduct product = snapshot.docs[index].data();
                        String id = snapshot.docs[index].reference.id;
                        //  if (productController.products[index].isPopular) {
                        return product == null
                            ? Expanded(child: Simmer())
                            : ProductCard(
                                product: product,
                                id: id,
                              );
                        //  }
                        // return SizedBox
                        //     .shrink(); // here by default width and height is 0
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
