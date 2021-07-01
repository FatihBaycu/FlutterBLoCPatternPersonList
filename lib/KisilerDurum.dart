import 'Kisiler.dart';

abstract class KisilerDurum{
  KisilerDurum();
}


class KisilerBaslangicSinifi extends KisilerDurum{
  KisilerBaslangicSinifi();
}

class KisilerYukleniyor extends KisilerDurum{
  KisilerYukleniyor();
}

class KisilerYuklendi extends KisilerDurum{
  List<Kisiler> kisiListesi;
  KisilerYuklendi(this.kisiListesi);
}

class KisilerHata extends KisilerDurum{
  String hataMesaji;
  KisilerHata(this.hataMesaji);
}
