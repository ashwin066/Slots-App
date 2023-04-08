import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/ticket_price_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets_combo.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/no_data_found/no_data_found.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class PurchaseTickets extends StatefulWidget {
  PurchaseTickets({
    super.key,
  });

  @override
  State<PurchaseTickets> createState() => _PurchaseTicketsState();
}

class _PurchaseTicketsState extends State<PurchaseTickets> {
  @override
  Widget build(BuildContext context) {
    return BgBox(
      padding: paddingMarginT12,
      margin: paddingMarginLR15,
      bgColor: lightDarkPurple,
      //linearGradient: linearGradient5,
      borderRadius: borderRadius18,
      child: Column(
        children: [
          FirestoreQueryBuilder<TicketsCombo>(
              query: ticketsComboQuery(true),
              builder: (context, snapshot, _) {
                if (snapshot.docs.length == 0) {
                  return NoDataFound();
                }
                if (snapshot.isFetching) {
                  return Padding(
                    padding: paddingMarginB12LR12,
                    child: Simmer(
                      height: getProportionateScreenHeight(150),
                    ),
                  );
                }
                return Column(
                  children: [
                        ...List.generate(
                      snapshot.docs.length,
                      (index) {
                        TicketsCombo ticket = snapshot.docs[index].data();
                        
                        return  TicketPriceCard( ticket: ticket,
                
              );
                        }
                        
                        
                        ) 
                  ],
                );
              }),
          
        ],
      ),
    );
  }
}
