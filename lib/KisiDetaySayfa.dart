import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sm_bloc_list/Kisiler.dart';
import 'package:flutter_sm_bloc_list/KisilerCubit.dart';
import 'package:flutter_sm_bloc_list/KisilerDaoRepository.dart';
import 'package:flutter_sm_bloc_list/KisilerDurum.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;

  KisiDetaySayfa(this.kisi);

  @override
  _KisiDetaySayfaState createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var kisiAd=TextEditingController();
  var kisiTel=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {

    kisiAd.text=widget.kisi.kisiAd;
    kisiTel.text=widget.kisi.kisiTel;
        super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Detay Sayfa"),),
      body: BlocBuilder<KisilerCubit,KisilerDurum>(
        builder: (context,kisilerDurum){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  buildAd(),
                  SizedBox(height: 20,),
                  buildTel(),
                  buildUpdateButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ElevatedButton buildUpdateButton() {
    return ElevatedButton(onPressed: (){
              if(formKey.currentState!.validate()){
                context.read<KisilerCubit>().kisiGuncelleVeTetikle(widget.kisi).then((value) => Navigator.pop(context));
              }
            }, child: Text("Güncelle"));
  }

  TextFormField buildTel() {
    return TextFormField(
              controller:kisiTel,
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                labelText: "Tel"
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "ad boş geçilemez";
                }
              },
      onChanged: (value){
                widget.kisi.kisiTel=value;
      },
            );
  }

  TextFormField buildAd() {
    return TextFormField(
              controller:kisiAd,
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_box),
                border: OutlineInputBorder(),
                labelText: "Ad"
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "ad boş geçilemez";
                }
              },
      onChanged: (value){
        widget.kisi.kisiAd=value;
      },
            );
  }
}
