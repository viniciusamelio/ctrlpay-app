abstract class IStorageService{
  Future save({String key, dynamic value});
  Future clear({String key, dynamic value});
  Future read({String key, dynamic value});
  Future clearAll();
}