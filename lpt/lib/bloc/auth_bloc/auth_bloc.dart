import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lpt/model/system_user.dart';
import 'package:lpt/repository/facebook_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FacebookRepository facebookRepository;

  AuthBloc({required this.facebookRepository})
    : super(const AuthInitialState()) {
    on<LoginEvent>(_onLogIn);
  }

  Future<void> _onLogIn(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoadingState());
    final user = await facebookRepository.signIn();
    if (user != null) {
      emit(AuthLogInState(user: user));
      return;
    }
    emit(const AuthFailedState());
  }
}
