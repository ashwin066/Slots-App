import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/profile/components/profile_pic.dart';
import 'package:shop_ecommerce/screens/universal_winner_screen/universal_winner_screen.dart';
import 'package:shop_ecommerce/screens/winner_screen/winner_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class WinnerCard extends StatelessWidget {
  const WinnerCard({
    Key? key,
    required this.product,
    required this.user, required this.id,
  }) : super(key: key);
  final String id;
  final MinimumProduct product;
  final FirestoreQueryBuilderSnapshot<UserModel> user;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
            onTap: () {
            Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeft,curve: Curves.fastLinearToSlowEaseIn,
                duration: defaultDuration,
                reverseDuration: defaultDuration,
                child: UniversalWinnerScreen(product: product,id: id,user:user,  )));
          },
       child: Container(
            margin: paddingMarginAll15,
           
            width: double.infinity,
            decoration: BoxDecoration(color: aBlack, borderRadius: borderRadius18),
         
         child: Row(  children: <Widget>[
          Expanded(flex: 6,
            child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: DarkProffesionalGreen,
                              borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                              
                            ),
                            child: Padding(
                              padding: paddingMarginLR11TB3,
                              child: Text("Congratulations!",style: text13LightFw500,)),
                          ),
                          Padding(
                      padding: paddingMarginLR15,                      
                      child: Row(
                              children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     SizedBox(height: getProportionateScreenHeight(6),),
                                    
                                      if (user.docs.length > 0)
                                        Text(
                                          "${user.docs[0].data().firstName!} ${user.docs[0].data().lastName != null ? user.docs[0].data().lastName! : ""}",
                                          style: text16LightFw500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      if (user.docs[0].data().city != null ||
                                          user.docs[0].data().state != null)
                                        Text(
                                          "From ${user.docs[0].data().city}, ${user.docs[0].data().state}",
                                          style: text12DarkGrayFw400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                 
                              ],
                            ),
                          ),
                        
                          Padding(
                             padding: paddingMarginAll15,
                            child: SizedBox(
                      width: SizeConfig.screenWidth! / 2.5,
                              child: 
                                  Column(
                                    children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Has Won! ",
                                  style: text15MediumPinkPurpleFw800,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/trophy_outline.svg",
                                  height: getProportionateScreenHeight(24),
                                  width: getProportionateScreenHeight(24),
                                  color: MediumPinkPurple,
                                ),
                              ],
                            ),
                                      Text(
                                        "${product.productName}",
                                        style: text12DarkGrayFw400,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                
                            ),
                          ),
                        ],
                      ),
                    
                 
          ),
           
          
            Expanded(
            flex: 4,
            child:  
                  Row(
                    children: [
                      Flexible(
                        child: BgBox( 
                          bgColor: Transparent,
                          padding: paddingMarginAll8,
                          child: ClipRRect(
                            borderRadius: borderRadius18,
                            child: CachedNetworkImage(
                              
                              imageUrl: product.imageURLs![0],
                            ),
                                         
                                        ),
                        ),
                      ),SizedBox(width: getProportionateScreenHeight(20),)
                    ],
                  ),
                 
              
          )
             ]),
       ),
    );
  }
}
