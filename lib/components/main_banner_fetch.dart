import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class MainBannerFetch extends StatefulWidget {
  MainBannerFetch({
    Key? key,
    required this.imageColletion,
    this.height,
    this.viewportFraction,
    this.useListSlider,
    this.boxFit,
  }) : super(key: key);
  final String imageColletion;
  final double? height;
  final double? viewportFraction;
  final bool? useListSlider;
  final BoxFit? boxFit;
  @override
  State<MainBannerFetch> createState() => _MainBannerFetchState();
}

class _MainBannerFetchState extends State<MainBannerFetch> {
  List<String> _carouselImages = [];
  List<String> _routeNames = [];
  List<Map> arguments = [];
  bool isLoading = true;
   List<String?>? type=[];

  fetchCarouselImages(String collection) async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection(collection).get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["image"],
        );
        _routeNames.add(
          qn.docs[i]["route_name"],
        );
        arguments.add(qn.docs[i]["arguments"]);
        type!.add(qn.docs[i]["type"]);
      }
    });
    setState(() {
      isLoading = false;
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages(widget.imageColletion);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    FirebaseService _service = FirebaseService();

    return _carouselImages.length > 0
        ? widget.useListSlider != true
            ? isLoading
                ? Padding(
                    padding: paddingMarginLR15,
                    child: Simmer(
                      height: widget.height != null
                          ? getProportionateScreenHeight(widget.height!)
                          : getProportionateScreenHeight(135),
                    ),
                  )
                : GFCarousel(
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 350),
                    autoPlayCurve: Curves.easeInOut,
                    scrollDirection: Axis.horizontal,
                    scrollPhysics: _carouselImages.length == 1
                        ? NeverScrollableScrollPhysics()
                        : null,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    height: widget.height != null
                        ? getProportionateScreenHeight(widget.height!)
                        : getProportionateScreenHeight(135),
                    items: [
                        ...List.generate(
                          _carouselImages.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                if(type![index]=="external"){
                         _service.launchMyUrl(
                                      _routeNames[index],
                                      LaunchMode.externalApplication);
                              }if(type![index] =="inApp"){
                                Navigator.pushNamed(
                                  context,
                                  _routeNames[index],
                                  arguments: arguments[index],
                                );}
                              },
                              child: Padding(
                                padding: paddingMarginLR15,
                                child: CachedNetworkImage(
                                  imageUrl: _carouselImages[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: borderRadius13,
                                      border: border0by8lightGray,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => Simmer(
                                    borderRadius: borderRadius13,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  height: widget.height != null
                                      ? getProportionateScreenHeight(
                                          widget.height!)
                                      : getProportionateScreenHeight(190),
                                  fit: widget.boxFit != null
                                      ? widget.boxFit
                                      : null,
                                ),
                              ),
                            );
                            //  }
                            // return SizedBox
                            //     .shrink(); // here by default width and height is 0
                          },
                        )
                      ])
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(
                      _carouselImages.length,
                      (index) {
                        return _carouselImages == null
                            ? Padding(
                                padding: paddingMarginL15,
                                child: Expanded(child: Simmer()),
                              )
                            : InkWell(
                                onTap: () {
                                  if (type![index] == "external") {
                                    _service.launchMyUrl(_routeNames[index],
                                        LaunchMode.inAppWebView);
                                  }
                                  if (type![index] == "inApp") {
                                    Navigator.pushNamed(
                                      context,
                                      _routeNames[index],
                                      arguments: arguments[index],
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: paddingMarginL15,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            getProportionateScreenHeight(4)),
                                    child: CachedNetworkImage(
                                      imageUrl: _carouselImages[index],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: borderRadius10,
                                          border: border0by8lightGray,
                                       
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Simmer(
                                        borderRadius: borderRadius13,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      height: widget.height != null
                                          ? getProportionateScreenHeight(
                                              widget.height!)
                                          : getProportionateScreenHeight(190),
                                      width: getProportionateScreenHeight(140),
                                    ),
                                  ),
                                ),
                              );
                        //  }
                        // return SizedBox
                        //     .shrink(); // here by default width and height is 0
                      },
                    ),
                    SizedBox(
                      child: Padding(padding: paddingMarginL15),
                    )
                  ],
                ),
              )
        : Container(
            height: widget.height != null
                ? getProportionateScreenHeight(widget.height!)
                : getProportionateScreenHeight(135),
          );
  }
}
