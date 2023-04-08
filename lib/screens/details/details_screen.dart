import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/product_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/provider/temp_selected_slots.dart';
import 'package:shop_ecommerce/screens/all_view/U_M_view.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/details/components/body.dart';
import 'package:shop_ecommerce/screens/no_data_found/no_data_found.dart';
import 'package:shop_ecommerce/size_config.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
       this.id,
  }) : super(key: key);

  static String routeName = "/details";

  final String? id;
   @override
  Widget build(BuildContext context) {
    // final ProductDetailsArguments agrs =
      //   ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    Future<bool> clearSelectedSlots() {
      context.read<TempReservedSlots>().clear();
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: clearSelectedSlots,
      child: FirestoreQueryBuilder<Product>(
          query: productQuery(true,arguments !=null?  arguments['id']:id??""),
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return Center(child: const CircularProgressIndicator());
            }
            if(snapshot.docs.length==0) {
              return NoDataFound();
            }
            if (snapshot.hasError||!snapshot.hasData) {
              return Center(child: BgBox(bgColor: DarkPurple, child: Text('Something went wrong!')));
            }
           
            Product product = snapshot.docs[0].data();

            return AllView(
              body:  
                    UnderMaintainanceView(
                      child: Body(
                        product: product,
                        id: arguments != null ? arguments['id'] : id ?? "",
                                      
                                   ),
                    ),
                   
            );
          }),
    );
  }
}

// class ProductDetailsArguments {
//   final product;
//   final String id;
//   ProductDetailsArguments({
//     required this.product,
//     required this.id,
//   });
// }
