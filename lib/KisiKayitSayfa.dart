import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sm_bloc_list/Kisiler.dart';
import 'package:flutter_sm_bloc_list/KisilerCubit.dart';

import 'KisilerDurum.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({Key? key}) : super(key: key);

  @override
  _KisiKayitSayfaState createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {

  Kisiler kisi=new Kisiler("", "", "");
  var kisiAd=TextEditingController();
  var kisiTel=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Kişi Kayıt"),),
      body:BlocBuilder<KisilerCubit,KisilerDurum>(
         builder: (context,kisilerDurum){
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Form(
               key: formKey,
               child: Column(
                 children: [
                   TextFormField(
                     controller: kisiAd,
                     autovalidateMode:AutovalidateMode.always,
                     decoration:InputDecoration(
                         border: OutlineInputBorder(),
                         prefixIcon: Icon(Icons.account_box),
                         labelText: "Ad"),
                     validator: (value){
                       if(value!.isEmpty){
                         return "İsim boş olamaz.";
                       }
                     },
                   ),
                   SizedBox(height: 20,),
                   TextFormField(
                     controller: kisiTel,
                     autovalidateMode:AutovalidateMode.always,
                     decoration:InputDecoration(
                         border: OutlineInputBorder(),
                         prefixIcon: Icon(Icons.account_box),
                         labelText: "Tel"),
                     validator: (value){
                       if(value!.isEmpty){
                         return "Telefon boş olamaz.";
                       }
                     },
                   ),
                   ElevatedButton(onPressed: (){
                     if(formKey.currentState!.validate()){
                      context.read<KisilerCubit>().kisiEkleVeTetikle(kisiAd.text, kisiTel.text).then((value) {
                        Navigator.pop(context);
                      });
                     }
                   }, child: Text("Kayıt Et"))
                 ],
               ),
             ),
           );
         },

      ) ,
    );
  }
}
