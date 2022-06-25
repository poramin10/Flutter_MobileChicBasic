// ignore_for_file: avoid_print

import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/repositories/url/api_url.dart';
import 'package:project_mobile/utils/data_management/map_data_extension.dart';

import 'base/base_repository.dart';

class BranchRepository {
  ///นี่คือตัวอย่างการทดสอบ request api

  Future<List<Branch>?>? getBranch() async {
    try {
      print('ok');
      var resultList = await BaseRepository.baseDio
          .get(ApiURL.branchAPI.branch)
          .getList<Branch>();
      if (resultList!.success == true) {
       
        return resultList.data;
      } else {
        return Future.error(resultList.message ?? 'something went wrong');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> postBranch(Branch branch) async {
    var result = await BaseRepository.baseDio
        .post(ApiURL.branchAPI.branch, data: branch)
        .asResult();
    if(result.success == true){
      return true;
    }
    return false;
  }

  Future<Branch?>? deleteBranch(Branch branch) async {
    var result = await BaseRepository.baseDio
        .delete(ApiURL.branchAPI.branch, data: branch)
        .asResult();
    if(result.success == true){
      return result.data;
    }
    return null;
  }
}
