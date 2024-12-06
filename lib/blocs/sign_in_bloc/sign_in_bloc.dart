import 'package:authblocproject/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc({required UserRepository userRepository}) : _userRepository = userRepository,
    super(SignInInitial()) {
    on<SignInRequired>((event, emit) async{
      emit(SignInLoading());
      try{
        await _userRepository.signIn(event.email, event.passWord);
        emit(SignInSuccess());
      }on FirebaseAuthException catch (e){
        emit(SignInFailure(message: e.code));
      } catch (e){
        emit(SignInFailure());
      }
      
    });
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}
