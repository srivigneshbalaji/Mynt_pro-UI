import 'dart:convert';

OrderAcknowledgementStream orderAcknowledgementStreamFromJson(String str) =>
    OrderAcknowledgementStream.fromJson(
        json.decode(str) as Map<String, dynamic>);

String orderAcknowledgementStreamToJson(OrderAcknowledgementStream data) =>
    json.encode(data.toJson());

class OrderAcknowledgementStream {
  OrderAcknowledgementStream({
    this.t,
  });

  String? t;

  factory OrderAcknowledgementStream.fromJson(Map<String, dynamic> json) =>
      OrderAcknowledgementStream(
        t: json["t"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "t": t,
      };
}
