import 'package:bloc/bloc.dart';
import 'package:flora_mart/domain/entity/auth/auth_response_entity.dart';
import 'package:flora_mart/domain/usecase/register_usecase.dart';
import 'package:flora_mart/presentation/auth/register/intent/register_intent.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'register_view_model_state.dart';

@injectable
class RegisterViewModelCubit extends Cubit<RegisterViewModelState> {
  final RegisterUsecase registerUsecase;

  RegisterViewModelCubit(this.registerUsecase)
      : super(RegisterViewModelInitial());

  void onIntent(RegisterIntent intent) async {
    if (intent is RegisterUserIntent) {
      emit(RegisterViewModelLoading());

      final result = await registerUsecase(
        firstName: intent.firstName,
        lastName: intent.lastName,
        email: intent.email,
        password: intent.password,
        rePassword: intent.rePassword,
        phone: intent.phone,
        gender: intent.gender,
      );

      result.fold(
        (failureMessage) => emit(RegisterViewModelFailure(failureMessage)),
        (response) => emit(RegisterViewModelSuccess(response)),
      );
    }
  }
}
