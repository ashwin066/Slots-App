import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 300.h,
              aspectRatio: 5 / 5,
              viewportFraction: 0.97,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 8),
              autoPlayAnimationDuration: Duration(milliseconds: 350),
              autoPlayCurve: Curves.easeInOut,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedImage = index;
                });
              },
            ),
            items: [
              ...List.generate(
                  widget.product.images.length,
                  (index) => Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        decoration: BoxDecoration(
                            color: aWhite,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.product.images[index]),
                                fit: BoxFit.contain)),
                      )),
            ]),

        // SizedBox(height: getProportionateScreenWidth(20)),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(widget.product.images.length,
                  (index) => buildSmallProductPreview(index)),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        _controller.animateToPage(index);
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 2,
            color: GlowBlue.withOpacity(selectedImage == index ? 1 : 0),
          ),
        ),
        child: Image.network(widget.product.images[index]),
      ),
    );
  }
}
