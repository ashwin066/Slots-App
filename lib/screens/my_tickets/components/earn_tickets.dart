import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/info_bottom_sheet.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/service/ads/admobHelper.dart';
import 'package:shop_ecommerce/size_config.dart';

class EarnTickets extends StatefulWidget {
  EarnTickets({
    Key? key,
  }) : super(key: key) {}

  @override
  State<EarnTickets> createState() => _EarnTicketsState();
}

class _EarnTicketsState extends State<EarnTickets> {
  final admodHelper = AdmobHelper();
  // @override
  // void initState() {
  //   // admodHelper.addAds(context, true);

  //   super.initState();
  // }

  @override
  void dispose() {
    admodHelper.disposeAds();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   BgBox(
      padding: paddingMarginAll15,
      margin: paddingMarginLR15,
      bgColor: MuchDarkPurple,linearGradient: linearGradient5,
      borderRadius: borderRadius18,
      child: Column(
            children: [
              Row(
                children: [

                  Flexible(
                    child: DefaultButton(
                        text: "Watch & Earn", 
                        button_color: aWhite,text_color: aBlack,
                        press: () {
                          admodHelper.loadRewardedAd(context);
                        }),
                  ),
                  BgBox(
                  bgColor: transparentWhite,
                  borderRadius: borderRadius50,
                  margin: EdgeInsets.only(
                       left: getProportionateScreenHeight(13),
                     ),
                 
                  child: SizedBox(
                    height: getProportionateScreenHeight(35),
                  //  width: getProportionateScreenHeight(27),
                    child: Center(child: Text("AD",style: text15DarkFw800,)),
                  )),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Row(
                children: [
                  Flexible(
                    child: DefaultButton(
                        text: "Refer & Earn",text_color: MuchDarkPurple, button_color: MediumPinkPurple, press: () {}),
                  ),
                    BgBox(
                  bgColor: transparentWhite,
                  borderRadius: borderRadius50,
                  margin: EdgeInsets.only(
                    left: getProportionateScreenHeight(13),
                  ),
                  child: SizedBox(
                    height: getProportionateScreenHeight(35),
                    //  width: getProportionateScreenHeight(27),
                    child: Center(
                        child: SvgPicture.asset(
                        "assets/icons/share.svg",
                       ),
                    ),
                  )),
                ],
              ),
                   
            ],
          ),
        
      
    );
  }
}
