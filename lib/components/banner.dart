import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class MainBanner extends StatefulWidget {
  MainBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBanner> createState() => _MainBannerState();
}

class _MainBannerState extends State<MainBanner> {
  List<String> _carouselImages = [];

  fetchCarouselImages() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("Main Banner").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["image"],
        );
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return CarouselSlider(
      
        options: CarouselOptions(
          height:200,
          viewportFraction: 0.97,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
        items:   _carouselImages.map((item)=>
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                 image: DecorationImage(
                    image: NetworkImage(item),
                    fit: BoxFit.cover)),
           ),
          
         ).toList()
        );
  }
}
