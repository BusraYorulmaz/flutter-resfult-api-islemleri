import 'package:dio/dio.dart';
import '../model/user_model.dart';

class UserService {
  final dio = Dio();

  //get ile veri çekme işlemi
  Future<UsersModel?> fetch() async {
    const String url = "https://reqres.in/api/users?page=2";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        // 200 başarılı istek sonucunda dönen kod
        // burda istek başarılıdır, değer return edeceğiz.
        var jsonBody = UsersModel.fromJson(response.data);
        return jsonBody;
      } else {
        // istek başarasız oldu ve veri null döndü
        return null;
      }
    } catch (e) {
      print("Alınan hata: $e");
      return null;
    }
  }

// post ile veri gönderme işlemi
  Future<bool?> postIslemi() async {
    const String url = "https://reqres.in/api/users";
    try {
      final response = await dio.post(url);
      if (response.statusCode == 201) {
        // 201 başarılı istek sonucunda dönen kod
        // burda istek başarılıdır, değer return edeceğiz.
        print(response.data);
        return true;
      } else {
        // istek başarasız oldu ve veri null döndü
        return false;
      }
    } catch (e) {
      print("Alınan hata: $e");
      return null;
    }
  }
}
