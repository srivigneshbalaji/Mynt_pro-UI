class MyWatchList {
  final String exch;
  final String token;
  final String tsym;
  final String userEmail;
  final String pp;
  final String ls;
  final String ti;
  final String instname;

  bool verifiedValue = false;
  bool approvedValue = false;
  bool securityApprovedValue = false;
  bool blockedValue = false;

  MyWatchList({
    required this.exch,
    required this.token,
    required this.tsym,
    required this.userEmail,
    required this.pp,
    required this.ls,
    required this.ti,
    required this.instname,
  });

  factory MyWatchList.fromJson(Map<String, dynamic> json) {
    return MyWatchList(
      exch: json["exch"],
      token: json["token"],
      tsym: json["tsym"],
      userEmail: json["email"],
      pp: json["pp"],
      ls: json["ls"],
      ti: json["ti"],
      instname: json["instname"],
    );
  }
}
