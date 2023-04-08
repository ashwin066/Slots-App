import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class TicketsCombo {
  TicketsCombo( {
  this.combo_name,
    this.value_type,
    this.price,
    this.regular_price,
    this.tickets, 
  });

  TicketsCombo.fromJson(Map<String, Object?> json)
      : this(
          combo_name: json['combo_name']! as String,
          value_type: json['value_type']! as String,
          price: json['price'] == null ? null : json['price']! as int,
          regular_price: json['regular_price'] == null ? null : json['regular_price']! as int,
              tickets:
              json['tickets'] == null ? null : json['tickets']! as int,
          
        );

  final String? combo_name;
  final String? value_type;
  final int? price;
  final int? regular_price;
  final int? tickets;

  Map<String, Object?> toJson() {
    return {
      "combo_name": combo_name,
      "value_type": value_type,
      "price": price,
      "regular_price": regular_price,
      "tickets": tickets,
      
    };
  }
}

 
 
ticketsComboQuery(bool approved ) {
  return FirebaseFirestore.instance
      .collection('tickets_combo')
      .where('approved', isEqualTo: approved)
       
      .withConverter<TicketsCombo>(
        fromFirestore: (snapshot, _) =>
            TicketsCombo.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}

 
