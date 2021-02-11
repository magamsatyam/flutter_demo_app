import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo_app/model/user_model.dart';
import 'package:flutter_demo_app/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part '../../bloc/auth/auth_event.dart';
part 'auth_state.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnintialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AppStarted) {

      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

      await userRepository.persistToken(
          user: event.user
      );
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userRepository.deleteToken(id: 0);

      yield AuthenticationUnauthenticated();
    }
  }
}