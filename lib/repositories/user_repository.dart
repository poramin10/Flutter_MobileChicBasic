// ignore_for_file: unused_local_variable, await_only_futures, body_might_complete_normally_nullable, avoid_print, prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';
import 'package:project_mobile/models/result.dart';
import 'package:project_mobile/models/user.dart';
import 'package:project_mobile/repositories/base/base_repository.dart';
import 'package:project_mobile/repositories/url/api_url.dart';
import 'package:project_mobile/utils/data_management/map_data_extension.dart';

class UserRepository {
  Future<List<User>?>? getUser() async {
    try {
      print('UserOK');
      var resultList =
          await BaseRepository.baseDio.get(ApiURL.userAPI.user).getList<User>();
      if (resultList!.success == true) {
        print(resultList.data);
        return resultList.data;
      } else {
        print('Error');
        return Future.error(resultList.message ?? 'something went wrong');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> postUser(User user) async {
    print('ได้ $user.firstname');
    var result = await BaseRepository.baseDio
        .post(ApiURL.userAPI.user, data: user)
        .asResult();
    print(ApiURL.userAPI.user);
    if (result.success == true) {
      return true;
    }
    return false;
  }

  Future<Result<dynamic>> postImg(FormData formData) async {
    return await BaseRepository.baseDio
        .post(ApiURL.userAPI.upload, data: formData)
        .asResult();
    
  }

  Future<bool> putUser(User user) async {
    var result = await BaseRepository.baseDio
        .put(ApiURL.userAPI.user, data: user)
        .asResult();
    if (result.success == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser(User user) async {
    print('Delete');
    var result = await BaseRepository.baseDio
        .delete(ApiURL.userAPI.user + '/' + user.id.toString())
        .asResult();
    if (result.success == true) {
      return true;
    } else {
      return false;
    }
  }
}
