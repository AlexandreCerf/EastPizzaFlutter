class Discount {
  final String id;
  final String rule;
  final String code;
  final DateTime start;
  final DateTime end;

  Discount(
      {required this.code,
      required this.end,
      required this.start,
      required this.rule,
      required this.id});

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        rule: json["rule"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        code: json["code"],
      );
}