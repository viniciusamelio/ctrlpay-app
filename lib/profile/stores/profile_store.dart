import 'dart:convert';
import 'dart:io';
import 'package:ctrl_money/profile/services/avatar_service.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore extends _ProfileStore with _$ProfileStore {
  ProfileStore(UserRepository userRepository, IImageService avatarService)
      : super(userRepository, avatarService);
}

abstract class _ProfileStore with Store {
  final IUserRepository _userRepository;
  final IImageService _avatarService;
  _ProfileStore(this._userRepository, this._avatarService) {
    userDto = UserDto();
  }

  UserDto userDto;

  @observable
  File avatar;

  @observable
  ObservableFuture<File> imagePickerRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture<UserDto> updateRequest = ObservableFuture.value(null);


  @action
  Future<void> getAvatar() async {
    imagePickerRequest = _avatarService.get(ImageSource.gallery).asObservable();
  }

  @action
  Future<void> update({bool remove = false}) async {
    if (remove == false) encodeAvatar();
    updateRequest = _userRepository.upload(userDto).asObservable();
  }


  @action
  void encodeAvatar() {
    userDto.avatar = base64Encode(avatar.readAsBytesSync());
  }
}
