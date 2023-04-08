import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

User? user1 = FirebaseAuth.instance.currentUser;

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference user_purchased_slots = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("user_purchased_slots");
  final CollectionReference user_temp_selected_slots = FirebaseFirestore
      .instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("user_temp_selected_slots");
  final CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  final CollectionReference mainCategories =
      FirebaseFirestore.instance.collection("mainCategories");
  final CollectionReference subCategories =
      FirebaseFirestore.instance.collection("subCategories");
  final CollectionReference product =
      FirebaseFirestore.instance.collection("products");

  Future<void> addProductToDB(
      {BuildContext? context,
      CollectionReference? collection,
      Map<String, dynamic>? data,
      String? reference}) {
// Call the user's Collection Reference to add a new user

    return collection!
        .add(data!)
        .then((value) => scaffold(context, "products Added Successfully"))
        .catchError(
            (error) => scaffold(context, "Failed to add product: $error"));
  }

  Future<void> bookSlot({
    BuildContext? context,
    required CollectionReference? collection,
    required CollectionReference? userTicketCollection,
    required String productID,
    required Map<String, dynamic>? reservedSlots,
    Map<String, dynamic>? ticketDetails,
    bool? deleteTempReservedSlotsfromUserCollection,
  }) {
// Call the user's Collection Reference to add a new user

    return collection!
        .doc(productID)
        .get()
        .then((doc2) => {
              if (!doc2.exists)
                {collection.doc(productID).set(reservedSlots!)}
              else
                {collection.doc(productID).update(reservedSlots!)}
            })
        .then((value) {
      userTicketCollection!
          .doc(productID)
          .get()
          .then((doc) => {
                if (ticketDetails != null)
                  {
                    if (doc.exists == false)
                      {userTicketCollection.doc(productID).set(ticketDetails)}
                    else
                      {
                        userTicketCollection
                            .doc(productID)
                            .update(ticketDetails)
                      }
                  }
              })
          .then((value) {
        if (deleteTempReservedSlotsfromUserCollection == true) {
          userTicketCollection.doc(productID).delete();
        }
      });
    }).catchError(
            (error) => scaffold(context, "Failed to update slot: $error"));
  }

  Future<void> addRemoveTickets({
     required Map<String, dynamic>? ticketData,
  }) {
// Call the user's Collection Reference to add a new user

    return users
        .doc(user!.uid)
        .collection("user_tickets")
        .doc(user!.uid)
        .update(ticketData!)
        .then((value) => print("Tickets deducted from db"))
        .catchError((error) => print("Error deducting tickets:: $error ")   
             );
  }

  Widget formField(
      {String? label,
      TextInputType? inputType,
      void Function(String)? onChanged,
      int? minline,
      int? maxline,
      value,
      TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        style: text16LightGrayFw400,
        cursorColor: SecondaryColor,
        initialValue: value,
        controller: controller,
        keyboardType: inputType,
        minLines: minline ?? 1,
        maxLines: maxline ?? 1,
        onChanged: onChanged,
        decoration: InputDecoration(
            label: Text(
          label!,
          style: text16DarkGrayFw400,
        )),
      ),
    );
  }

  String formatedDate(date) {
    var outPutFormat = DateFormat("dd/MM/yyyy  hh:mm  aa");
    var outPutDate = outPutFormat.format(date);
    return outPutDate;
  }

  String formattedNumber(number) {
    var f = NumberFormat("#,##,###");
    String formattedNumber = f.format(number);
    return formattedNumber;
  }

  showAlertDialog(
      BuildContext context, String? title,
    subTitle,
    btn1Text,
    Function()?  onPressedBtn1,
    btn2Text,
    Function()? onPressedBtn2,  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child:   Text(btn1Text??"Cancel"),
      onPressed: onPressedBtn1,
    );
    Widget continueButton = TextButton(
        child: Text(btn2Text ?? "OK"), onPressed: onPressedBtn2);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius10),
       titlePadding: EdgeInsets.only(top: getProportionateScreenHeight(15),bottom:  getProportionateScreenHeight(10)),
      contentPadding: paddingMarginLR20, 
      
      title:   Center(child: Text(title!)),
      content:  
        Text(
          subTitle,
          textAlign: TextAlign.start,
          style: text15DarkGrayFw400,
         
      ),actionsPadding: paddingMarginLR8,
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  scaffold(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: defaultDurationLate,
    ));
  }

  percentageConverter(int soldOutSlots, int totalSlots) {
    double percentageValue = soldOutSlots / totalSlots;
    return percentageValue;
  }

  crossMultiplication(
      double ifThis, double thenThis, double whatIfThis, int? quantity) {
    double value = whatIfThis * thenThis;
    double finalValue = ifThis / value;
    if (quantity == null) quantity = 1;
    return finalValue * quantity;
  }

  ticketsLeft(int soldOutSlots, int totalSlots) {
    int ticketsLeft = totalSlots - soldOutSlots;
    return ticketsLeft;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  showLocalNotification(String? mainTitle, String? subTitle) {
    flutterLocalNotificationsPlugin.show(
        0,
        mainTitle,
        subTitle,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                priority: Priority.high,
                enableLights: true,
                autoCancel: false,
                enableVibration: true,
                importance: Importance.high,
                color: DarkPurple,
                playSound: true,
                channelShowBadge: true,
               // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                icon: '@drawable/ic_stat_foreground_logo')));
  }

  int pickRandomNumber(int min, int max) {
    int randomminmax = min + Random().nextInt(max - min);
    //generate random number within minimum and maximum value
    return randomminmax;
  }


    Future<void> launchMyUrl(url, LaunchMode launchMode) async {
    if (!await launchUrl(Uri.parse(url), mode: launchMode)) {
      throw 'Could not launch $url';
    }
  }
}
