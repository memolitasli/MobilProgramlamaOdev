import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MaterialApp(
      title:"odev",
      routes: {
    "/": (context) => anaSayfa(),
  }));
}

class anaSayfa extends StatefulWidget {
  @override
  _anaSayfaState createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {
  List yetenekList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonDosyasiOku().then((value){
      setState(() {
        yetenekList = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(yetenekList.length != null){
      return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              backgroundColor: Colors.grey,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.all(25.0),
                  title: Center(

                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            Center(child: CircleAvatar(backgroundImage: AssetImage("images/cartman.png"),radius: 40,)),

                            Center(child: Text(" Mehmet Taşlı",style: TextStyle(fontSize: 15,color: Colors.white),)),
                            Center(child: Text(" Necmettin Erbakan Üniversitesi \n Bilgisayar Mühendisliği",style: TextStyle(fontSize: 15,color: Colors.white))),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.amber,
                          Colors.purple,
                        ]
                    ),
                  ),
                  height: MediaQuery.of(context).size.height *0.25,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        SingleChildScrollView(
                          child: Text(
                            "Take a look to the sky just before you die "
                                "It's the last time he will "
                                "Blackened roar , massive roar fills the crumbling sky "
                                "shattered goals fill his soul with ruthless cry "
                                "Stranger now are his eyes to this mystery "
                                "Hears the silence so loud "
                                "Crack of dawn , all is gone except the will to be "
                                "Now they see what will be , blinded eyes to see",style: TextStyle(fontSize: 20,color: Colors.black),),
                        )

                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context,index){
                return Card(

                  child: Center(
                    child: ListTile(

                      title: Center(child: Text(yetenekList[index]['name'].toString())),
                      subtitle:  new LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.75,
                      lineHeight: 18.0,
                      percent: yetenekList[index]['ilerleme']/100,
                      backgroundColor: Colors.amber,
                      progressColor: Colors.deepPurple,
                        center: Text("${yetenekList[index]['ilerleme'].toString()}",style: TextStyle(fontSize: 12,color: Colors.white),),
                    ),
                      onTap: (){
                        SimpleDialog(title: Text("${yetenekList[index]['name'].toString()}"),
                        children: [
                          CircularProgressIndicator(
                            value: (yetenekList[index]['ilerleme'] / 100 )+ 0.0,
                          ),
                        ],);
                      },
                    ),
                  ),
                );
              },childCount: yetenekList.length),
            ),
          ]
      );

    }
    else{
      return Scaffold(
        body: CircularProgressIndicator(),
      );
    }

  }
  Future<List> jsonDosyasiOku()async{
    var okunanjson = await DefaultAssetBundle.of(context).loadString("lib/yetenek.json").catchError((e){
      Fluttertoast.showToast(
          msg: "Json Dosyası okunurken bir hata oluştu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
    List donenListe = json.decode(okunanjson.toString());
    return donenListe;
  }
}
