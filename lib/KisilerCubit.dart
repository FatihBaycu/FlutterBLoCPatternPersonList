import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sm_bloc_list/Kisiler.dart';
import 'package:flutter_sm_bloc_list/KisilerDaoRepository.dart';
import 'package:flutter_sm_bloc_list/KisilerDurum.dart';


class KisilerCubit extends Cubit<KisilerDurum> {
  KisilerRepository kisilerRepository;
  KisilerCubit(this.kisilerRepository):super(KisilerBaslangicSinifi());


  Future<void> kisileriAlveTetikle() async {
    try{
      emit(KisilerYukleniyor());

      var kisiListeCevap = await kisilerRepository.kisileriGetir();

      emit(KisilerYuklendi(kisiListeCevap));

    }catch(e){
      emit(KisilerHata("Kişiler alınırken hata oluştu"));
    }
  }


  Future<void> kisiSilVeTetikle(int id)async {
    try{
      emit(KisilerYukleniyor());
      await kisilerRepository.kisiSil(id);
      var kisiListeCevap = await kisilerRepository.kisileriGetir();

      emit(KisilerYuklendi(kisiListeCevap));
    }
    catch(e){
      emit(KisilerHata("Kişiler alınırken hata oluştu"));
    }
  }


  Future<void> kisiEkleVeTetikle(String kisiAd,String kisiTel)async{
    try{
      emit(KisilerYukleniyor());
      await kisilerRepository.kisiEkle(kisiAd, kisiTel);
      var kisiListeCevap=await kisilerRepository.kisileriGetir();
      emit(KisilerYuklendi(kisiListeCevap));
    }
    catch(e){
      emit(KisilerHata("hataMesaji"));
    }
  }


  Future<void> kisiGuncelleVeTetikle(Kisiler kisi)async{
    try{
      emit(KisilerYukleniyor());
      await kisilerRepository.kisiGuncelle(kisi);
      var kisiListesi=await kisilerRepository.kisileriGetir();
      emit(KisilerYuklendi(kisiListesi));
    }
    catch(e){
      KisilerHata("hata ${e.toString()}");
    }
  }

}