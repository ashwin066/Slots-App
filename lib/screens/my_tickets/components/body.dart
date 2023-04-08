import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/fade_indexed_stack.dart';
import 'package:shop_ecommerce/components/flip_card.dart';
import 'package:shop_ecommerce/components/footer.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/ticket_bg.dart';
import 'package:shop_ecommerce/components/ticket_info.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/my_tickets/components/body_lower_part.dart';
import 'package:shop_ecommerce/screens/my_tickets/components/earn_tickets.dart';
import 'package:shop_ecommerce/screens/my_tickets/components/purchase_tickets.dart';
import 'package:shop_ecommerce/service/ads/admobHelper.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
  Body({super.key, required this.current});

 
  int current;
 
       final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
   
 
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
             FlipCard(
                  controller: controller,
                  front: TicketInfo(
                    typeIsTicketMoreInfo: false,
                  onClickFlip: () async {
                      await controller.flipCard();
                    },),
                  back: TicketInfo(typeIsTicketMoreInfo:true,
                    onClickFlip: () async {
                      await controller.flipCard();
                    },
                  )),
            

          BodyLower(current: current,),

            Footer(height: 190),
          ],
        ),
      ),
    );
  }
}
