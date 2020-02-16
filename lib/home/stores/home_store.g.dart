// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$slideIndexAtom = Atom(name: '_HomeStore.slideIndex');

  @override
  int get slideIndex {
    _$slideIndexAtom.context.enforceReadPolicy(_$slideIndexAtom);
    _$slideIndexAtom.reportObserved();
    return super.slideIndex;
  }

  @override
  set slideIndex(int value) {
    _$slideIndexAtom.context.conditionallyRunInAction(() {
      super.slideIndex = value;
      _$slideIndexAtom.reportChanged();
    }, _$slideIndexAtom, name: '${_$slideIndexAtom.name}_set');
  }
}
