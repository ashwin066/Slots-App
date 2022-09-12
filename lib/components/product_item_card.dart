import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/get_put_data/add_to_cart_wishlist.dart';
import 'package:shop_ecommerce/get_put_data/remove_one_from_user_DB.dart';
import 'package:shop_ecommerce/service/controllers/cart_ID_Controller.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard(
      {Key? key,
      // this.controllerForCart,
      // this.controllerForWishlist,
      required this.product,
      required this.index,
      //    required this.index,
      required this.type,
      required this.press})
      : super(key: key);

  // final CartController? controllerForCart;
  // final WishlistController? controllerForWishlist;
  final product;
  final int index;
//  final int index;
  final GestureTapCallback press;
  final type;

  @override
  Widget build(BuildContext context) {
    //  print(productData["product_name"]);
    final cartIDcontroller = Get.put(CartIdController());

    return Container(
        padding: EdgeInsets.only(bottom: 6),
        margin: EdgeInsets.symmetric(horizontal: 15),
      
      child: GestureDetector(
        onTap: press,
        child:  Row(
            children: [
              SizedBox(
                width: 88.w,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColorLight,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product_name,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          text: "\₹${product.current_price} ",
                          style: const TextStyle(color: PrimaryColor),
                          children: [
                            TextSpan(
                                text: "${product.mrp}",
                                style: TextStyle(
                                    color: LightGray,
                                    fontSize: 13.sp,
                                    decoration: TextDecoration.lineThrough)),
                            type == "cart"
                                ? TextSpan(
                                    text:
                                        " x ${cartIDcontroller.products[index].quantity}",
                                    style:
                                        TextStyle(color: aBlack, fontSize: 17.sp))
                                : TextSpan(text: ""),
                            // TextSpan(
                            //   text: "  x${productData["name"].toString().length}",
                            //   style: const TextStyle(color: kTextColor),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        type == "cart"
                            ?   Container(
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: LightSecondaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6.r))),
                                  child: Row(
                                    children: [
                                      IconButtonCustom(
                                          icon: "assets/icons/minus_icon.svg",
                                          press: () {
                                            removeOneFromUserDB(
                                                id: product.id,
                                                whereToRemove: "users-cart-items");
                                          },
                                          height: 14,
                                          width: 14,
                                          color: aWhite),
                                      SizedBox(width: 6.h),
                                      Text(
                                        "Quantity".toString(),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: PrimaryColor,
                                        ),
                                      ),
                                      SizedBox(width: 6.h),
                                      IconButtonCustom(
                                          icon: "assets/icons/Plus Icon.svg",
                                          press: () {
                                            addToUserDB(
                                              ProductData: product,
                                              whereToAdd: "users-cart-items",
                                            );
                                            // type == "cart"
                                            //     ? controllerForCart?.addProduct(product)
                                            //     : controllerForWishlist
                                            //         ?.addProductToWishlist(product);
                                          },
                                          height: 14,
                                          width: 14,
                                          color: aWhite),
                                    ],
                                  ),
                                
                              )
                            : Text("Wishlisted"),
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: LightRed,
                              borderRadius: BorderRadius.all(Radius.circular(6.r))),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/swipe-left-icon.svg",
                                height: 17.h,
                                width: 17.w,
                                color: TomatoRed,
                              ),
                              SizedBox(width: 3.h),
                              SvgPicture.asset(
                                type == "cart"
                                    ? "assets/icons/Trash.svg"
                                    : "assets/icons/Broken Heart Icon.svg",
                                height: 17.h,
                                width: 17.w,
                                color: TomatoRed,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
             
            ],
          ),
         
      ),
    );
  }
}
