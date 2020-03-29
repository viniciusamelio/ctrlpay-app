// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  final _$avatarAtom = Atom(name: '_ProfileStore.avatar');

  @override
  File get avatar {
    _$avatarAtom.context.enforceReadPolicy(_$avatarAtom);
    _$avatarAtom.reportObserved();
    return super.avatar;
  }

  @override
  set avatar(File value) {
    _$avatarAtom.context.conditionallyRunInAction(() {
      super.avatar = value;
      _$avatarAtom.reportChanged();
    }, _$avatarAtom, name: '${_$avatarAtom.name}_set');
  }

  final _$imagePickerRequestAtom =
      Atom(name: '_ProfileStore.imagePickerRequest');

  @override
  ObservableFuture<File> get imagePickerRequest {
    _$imagePickerRequestAtom.context
        .enforceReadPolicy(_$imagePickerRequestAtom);
    _$imagePickerRequestAtom.reportObserved();
    return super.imagePickerRequest;
  }

  @override
  set imagePickerRequest(ObservableFuture<File> value) {
    _$imagePickerRequestAtom.context.conditionallyRunInAction(() {
      super.imagePickerRequest = value;
      _$imagePickerRequestAtom.reportChanged();
    }, _$imagePickerRequestAtom, name: '${_$imagePickerRequestAtom.name}_set');
  }

  final _$updateRequestAtom = Atom(name: '_ProfileStore.updateRequest');

  @override
  ObservableFuture<UserDto> get updateRequest {
    _$updateRequestAtom.context.enforceReadPolicy(_$updateRequestAtom);
    _$updateRequestAtom.reportObserved();
    return super.updateRequest;
  }

  @override
  set updateRequest(ObservableFuture<UserDto> value) {
    _$updateRequestAtom.context.conditionallyRunInAction(() {
      super.updateRequest = value;
      _$updateRequestAtom.reportChanged();
    }, _$updateRequestAtom, name: '${_$updateRequestAtom.name}_set');
  }

  final _$getAvatarAsyncAction = AsyncAction('getAvatar');

  @override
  Future<void> getAvatar() {
    return _$getAvatarAsyncAction.run(() => super.getAvatar());
  }

  final _$updateAsyncAction = AsyncAction('update');

  @override
  Future<void> update({bool remove = false}) {
    return _$updateAsyncAction.run(() => super.update(remove: remove));
  }

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  void encodeAvatar() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.encodeAvatar();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'avatar: ${avatar.toString()},imagePickerRequest: ${imagePickerRequest.toString()},updateRequest: ${updateRequest.toString()}';
    return '{$string}';
  }
}
