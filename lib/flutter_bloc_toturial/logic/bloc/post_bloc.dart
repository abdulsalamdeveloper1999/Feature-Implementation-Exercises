import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_api/post_api.dart';
import '../../repository/bloc_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostFetchEvent>(getApi);
  }

  FutureOr<void> getApi(PostFetchEvent event, Emitter<PostState> emit) async {
    List<PostApi> getApis = await BlocRepo.getApi();
    emit(PostLoaded(postList: getApis));
  }
}
