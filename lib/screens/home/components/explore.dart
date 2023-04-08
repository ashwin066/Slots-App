import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/main_banner_fetch.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/components/custom_divider.dart';
import 'package:shop_ecommerce/screens/home/components/featured_cards.dart';
import 'package:shop_ecommerce/screens/home/components/popular_products.dart';
import 'package:shop_ecommerce/screens/home/components/section_title.dart';
import 'package:shop_ecommerce/size_config.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(10)),

        MainBannerFetch(
          imageColletion: "Main Banner",
          height: 135,
        ),
 
     
     
     PopularProducts() ,
        //SizedBox(height: getProportionateScreenWidth(18)),
        //   const Categories(),
      SizedBox(height: getProportionateScreenWidth(13)),

      // CustomDivider(),
        FeaturedCard(),
      CustomDivider(), SizedBox(height: getProportionateScreenWidth(5)),

        SectionTitle(text: "Deals & Rewards", press: () {}),
         SizedBox(height: getProportionateScreenWidth(15)),

        MainBannerFetch(
          useListSlider: true,
          imageColletion: "Small banner",
          height: 180,
          viewportFraction: .6,
        ),
        SizedBox(height: getProportionateScreenWidth(13)),
        CustomDivider(),
        SizedBox(height: getProportionateScreenWidth(5)),

        SectionTitle(text: "Events & Giveaways", press: () {}),
        SizedBox(height: getProportionateScreenWidth(15)),

       
        MainBannerFetch(
          imageColletion: "Events Banner",
          height: 350,
          boxFit: BoxFit.cover,
        ),
    
      ],
    );
  }
}
