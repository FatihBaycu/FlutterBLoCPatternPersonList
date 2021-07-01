class Kisiler{
  late String kisiId;
  late String kisiAd;
  late String kisiTel;

  Kisiler(this.kisiId, this.kisiAd, this.kisiTel);

  factory Kisiler.fromJson(Map<String,dynamic> json){
    return Kisiler(json["kisi_id"] as String, json["kisi_ad"] as String, json["kisi_tel"] as String);
  }
}

class KisilerCevap{
  late int success;
  late List<Kisiler> kisilerListesi;

  KisilerCevap(this.success,this.kisilerListesi);

  factory KisilerCevap.fromJson(Map<String,dynamic>json){
    var jsonArray=json["kisiler"] as List;
    List<Kisiler> kisilerListesi=jsonArray.map((e) => Kisiler.fromJson(e)).toList();
    return KisilerCevap(json["success"] as int, kisilerListesi);

  }

}