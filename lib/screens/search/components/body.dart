import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/back_button.dart';
  import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/components/popular_products.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var searchTerm = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: BackButtton(),
                ),
               
                Expanded(
                
                    child: Container(
                      width: SizeConfig.screenWidth!.w,
                      decoration: BoxDecoration(
                        color: PrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchTerm=value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Search Products",
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20.w),
                            vertical: getProportionateScreenWidth(12.w),
                          ),
                        ),
                      ),
                   
                  ),
                ),
              
              ],
            ),
          ),
          Expanded(
              child: Container(
             
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Product Data").where("product_name", isEqualTo: searchTerm )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Card(
                        elevation: 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(data["product_name"]),
                            leading: Image.network(data["images"][0]),
                          ),
                        ),
                      );
                    }).toList(),
                    
                  );
                }),
          )),
            PopularProducts(),
            SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
