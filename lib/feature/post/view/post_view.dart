import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../view-model/post_view_model.dart';

class PostView extends StatelessWidget {
  final _viewModel = PostViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _viewModel.getAllPosts();
          },
        ),
        body: Center(
          child: Observer(builder: (_) {
            return listViewBuilder();
          }),
        ));
  }

  ListView listViewBuilder() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: _viewModel.posts.length,
      itemBuilder: (context, index) => cardList(index),
    );
  }

  ListTile cardList(int index) {
    return ListTile(
        title: Text(_viewModel.posts[index].title as String),
        subtitle: Text(_viewModel.posts[index].completed.toString()),
        trailing: Text((_viewModel.posts[index].userId).toString() as String));
  }

  AppBar buildAppBar() => AppBar(
        title: Text('ogz'),
        leading: Observer(builder: (_) {
          return Visibility(
              visible: _viewModel.isServiceRequestLoading,
              child: CircularProgressIndicator(color: Colors.white));
        }),
      );
}
