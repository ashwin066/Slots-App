import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/progress_segmented.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/screens/home/components/body.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.id,
    this.width = 140,
    this.aspectRetion = 1.02, 
  }) : super(key: key);
  final double width, aspectRetion;
  final MinimumProduct product;
  final String id;
   @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: getProportionateScreenHeight(10),top:  getProportionateScreenHeight(3),bottom:  getProportionateScreenHeight(3)),
      padding: paddingMarginAll8,
      decoration: BoxDecoration(
          color: aWhite,
          borderRadius: BorderRadius.circular(10),
        //  boxShadow: [
        //   BoxShadow(
        //     color: DarkPurple,
        //     blurRadius: 0,
        //     offset: Offset(-3, -3),
        //   ),
        // ],
           border: border0by8lightGray
          ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(PageTransition(
              type: PageTransitionType.fade ,
              duration: defaultDuration350 ,
               curve: Curves.fastOutSlowIn,
              reverseDuration: defaultDuration,
              child: DetailsScreen(
                id: id,
              )));

          // Navigator.pushNamed(
          //   context,
          //   DetailsScreen.routeName,
          //   arguments: ProductDetailsArguments(product: product, id: id),
          // );
        },
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRetion,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                  decoration: BoxDecoration(
                    color: aWhite,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.imageURLs![0],
                    placeholder: (context, url) => Simmer(
                      borderRadius: borderRadius13,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Text(
                product.productName!,
                style: text13DarkFw500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              if (product.reservedSlots != null)
                if (product.totalSlots != null)
                  MyProgressBar(
                    centerText: true,
                    soldOutSlots: product.reservedSlots!.length,
                    totalSlots: product.totalSlots!,
                  ),
                  
              SizedBox(height: getProportionateScreenHeight(5)),
              BgBox(
                bgColor: transparentDarkPurple.withOpacity(.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/ticket_filled.svg",
                      height: getProportionateScreenHeight(19),
                      width: getProportionateScreenHeight(19),
                      color: transparentDarkPurple,
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    Text(
                      "${product.slotPrice}",
                      style: text15DarkFw800,
                    ),
                    Text(" ${product.slotPrice == 1 ? "Ticket" : "Tickets"}",
                        style: TextStyle(
                            color: aBlack.withOpacity(.6),
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
