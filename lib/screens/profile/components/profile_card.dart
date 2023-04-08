import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/edit_profile/edit_profile.dart';
import 'package:shop_ecommerce/screens/profile/components/profile_pic.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;

  final VoidCallback press;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String? firstname1;
  String? lastname1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIt() async {
      final firstname = await GetUserData().getUserInfoAsString("firstName");
      final lastname = await GetUserData().getUserInfoAsString("lastName");
      setState(() {
        firstname1 = firstname;
        lastname1 = lastname;
      });
    } 
    getIt();
  }
  @override
  Widget build(BuildContext context) {
    //      Userprovider? userData = Provider.of<Userprovider>(context) != null
    // ? Provider.of<Userprovider>(context)
    // : null;
  

    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.fade,
            duration: defaultDuration,
            reverseDuration: defaultDuration,
            child: EditProfileScreen()));
      },
      child: Container(
        margin: paddingMarginLR15,
        padding: paddingMarginAll15,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: aBlack,
          borderRadius: borderRadius10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProfilePic(
              imageUrl: "",
            ),
            SizedBox(width: getProportionateScreenHeight(20)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  if(userData!=null&& userData.user!=null)
                      Text(
                        "${firstname1??""} ${lastname1??""}",
                        style: text18lightFw400,
                      ),
                      SizedBox(height: getProportionateScreenHeight(3)),
                      Text(
                        "Manage profile",
                        style: text15DarkGrayFw400,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: getProportionateScreenHeight(10)),
                    child: SvgPicture.asset(
                      "assets/icons/arrow_right.svg",
                      height: getProportionateScreenHeight(15),
                      width: getProportionateScreenHeight(15),
                      color: aWhite,
                    ),
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
