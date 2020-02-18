abstract class IStorageService{
  Future save({String key, dynamic value});
  Future clear({String key});
  Future read({String key});
  Future clearAll();
}