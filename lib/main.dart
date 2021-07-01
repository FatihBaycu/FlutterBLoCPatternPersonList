import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sm_bloc_list/KisiDetaySayfa.dart';
import 'package:flutter_sm_bloc_list/KisiKayitSayfa.dart';
import 'package:flutter_sm_bloc_list/Kisiler.dart';
import 'package:flutter_sm_bloc_list/KisilerCubit.dart';
import 'package:flutter_sm_bloc_list/KisilerDaoRepository.dart';
import 'package:flutter_sm_bloc_list/KisilerDurum.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              KisilerCubit(KisilerDaoRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<KisilerCubit>().kisileriAlveTetikle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişiler"),
      ),
      body: buildBlocBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => KisiKayitSayfa()));
        },
      ),
    );
  }

  BlocBuilder<KisilerCubit, KisilerDurum> buildBlocBuilder() {
    return BlocBuilder<KisilerCubit, KisilerDurum>(
      builder: (context, kisilerDurum) {
        if (kisilerDurum is KisilerYuklendi) {
          var kisiListesi = kisilerDurum.kisiListesi;
          return ListView.builder(
              itemCount: kisiListesi.length,
              itemBuilder: (context, index) {
                var kisi = kisiListesi[index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 50,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: buildKisiId(context, kisi),
                            ),
                            Expanded(
                              child: buildKisiAd(context, kisi),
                            ),
                            Expanded(
                              child: buildKisiTel(context, kisi),
                            ),
                            Expanded(child: buildDeleteButton(context, kisi)),
                            Expanded(child: IconButton(icon: Icon(Icons.update,color: Colors.orange,),onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>KisiDetaySayfa(kisi)));
                            },))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center();
        }
      },
    );
  }

  Future<void> showMyDialog(Kisiler kisi) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Silme İşlemi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Silmek İstiyormusunuz!.',style: TextStyle(color: Colors.red),),
              ],
            ),
          ),
          actions: <Widget>[
           TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Evet',style: TextStyle(color: Colors.red),),
              onPressed: () {
                context.read<KisilerCubit>().kisiSilVeTetikle(int.parse(kisi.kisiId)).then((value) => Navigator.pop(context));
              },
            ),
          ],
        );
      },
    );
  }

  IconButton buildDeleteButton(BuildContext context, Kisiler kisi) {
    return IconButton(
      onPressed: () {
        showMyDialog(kisi);
      },
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }

  RichText buildKisiTel(BuildContext context, Kisiler kisi) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
              text: "Kişi TEL:\n",
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text: kisi.kisiTel,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  RichText buildKisiAd(BuildContext context, Kisiler kisi) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
              text: "Kişi AD:\n",
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text: kisi.kisiAd, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  RichText buildKisiId(BuildContext context, Kisiler kisi) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
              text: "Kişi Id:\n",
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text: kisi.kisiId, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
