import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../model/post.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  List<PostModel> posts = [];

  final url = 'https://jsonplaceholder.typicode.com/todos';
  @observable
  bool isServiceRequestLoading = false;
  @action
  Future<void> getAllPosts() async {
    changeRequest();
    final response = await Dio().get(url);
    if (response.statusCode == HttpStatus.ok) {
      final reponseData = response.data as List;
      posts = reponseData.map((e) => PostModel.fromMap(e)).toList();
    }

    changeRequest();
  }

  @action
  void changeRequest() {
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}

enum PageState { LOADING, ERROR, SUCCES, NORMAL }
