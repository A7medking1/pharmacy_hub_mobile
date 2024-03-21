import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserInfoEvent>(_getUserInfo);
  }

  FutureOr<void> _getUserInfo(GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(UserInfoState("Ahmed Jihad Attia", "ahmedjihad@gmail.com", "https:\\www.aha.com"));
    // emit(UserInfoState(null, null, null));
  }
}
