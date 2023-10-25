part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  List<PostApi> postList;

  PostLoaded({required this.postList});
}
