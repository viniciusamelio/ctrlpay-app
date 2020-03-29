import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctrl_money/home/repositories/home_repository.dart';
import 'package:ctrl_money/home/stores/home_store.dart';
import 'package:ctrl_money/shared/components/navigation/navigation_block.dart';
import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:ctrl_money/shared/services/auth_service.dart';
import 'package:ctrl_money/shared/stores/user_store.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/shared/utils/masks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore _homeStore;
  UserStore _userStore;
  User _user;
  List<Widget> _accountsList;
  @override
  void initState() {
    _userStore = UserStore(UserRepository(CustomDio()), AuthStorage());
    _user = User.instance;
    _homeStore = HomeStore(HomeReposiory(CustomDio()));
    reaction((_) => _userStore.logoutRequest.status, (_) {
      FutureStatus status = _userStore.logoutRequest.status;
      if (status == FutureStatus.fulfilled) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/login'));
      }
    });

    reaction((_) => _homeStore.pendingRequest.status, (_) {
      FutureStatus status = _homeStore.pendingRequest.status;
      if (status == FutureStatus.fulfilled) {
        final value = _homeStore.pendingRequest.value;
        if (value != null) {
          if (value.length > 0) {
            bool hasPendingEarnings =
                value.where((e) => e.idTransactionType == 2).isNotEmpty;
            bool hasPendingExpenses =
                value.where((e) => e.idTransactionType == 1).isNotEmpty;
            if (hasPendingEarnings) {
              _homeStore.pendingEarnings = value
                  .where((e) => e.idTransactionType == 2)
                  .toList()[0]
                  .amount;
            }
            if (hasPendingExpenses) {
              _homeStore.pendingExpenses = value
                  .where((e) => e.idTransactionType == 1)
                  .toList()[0]
                  .amount;
            }
          }
        }
      }
    });
    super.initState();

    when((_) => _userStore.currentUserRequest.value != null, () {
      if (_userStore.currentUserRequest.status == FutureStatus.fulfilled &&
          _userStore.currentUserRequest.value != null) {
        _userStore.user =
            UserDto.fromJson(jsonDecode(_userStore.currentUserRequest.value));
        _user.data = _userStore.user;
        _homeStore.getPending(_user.data.id);
      }
    });
  }

  @override
  void didChangeDependencies() {
    if (_user.data.id != null) {
      _userStore.get(_user.data.id);
    }else{
       _homeStore.getPending(_user.data.id);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    User.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _homeStore = Provider.of<HomeStore>(context);
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
                          child: Observer(builder: (_) {
                            if (_homeStore.pendingRequest.status !=
                                FutureStatus.pending) {
                              return Text(
                                  "${moneyMask(_homeStore.pendingExpenses)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.w900,
                                      fontSize: 40));
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.red[600],
                              )),
                            );
                          }),
                        )
                      ],
                    ),
                  )),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Observer(builder: (_) {
                    if (_homeStore.pendingExpenses != 0) {
                      return FlatButton(
                        child: Text(
                          'Revisar',
                          style: TextStyle(color: primaryText, fontSize: 15),
                        ),
                        color: blue,
                        onPressed: () => Navigator.pushNamed(
                            context, '/transaction/pending',
                            arguments: _user.data.id),
                      );
                    }
                    return Container();
                  }),
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
                          child: Observer(builder: (_) {
                            if (_homeStore.pendingRequest.status !=
                                FutureStatus.pending) {
                              return Text(
                                  "${moneyMask(_homeStore.pendingEarnings)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 40));
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.green,
                              )),
                            );
                          }),
                        )
                      ],
                    ),
                  )),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Observer(builder: (_) {
                    if (_homeStore.pendingEarnings != 0) {
                      return FlatButton(
                        child: Text(
                          'Revisar',
                          style: TextStyle(color: primaryText, fontSize: 15),
                        ),
                        color: blue,
                        onPressed: () => Navigator.pushNamed(
                            context, '/transaction/pending',
                            arguments: _user.data.id),
                      );
                    }
                    return Container();
                  }),
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
                      SizedBox(height: 20),
                      Observer(
                        builder: (_) {
                          return _userStore.currentUserRequest.status ==
                                  FutureStatus.fulfilled
                              ? Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed('/profile'),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: _user.data.avatar != null
                                            ? ClipOval(
                                                child: Image.memory(
                                                    base64Decode(
                                                        _user.data.avatar),
                                                    fit: BoxFit.fill),
                                              )
                                            : Icon(
                                                FontAwesomeIcons.solidUser,
                                                color: secondaryBlue,
                                              ),
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "Bem vindo(a),\n",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: secondaryText)),
                                      TextSpan(
                                          text:
                                              "${_user.data.name.split(' ')[0]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: blue,
                                              fontFamily:
                                                  GoogleFonts.fredokaOne()
                                                      .fontFamily))
                                    ])),
                                  ],
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor: blue),
                                );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('R\$',
                              style: TextStyle(
                                  color: secondaryText, fontSize: 18)),
                          Observer(builder: (_) {
                            if (_homeStore.pendingRequest.status ==
                                FutureStatus.fulfilled) {
                              if (_homeStore.visibleTotalAmount) {
                                return Text(
                                  '${moneyMask(_user.data.totalAmount) ?? '0,00'}',
                                  style: TextStyle(
                                      color: primaryText,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                );
                              }
                              return Container(
                                height: 5,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                              );
                            }
                            return CircularProgressIndicator(
                              backgroundColor: blue,
                            );
                          }),
                          Observer(builder: (_) {
                            return IconButton(
                              icon: !_homeStore.visibleTotalAmount ? Icon(FontAwesomeIcons.eye) : Icon(FontAwesomeIcons.eyeSlash),
                              color: secondaryText,
                              onPressed: () => _homeStore.visibleTotalAmount = !_homeStore.visibleTotalAmount,
                            );
                          })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Saldo total',
                              style:
                                  TextStyle(color: secondaryText, fontSize: 18))
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
                action: () => Navigator.pushNamed(context, '/transaction',
                    arguments: _user.data.id),
                icon: Icon(FontAwesomeIcons.exchangeAlt, color: primaryText),
                title: 'Transações'),
            NavigationBlock(
                action: () => Navigator.pushNamed(context, '/account'),
                icon: Icon(FontAwesomeIcons.wallet, color: primaryText),
                title: 'Carteira'),
            NavigationBlock(
                action:() => Navigator.pushNamed(context, '/report')  ,
                icon: Icon(FontAwesomeIcons.chartBar, color: primaryText),
                title: 'Relatório'),
            NavigationBlock(
                action: () => Navigator.pushNamed(context, '/profile'),
                icon: Icon(FontAwesomeIcons.solidUser, color: primaryText),
                title: 'Perfil'),
            NavigationBlock(
                action: () async {
                  await _userStore.logout();
                  User.dispose();
                },
                icon: Icon(FontAwesomeIcons.doorOpen, color: primaryText),
                title: 'Sair')
          ],
          primary: true,
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
        ),
      ),
    );
  }
}
