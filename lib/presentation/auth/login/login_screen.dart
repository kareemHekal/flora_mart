import 'package:flora_mart/core/cache/shared_pref.dart';
import 'package:flora_mart/core/resuable_comp/custom_text_field.dart';
import 'package:flora_mart/core/resuable_comp/text_button.dart';
import 'package:flora_mart/core/resuable_comp/toast_message.dart';
import 'package:flora_mart/core/resuable_comp/validator.dart';
import 'package:flora_mart/core/utils/colors_manager.dart';
import 'package:flora_mart/core/utils/config.dart';
import 'package:flora_mart/core/utils/routes_manager.dart';
import 'package:flora_mart/core/utils/string_manager.dart';
import 'package:flora_mart/presentation/auth/login/cubit/Login_cubit.dart';
import 'package:flora_mart/presentation/auth/login/cubit/Login_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().doIntent(
            SignInIntent(
              rememberMe: isChecked,
              email: emailController.text,
              password: passwordController.text,
              // Use the checkbox value
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    setTokenNull();
  }

  void setTokenNull() async {
    await CacheHelper.removeData(CacheHelper.tokenKey);
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, RouteManager.homeScreen);
          toastMessage(
              message: AppStrings.loginSuccessfully,
              tybeMessage: TybeMessage.positive);
        }
        if (state is LoginErrorState) {
          toastMessage(
              message: state.message.toString(),
              tybeMessage: TybeMessage.negative);
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.login,
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                spacing: 10.h,
                children: [
                  CustomTextField(
                      labelText: AppStrings.email,
                      hintText: AppStrings.enterYourEmail,
                      obscureText: false,
                      controller: emailController,
                      keyboard: TextInputType.emailAddress,
                      validator: Validator.email),
                  SizedBox(
                    height: 4.h,
                  ),
                  CustomTextField(
                      labelText: AppStrings.password,
                      hintText: AppStrings.enterPassword,
                      controller: passwordController,
                      keyboard: TextInputType.visiblePassword,
                      validator: Validator.password,
                      obscureText: true),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                              return isChecked
                                  ? ColorManager.primaryColor
                                  : ColorManager.white;
                            }),
                            checkColor: isChecked
                                ? ColorManager.white
                                : ColorManager.primaryColor,
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue ?? false;
                              });
                            },
                          ),

                          SizedBox(width: 2.w),
                          // إضافة مسافة صغيرة بين المربع والنص
                          Text(
                            AppStrings.rememberMe,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, RouteManager.forgetPassScreen);
                          },
                          child: Text(
                            AppStrings.forgetpassword,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0),
                          ))
                    ],
                  ),
                  CustomTextButton(
                    borderColor: ColorManager.primaryColor,
                    text: AppStrings.login,
                    color: ColorManager.primaryColor,
                    textColor: ColorManager.white,
                    onPressed: () {
                      _validateAndLogin(context);
                    },
                  ),
                  CustomTextButton(
                    borderColor: ColorManager.grey,
                    text: AppStrings.countinueAsGuest,
                    color: ColorManager.white,
                    textColor: ColorManager.grey,
                    onPressed: () {
                      _validateAndLogin(context);
                    },
                  ),
                  CustomTextButton(
                    borderColor: ColorManager.red,
                    text: AppStrings.countinueAsGuest,
                    color: ColorManager.white,
                    textColor: ColorManager.grey,
                    onPressed: () {
                      bool? rememberMe =
                          CacheHelper.getData<bool>(CacheHelper.isRememberMe);
                      print("$rememberMe ");
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, RouteManager.signUpscreen);
                          },
                          child: Text(
                            AppStrings.signUp,
                            style: TextStyle(
                                decorationColor: ColorManager.primaryColor,
                                color: ColorManager.primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
