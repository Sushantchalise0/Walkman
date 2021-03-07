class Walkmandeals {
  String name;
  String img;
  String coins;
  String desc;
  String actprice;
  String discprice;
  bool status;
  String walkmanprice;
  String id;
  String vendorid;
  String ratings;
  int type;

  Walkmandeals({
    this.name,
    this.img,
    this.coins,
    this.desc,
    this.actprice,
    this.discprice,
    this.status,
    this.walkmanprice,
    this.id,
    this.vendorid,
    this.ratings,
    this.type
  });

  factory Walkmandeals.fromJson(Map<String, dynamic> json) => Walkmandeals(
        name: json['name'] ?? '',
        img: json['img'] ?? '',
        coins: json['coins'] ?? '',
        desc: json['desc'] ?? '',
        actprice: json['act_price'] ?? '',
        discprice: json['disc_price'] ?? '',
        status: json['status'],
        walkmanprice: json['walkman_price'] ?? '',
        id: json['_id'] ?? '',
        vendorid: json['vendor_id'] ?? '',
        ratings: json['ratings'] ?? '',
        type: json['type'] ?? 1,
      );
}

class WalkmandealList {
  final List<Walkmandeals> walkmandeals;

  WalkmandealList({this.walkmandeals});

  factory WalkmandealList.fromJson(List<dynamic> json) {
    List<Walkmandeals> walkmandeals = new List<Walkmandeals>();
    return new WalkmandealList(walkmandeals: walkmandeals);
  }
}
