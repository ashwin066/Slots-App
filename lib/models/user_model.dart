import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.phonenumber,
    this.email,
    this.joined_on,
    this.state,
    this.city,
  });

  UserModel.fromSharedPref(
      String firstname, String? lastname, String phonenumber, String email)
      : this(
          firstName: firstname,
          lastName: lastname == null ? null : lastname,
          phonenumber: phonenumber,
          email: email,
            joined_on:null,
            state: null,
            city: null,
        );

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          firstName: json['firstname'] as String,
          lastName: json['lastname'] as String,
          phonenumber: json['phonenumber'] as String,
          email: json['email'] as String,
          joined_on:
              json['joined_on'] != null ? json['joined_on'] as Timestamp : null,
          state: json['state'] != null ? json['state']! as String : null,
          city: json['city'] != null ? json['city']! as String : null,
        );

  final String? firstName;
  final String? lastName;
  final String? phonenumber;
  final String? email;
  final Timestamp? joined_on;
  final String? state;
  final String? city;

  Map<String, Object?> toJson() {
    return {
      "firstname": firstName,
      "lastname": lastName,
      "phonenumber": phonenumber,
      "email": email,
      "joined_on": joined_on,
    };
  }
}

FirebaseService _service = FirebaseService();

// getUserData() {
//   return _service.users
//       .doc(_service.user!.uid)
//       .collection("user_info")
//       .withConverter<UserModel>(
//         fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
//         toFirestore: (user, _) => user.toJson(),
//       );
// }

globalUserMinimalInfo(String uid) {
  return _service.users
      .doc(uid)
      .collection("user_info")
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
}
