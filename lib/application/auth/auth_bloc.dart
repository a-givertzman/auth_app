import 'dart:async';

import 'package:auth_app/domain/auth/i_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepositiry _authFacade;
  
  AuthBloc(this._authFacade) : super(const _Initial());

  AuthState initialState = const AuthState.initial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(

      checkSignedIn: (e) async* {
        final userOption =_authFacade.currentUser();
        yield userOption.fold(
          () => const AuthState.unSigned(), 
          (domainUser) => const AuthState.signed()
        );
      },

      signingOut: (e) async* {
        await _authFacade.signOut();
        yield const AuthState.unSigned();
      },
    );
  }
}

// 
// run builder
// flutter pub run build_runner watch --delete-conflicting-outputs
// flutter pub run build_runner build --delete-conflicting-outputs