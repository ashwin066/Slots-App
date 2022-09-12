import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/get_put_data/add_to_cart_wishlist.dart';
import 'package:shop_ecommerce/get_put_data/remove_from_cart_wishlist.dart';
import 'package:shop_ecommerce/service/controllers/wishlist_controller.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final product;
  final GestureTapCallback pressOnSeeMore;
  final wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    int Saved = product.mrp - product.current_price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Text(
            "${product.product_name.toString()}",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.sp,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: PrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Text(
                      "${product.rating.toString()}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: aBlack),
                    ),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(
                      "assets/icons/Star Icon.svg",
                      height: 14.h,
                      width: 14.w,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.sp,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: PrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                child: InkWell(
                  onTap: () {
                    wishlistController.addProductToWishlist(product);
                    addToUserDB(
                        ProductData: product, 
                        whereToAdd: "users_wishlisted_items");
                  },
                  child: Obx(
                    () => Row(
                      children: [
                        Text(
                          "Wishlist",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: aBlack),
                        ),
                        SizedBox(width: 5.w),
                        SvgPicture.asset(
                          wishlistController.products.length > 0
                              ? "assets/icons/Heart filled.svg"
                              : "assets/icons/Heart outline.svg",
                          color: wishlistController.products.length > 0
                              ? TomatoRed
                              : LightGray,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection("users")
              //         .doc(FirebaseAuth.instance.currentUser!.uid)
              //         .collection("users-wishlisted-items")
              //         .where("id", isEqualTo: product['id'])
              //         .snapshots(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if (snapshot.hasError) {
              //         return Text("Something went wrong!");
              //       } else if (snapshot.hasData) {
              //         return InkWell(
              //           onTap: () {
              //             print(snapshot.data.docs.id.toString());
              //             snapshot.data.docs.length != 0
              //                 ? removeFromUserDB(
              //                     id: snapshot.data.docs[0].documentID,
              //                     whereToRemove: "users-wishlisted-items")
              //                 : addToUserDB(
              //                     id: product.id,
              //                     whereToAdd: "users-wishlisted-items");
              //           },
              //           child: Container(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 14.sp,
              //               vertical: 5,
              //             ),
              //             decoration: BoxDecoration(
              //               color: PrimaryColor.withOpacity(0.1),
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(9.r)),
              //             ),
              //             child: Row(
              //               children: [
              //                 Text(
              //                   "Wishlist",
              //                   style: TextStyle(
              //                       fontSize: 14.sp,
              //                       fontWeight: FontWeight.w600,
              //                       color: aBlack),
              //                 ),
              //                 SizedBox(width: 5.w),
              //                 SvgPicture.asset(
              //                   snapshot.data.docs.length != 0
              //                       ? "assets/icons/Heart filled.svg"
              //                       : "assets/icons/Heart outline.svg",
              //                   color: snapshot.data.docs.length != 0
              //                       ? SecondaryColor
              //                       : Color.fromARGB(255, 194, 194, 194),
              //                   height: 20.h,
              //                   width: 20.w,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       }
              //       return SizedBox(
              //           height: 25,
              //           width: 25,
              //           child: CircularProgressIndicator(
              //             strokeWidth: 3,
              //             color: SecondaryColor,
              //           ));
              //     }),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: PrimaryColor,
            borderRadius: BorderRadius.circular(9.r),
            image: DecorationImage(
                image: AssetImage('assets/images/offer.png'),
                alignment: Alignment.bottomRight,
                opacity: 0.7,
                fit: BoxFit.contain),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹ ${product.current_price.toString()}",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: aWhite),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "${product.mrp.toString()}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: aWhite.withOpacity(0.5),
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    "assets/icons/Flash Icon.svg",
                    height: 25.h,
                    width: 25.w,
                  ),
                ],
              ),
              SizedBox(height: 3.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "₹ ${Saved.toString()}.00",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Success),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Savings",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: SecondaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "You will earn",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: PrimaryColor),
                                ),
                                Text(
                                  " 800",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: PrimaryColor),
                                ),
                                Text(
                                  " YoCoins",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: PrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.w),
                          Text(
                            "2 YoCoin = 1 Rupee",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: aWhite.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    "assets/icons/Gift Icon.svg",
                    height: 25.h,
                    width: 25.w,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 7.h),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "Product Description: ${product.description.toString()}",
            maxLines: 100,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: PrimaryColor,
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: PrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
