import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/ticket_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/product_model.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/components/section_title.dart';
import 'package:shop_ecommerce/screens/no_data_found/no_data_found.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    return FirestoreQueryBuilder<MinimumProduct>(
        query: featuredMinimumProductQuery(true, true),
        builder: (context, snapshot, _) {
           if (snapshot.docs.length == 0) {
            return NoDataFound();
          }
          if(snapshot.isFetching){
            return Padding(
              padding: paddingMarginTLR15,
              
              child: Simmer(
                
                height:  getProportionateScreenHeight(160),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                SectionTitle(text: "Premium Slots", press: () {}),
                ...List.generate(snapshot.docs.length, (index) {
                  MinimumProduct product = snapshot.docs[index].data();
                  String id = snapshot.docs[index].reference.id;
                  
                  //  if (productController.products[index].isPopular) {
                  return product.reservedSlots!.length!= product.totalSlots ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                       type: PageTransitionType.fade,
                                duration: defaultDuration350,
                          reverseDuration: Duration(milliseconds: 250),
                          child: DetailsScreen(id: id, )));
                    },
                    child: TicketCard( totalSlots:  product.totalSlots! ,soldOutSlots: product.tempReservedSlots!.length+
                                product.reservedSlots!.length,
                      mainTitle:
                          "${product.reservedSlots!.length+ product.tempReservedSlots!.length > product.totalSlots! * 7 / 10 ? "Hurry!" : "Giveaway"}",
                      subTitle: product.productName!,
                      remainingSlots: _service.ticketsLeft(
                          product.reservedSlots!.length, product.totalSlots!),
                      
                      imageURL: product.imageURLs![0],
                      slotPrice: product.slotPrice!,
                    ),
                  ):SizedBox();
                })
              ],
            ),
          );
        });
  }
}
