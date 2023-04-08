import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/ticket_price_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets_combo.dart';
import 'package:shop_ecommerce/models/user_transactions.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/no_data_found/no_data_found.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Transactions",
            style: text23DarkFw700,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          FirestoreQueryBuilder<UserTransactionsModel>(
              query: userTransactionsQuery(),
              builder: (context, snapshot, _) {
                if (snapshot.docs.length == 0) {
                  return NoDataFound();
                }
                if (snapshot.isFetching) {
                  return Padding(
                    padding: paddingMarginB12LR12,
                    child: Simmer(
                      height: getProportionateScreenHeight(150),
                    ),
                  );
                }
                return Column(
                  children: [
                    ...List.generate(snapshot.docs.length, (index) {
                      UserTransactionsModel transactions =
                          snapshot.docs[index].data();

                      return Padding(
                        padding: paddingMarginLR15,
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              children: [
                                Text(
                                  transactions.transaction_name ?? "no",
                                  style: text13DarkFw500,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${transactions.amount.toString()} " ??
                                          "no",
                                      style: text13DarkFw500,
                                    ),
                                    Text(
                                      transactions.transaction_type ?? "no",
                                      style: text13DarkFw500,
                                    ),
                                  ],
                                ),
                                 if(transactions.date_time_of_transaction!=null)
                                Text(
                                  "${_service.formatedDate(transactions.date_time_of_transaction!.toDate())}",
                                  style: text13DarkGrayFw500,
                                ),
                                if(transactions.transaction_was_successful !=
                                    null)
                                    if(transactions.transaction_was_successful ==
                                      true)
                                Text(
                                  "Transaction was successful",
                                  style: text13GreenFw500,
                                )else
                                    Text(
                                      "Transaction was unsuccessful",
                                      style: text13RedFw500,
                                    )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                );
              }),
        ],
      ),
    );
  }
}
