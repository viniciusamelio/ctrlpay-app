import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctrl_money/home/stores/home_store.dart';
import 'package:ctrl_money/shared/components/navigation/navigation_block.dart';
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
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
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
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 38,
                      decoration: BoxDecoration(
                          color: Colors.red[400], shape: BoxShape.circle),
                      child: Icon(FontAwesomeIcons.moneyBillWave,
                          size: 20, color: primaryText),
                    ),
                    SizedBox(width: 20),
                    Text("Despesas pendentes",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: primaryText, fontSize: 18))
                  ],
                ),
              ),
              Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("DESPESAS TOTAIS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("R\$0,00",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40)),
                        )
                      ],
                    ),
                  )),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    child: Text(
                      'Revisar',
                      style: TextStyle(color: primaryText, fontSize: 15),
                    ),
                    color: blue,
                    onPressed: () {},
                  ),
                ),
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
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 38,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: Icon(FontAwesomeIcons.moneyBillWave,
                          size: 20, color: primaryText),
                    ),
                    SizedBox(width: 20),
                    Text("Receitas pendentes",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: primaryText, fontSize: 18))
                  ],
                ),
              ),
              Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("RECEITAS TOTAIS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("R\$0,00",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40)),
                        )
                      ],
                    ),
                  )),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    child: Text(
                      'Revisar',
                      style: TextStyle(color: primaryText, fontSize: 15),
                    ),
                    color: blue,
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ];

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
              height: 400,
              enableInfiniteScroll: false,              
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
            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Card(
            //       color: lighter,
            //       elevation: 0,
            //       child: Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: <Widget>[
            //                 Text('Contas',
            //                     style: TextStyle(
            //                         fontSize: 18,
            //                         fontWeight: FontWeight.w700,
            //                         color: primaryText)),
            //                 IconButton(
            //                   color: Colors.green,
            //                   icon: Icon(FontAwesomeIcons.plus),
            //                   onPressed: () {},
            //                 )
            //               ],
            //             ),
            //             Container(
            //               height: 82,
            //               child: ListView(
            //                 reverse: false,
            //                 dragStartBehavior: DragStartBehavior.start,
            //                 physics: BouncingScrollPhysics(),
            //                 children: <Widget>[
            //                   ListTile(
            //                     selected: true,
            //                     leading: Container(
            //                       width: 40,
            //                       decoration: BoxDecoration(
            //                           color: Colors.purple,
            //                           shape: BoxShape.circle),
            //                     ),
            //                     title: Text(
            //                       "Conta 01",
            //                       style: TextStyle(color: primaryText),
            //                     ),
            //                     subtitle: Text('Conta corrente',
            //                         style: TextStyle(color: secondaryText)),
            //                     trailing: Text('R\$ 1.000,00',
            //                         style:
            //                             TextStyle(color: blue, fontSize: 16)),
            //                   ),
            //                   ListTile(
            //                     title: Text("Conta 02"),
            //                   )
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       )
            //       ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            NavigationBlock(
                icon: Icon(FontAwesomeIcons.home, color: primaryText),
                title: 'Início'),
            NavigationBlock(
                icon: Icon(FontAwesomeIcons.exchangeAlt, color: primaryText),
                title: 'Transações'),
            NavigationBlock(
                icon: Icon(FontAwesomeIcons.wallet, color: primaryText),
                title: 'Carteira'),
            NavigationBlock(
                icon: Icon(FontAwesomeIcons.bullseye, color: primaryText),
                title: 'Objetivos'),
            NavigationBlock(
                icon: Icon(FontAwesomeIcons.chartBar, color: primaryText),
                title: 'Relatórios'),
            NavigationBlock(
                icon: Icon(FontAwesomeIcons.solidUser, color: primaryText),
                title: 'Perfil'),
          ],
          primary: true,
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
        ),
      ),
    );
  }
}
