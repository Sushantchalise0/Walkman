class Vendor {
  Vendor({
    this.vendorIc,
    this.vendorName,
    this.vendorAddress,
    this.longitude,
    this.lattitude,
    this.status,
    this.id,
    this.catId,
    this.v,
  });
  
  String vendorIc;
  String vendorName;
  String vendorAddress;
  String longitude;
  String lattitude;
  bool status;
  String id;
  String catId;
  int v;
  
  
  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    vendorIc: json["vendor_ic"],
    vendorName: json["vendor_name"],
    vendorAddress: json["vendor_address"],
    longitude: json["longitude"],
    lattitude: json["lattitude"],
    status: json["status"],
    id: json["_id"],
    catId: json["cat_id"],
    v: json["__v"],
  );
  

}

class VendorList{
  final List<Vendor> vendors;

  VendorList({this.vendors});
  
  factory VendorList.fromJson(List<dynamic> json){
    List<Vendor> vendors = new List<Vendor>();
    return new VendorList(
      vendors: vendors
    );
  }
}