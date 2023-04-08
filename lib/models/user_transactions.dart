import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class UserTransactionsModel {
  UserTransactionsModel({
     this.transaction_type,
    this.transaction_name,
    this.amount,
    this.date_time_of_transaction,
    this.transaction_was_successful, 
  });

  UserTransactionsModel.fromJson(Map<String, Object?> json)
      : this(
          transaction_type: json['transaction_type']! as String,
          transaction_name: json['transaction_name']! as String,
          amount: json['amount'] == null ? null : json['amount']! as int,
          date_time_of_transaction: json['date_time_of_transaction'] == null
              ? null
              : json['date_time_of_transaction']! as Timestamp,
          transaction_was_successful: json['transaction_was_successful'] == null ? null : json['transaction_was_successful']! as bool,
        );

  final String? transaction_type;
  final String? transaction_name;
  final int? amount;
  final Timestamp? date_time_of_transaction;
  final bool? transaction_was_successful;
 
  Map<String, Object?> toJson() {
    return {
      "transaction_type": transaction_type,
      "transaction_name": transaction_name,
      "amount": amount,
      "date_time_of_transaction": date_time_of_transaction,
      "transaction_was_successful": transaction_was_successful,
    };
  }
}

userTransactionsQuery( ) {
 
  return  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("user_transactions")
      //.where('approved', isEqualTo: approved)
      .withConverter<UserTransactionsModel>(
        fromFirestore: (snapshot, _) => UserTransactionsModel.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
