import 'package:flora_mart/config/theme/app_theme.dart';
import 'package:flora_mart/core/constant.dart';
import 'package:flora_mart/core/di/di.dart';
import 'package:flora_mart/core/resuable_comp/app_bar.dart';
import 'package:flora_mart/core/resuable_comp/custom_text_field.dart';
import 'package:flora_mart/core/resuable_comp/text_button.dart';
import 'package:flora_mart/core/utils/colors_manager.dart';
import 'package:flora_mart/presentation/auth/register/intent/register_intent.dart';
import 'package:flora_mart/presentation/auth/register/view_model/register_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  String? selectedGender;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterViewModelCubit>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarWidget(
                    onpressed: () => Navigator.pop(context),
                    title: "Sign Up",
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: "First name",
                          hintText: "Enter first name",
                          controller: firstNameController,
                          keyboard: TextInputType.text,
                          validator: (data) => (data?.isEmpty ?? true)
                              ? 'Invalid first name'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomTextField(
                          labelText: "Last name",
                          hintText: "Enter last name",
                          controller: lastNameController,
                          keyboard: TextInputType.text,
                          validator: (data) => (data?.isEmpty ?? true)
                              ? 'Invalid last name'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: "Email",
                    hintText: "Enter your email",
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    validator: (data) {
                      if (data == null || data.isEmpty || !data.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: "Password",
                          hintText: "Enter password",
                          controller: passwordController,
                          keyboard: TextInputType.text,
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (data.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            final passwordPattern = Constant.regexPass;
                            if (!passwordPattern.hasMatch(data)) {
                              return 'Please enter a correct password (e.g., Elevet@123)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomTextField(
                          labelText: "Confirm password",
                          hintText: "Confirm password",
                          controller: rePasswordController,
                          keyboard: TextInputType.text,
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter your password confirmation';
                            }
                            if (data.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (data != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: "Phone number",
                    hintText: "Enter phone number",
                    controller: phoneController,
                    keyboard: TextInputType.phone,
                    validator: (data) =>
                        (data?.isEmpty ?? true) ? 'Invalid phone number' : null,
                  ),
                  const SizedBox(height: 30),
                  FormField<String>(
                    validator: (value) {
                      if (selectedGender == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                    builder: (FormFieldState<String> state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Gender",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54)),
                              const SizedBox(width: 40),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Male",
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                        state.didChange(value);
                                      });
                                    },
                                  ),
                                  const Text("Male"),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Female",
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                        state.didChange(value);
                                      });
                                    },
                                  ),
                                  const Text("Female"),
                                ],
                              ),
                            ],
                          ),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                state.errorText!,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(color: Color(0xFFB3261E)),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('By signing up, you agree to our',
                          style: TextStyle(fontSize: 12)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(' Terms & Conditions',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<RegisterViewModelCubit, RegisterViewModelState>(
                    listener: (context, state) {
                      if (state is RegisterViewModelSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Registration Successful!")));
                        Navigator.pop(context);
                      } else if (state is RegisterViewModelFailure) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return CustomTextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<RegisterViewModelCubit>().onIntent(
                                  RegisterUserIntent(
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    rePassword: rePasswordController.text,
                                    phone: phoneController.text.trim(),
                                    gender: selectedGender ?? "Male",
                                  ),
                                );
                          }
                        },
                        text: "Sign up",
                        color: ColorManager.primaryColor,
                        textColor: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                          style: TextStyle(fontSize: 17)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(' Login',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
