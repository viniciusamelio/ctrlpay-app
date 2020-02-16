import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctrl_money/home/stores/home_store.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore _homeStore;

  List<Widget> _accountsList;

  @override
  void initState() {
    _homeStore = HomeStore();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _accountsList = <Widget>[
      Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          color: lighter,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.red[400], shape: BoxShape.circle),
                child: Icon(FontAwesomeIcons.moneyBillWave,
                    size: 13, color: primaryText),
              ),
              SizedBox(height: 10),
              Text("Você tem N contas a pagar\nno total de R\$ 900,00",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryText, fontSize: 16)),
              SizedBox(height: 10),
              FlatButton(
                child: Text(
                  'Revisar',
                  style: TextStyle(color: primaryText),
                ),
                color: blue,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          color: lighter,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8),
              Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: Icon(FontAwesomeIcons.moneyBillWave,
                    size: 13, color: primaryText),
              ),
              SizedBox(height: 10),
              Text("Você tem N contas a receber\nno total de R\$ 900,00",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryText, fontSize: 16)),
              SizedBox(height: 10),
              FlatButton(
                child: Text(
                  'Revisar',
                  style: TextStyle(color: primaryText),
                ),
                color: blue,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(0),
              elevation: 0.2,
                color: lighter,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('R\$',
                              style: TextStyle(
                                  color: secondaryText, fontSize: 18)),
                          Text('2.000,00',
                              style: TextStyle(
                                  color: primaryText,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800)),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.solidEye),
                            color: secondaryText,
                            onPressed: () {},
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Saldo total',
                              style:
                                  TextStyle(color: secondaryText, fontSize: 16))
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(height: 10),
            CarouselSlider(
              height: 220,
              realPage: 2,
              viewportFraction: 1.0,
              autoPlay: false,
              items: _accountsList,
              initialPage: 0,
              onPageChanged: (i) {
                _homeStore.slideIndex = i;
              },
            ),
            Observer(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _homeStore.slideIndex == 0
                              ? primaryText
                              : secondaryText),
                    ),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _homeStore.slideIndex == 1
                              ? primaryText
                              : secondaryText),
                    )
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                  color: lighter,
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Contas',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: primaryText)),
                            IconButton(                              
                              color: Colors.green,
                              icon: Icon(FontAwesomeIcons.plus),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Container(
                          height: 82,
                          child: ListView(                            
                            reverse: false,
                            dragStartBehavior: DragStartBehavior.start,
                            physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            ListTile(
                              selected: true,
                              leading: Container(
                               width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle
                                ),
                              ),
                              title: Text("Conta 01", style: TextStyle(color: primaryText),),
                              subtitle: Text('Conta corrente',  style: TextStyle(color: secondaryText)),
                              trailing: Text('R\$ 1.000,00', style: TextStyle(color: blue,fontSize: 16)),
                            ),
                            ListTile(
                              title: Text("Conta 02"),
                            )
                          ],
                        ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView(
          physics: BouncingScrollPhysics(), 
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              width: 80,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25,),
                  Padding(padding: EdgeInsets.only(right:2),child: Icon(FontAwesomeIcons.home, color: primaryText)),
                  SizedBox(height: 5),
                  Text('Início', style: TextStyle(color: primaryText))
                ],
              ),
              decoration: BoxDecoration(
                  color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              margin: EdgeInsets.all(8),
              width: 80,
              decoration: BoxDecoration(
                  color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              margin: EdgeInsets.all(8),
              width: 80,
              decoration: BoxDecoration(
                  color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              margin: EdgeInsets.all(8),
              width: 80,
              decoration: BoxDecoration(
                  color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              margin: EdgeInsets.all(8),
              width: 80,
              decoration: BoxDecoration(
                  color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
            ),
          ],
          primary: true,
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,          
        ),
      ),
    );
  }
}
