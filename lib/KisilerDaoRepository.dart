import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_sm_bloc_list/Kisiler.dart';

abstract class KisilerRepository{
  Future<List<Kisiler>> kisileriGetir();
  Future<void> kisiSil(int id);
  Future<void> kisiEkle(String kisiAd,String kisiTel);
  Future<void> kisiGuncelle(Kisiler kisi);

}

class KisilerDaoRepository implements KisilerRepository{

 List<Kisiler> parseKisilerCevap(String cevap) {
    return KisilerCevap.fromJson(json.decode(cevap)).kisilerListesi;
  }



  @override
  Future<List<Kisiler>> kisileriGetir() async{

    // var kisilerListesi=<Kisiler>[];
    //
    // var k1=Kisiler("1", "Fatih", "0456 972 13 97");
    // var k2=Kisiler("1", "Umut", "0132 654 98 78");
    //
    // kisilerListesi.add(k1);
    // kisilerListesi.add(k2);
    // return kisilerListesi;

    var url=Uri.parse("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php");
    var cevap=await http.get(url);
    return parseKisilerCevap(cevap.body);
  }

  @override
  Future<void> kisiSil(int id)async {
    var url=Uri.parse("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php");
    var veri= {"kisi_id":id.toString()};
    var cevap=await http.post(url,body: veri);
    print("Silme Cevap: ${cevap.body}");

  }

  @override
  Future<void> kisiEkle(String kisiAd, String kisiTel)async{
    var url=Uri.parse("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php");
    var veri={"kisi_ad":kisiAd,"kisi_tel":kisiTel};
    var cevap=await http.post(url,body: veri);
    print("Ekleme Cevap:${cevap.body}");
  }

  @override
  Future<void> kisiGuncelle(Kisiler kisi)async{
    var url=Uri.parse("http://kasimadalan.pe.hu/kisiler/update_kisiler.php");
    var veri={"kisi_id":kisi.kisiId,"kisi_ad":kisi.kisiAd,"kisi_tel":kisi.kisiTel};
    var cevap=await http.post(url,body: veri);
    print("Güncelleme Cevap: ${cevap.body}");
  }
}