import 'package:bloc/bloc.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_intent.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  @factoryMethod
  AuthCubit() : super(AuthInitial());

  void doIntent(AuthIntent intent) {}
}
