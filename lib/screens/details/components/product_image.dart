import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GFCarousel(
          enlargeMainPage: true,
          hasPagination: true,
          activeIndicator: MediumPinkPurple,
          passiveIndicator: DarkPurple,
          items: [
            ...List.generate(
              product.imageURLs.length,
              (index) => Padding(
                padding:
                    EdgeInsets.only(bottom: getProportionateScreenHeight(25)),
                child: ClipRRect(
                  borderRadius: borderRadius18,
                  child: CachedNetworkImage(
                    imageUrl: product.imageURLs[index],
                    fit: BoxFit.contain,

                    // width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) => Simmer(
                      borderRadius: BorderRadius.zero,
                    ),

                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
          height: getProportionateScreenHeight(250),
          aspectRatio: 5 / 5,
          viewportFraction: 0.97,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 8),
          autoPlayAnimationDuration: Duration(milliseconds: 350),
          autoPlayCurve: Curves.easeInOut,
          scrollDirection: Axis.horizontal,
        ),
        IconButtonCustom(
            press: () async {
              EasyLoading.show(status: "Please wait");
              final dynamicLinkParams = DynamicLinkParameters(
                link: Uri.parse(
                    "https://foundyo-52bc1.web.app/product/${product.id}"),
                uriPrefix: "https://slotslive.page.link",
                androidParameters: AndroidParameters(
                    packageName: "com.foundyo.user",
                    fallbackUrl: Uri.parse('https://foundyo-52bc1.web.app')),
                iosParameters: IOSParameters(
                    bundleId: "com.foundyo.user",
                    fallbackUrl: Uri.parse('ttps://foundyo-52bc1.web.app')),
              );

              //for long url
              // final link = await FirebaseDynamicLinks.instance
              //     .buildLink(dynamicLinkParams);
              //for short url
              final dynamicLink = await FirebaseDynamicLinks.instance
                  .buildShortLink(dynamicLinkParams);
              EasyLoading.dismiss();
              await Share.share(dynamicLink.shortUrl.toString());
            },
            icon: "assets/icons/share.svg",
            height: 17,
            width: 17,
            customMargin: 13,
            color: aWhite,
            customPadding: 10,
            bgColor: transparentDarkPurple),
      ],
    );
  }
}
