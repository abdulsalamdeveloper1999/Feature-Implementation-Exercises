import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorials_project/flutter_bloc_toturial/logic/bloc/post_bloc.dart';

class PostapiScreen extends StatelessWidget {
  const PostapiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postBloc = PostBloc();
    postBloc.add(PostFetchEvent());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Post Api'),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          bloc: postBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PostInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.postList.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = state.postList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(data.title!),
                      subtitle: Text(data.body!),
                      trailing: Text(data.id!.toString()),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
