import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  String? firstname1;
  String? lastname1;
  String? email1;

  @override
  void initState() {
    EasyLoading.show();
    // TODO: implement initState
    super.initState();
    getIt() async {
      final firstname = await GetUserData().getUserInfoAsString("firstName");
      final lastname = await GetUserData().getUserInfoAsString("lastName");
      final email = await GetUserData().getUserInfoAsString("email");
      setState(() {
        firstname1 = firstname;
        lastname1 = lastname;
        email1 = email;
      });
    }

    getIt();
  }

  @override
  Widget build(BuildContext context) {    FirebaseService _service = FirebaseService();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
        child: CustomAppBar(),
      ),
      body: WillPopScope( 
        onWillPop:  () {
                 return _service.showAlertDialog(
              context,
              "Are you sure",
              "Want to leave this chat?",
              "No",
              () {
                Navigator.pop(context);
              },
              "Yes",
              () {
                Navigator.pop(context);
                Navigator.pop(context);
              });

        } ,
        child: Tawk(
          directChatLink: 'tawk.to/chat/63a85b46c2f1ac1e202a0c63/1gl4q939f',
          visitor: TawkVisitor(
            name: "${firstname1} ${lastname1}",
            email: email1,
          ),
          onLoad: () {
            EasyLoading.dismiss();
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
           
            print(url);
          },
          placeholder: Center(
            child:   
                Text('Loading...'),
              
            ),
          
        ),
      ),
    );
  }
}
