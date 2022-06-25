// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/repositories/branch_repository.dart';

import 'package:project_mobile/shared_widgets/navigator_widget.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

import 'data.dart';

class ApiListView extends StatefulWidget {
  ApiListView({Key? key}) : super(key: key);

  @override
  State<ApiListView> createState() => _ApiListViewState();
}

class _ApiListViewState extends State<ApiListView> {
  final _branchRepository = BranchRepository();
  Future <List<Branch>?>? branchList ;
  @override
  void initState() {
    branchList = _branchRepository.getBranch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ApiListView')),
      body: FutureBuilder(
          future: branchList,
          builder: (context, AsyncSnapshot databranch) {
            return databranch.connectionState != ConnectionState.done
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: databranch.hasData ? databranch.data?.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('${databranch.data[index].namebranch}'),
                      );
                    });
          }),
      drawer: Navigation(),
    );
  }
}
