part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitialState extends AuthState {
  const AuthInitialState();
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

final class AuthFailedState extends AuthState {
  const AuthFailedState();
}

final class AuthLogInState extends AuthState {
  final SystemUser user;

  const AuthLogInState({required this.user});

  @override
  List<Object?> get props => [user];
}
