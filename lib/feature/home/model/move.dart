class Move {
  int? move;
  String? sign;
  String? userName;

  Move({this.move, this.sign, this.userName});

  Move.fromJson(Map<String, dynamic> json) {
    move = json['move'];
    sign = json['sign'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['move'] = this.move;
    data['sign'] = this.sign;
    data['userName'] = this.userName;
    return data;
  }
}
