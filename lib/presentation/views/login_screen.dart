import 'package:ecommerce_app/presentation/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/helper/app_images/images.dart';
import '../authCubit/login_cubit.dart';
import '../authCubit/login_state.dart';
import '../widgets/buildTextFormField.dart';
import 'layout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, Object? state) {
          if (state is SuccessLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LayoutScreen(),
              ),
            );
          } else if (state is FailedLogin) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              },
            );
          }
        },
        builder: (BuildContext context, state) {
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: 800,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                const SizedBox(height: 80),
                                Image.asset(AppImages.userImagse),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  buildTextFormField(
                                    hintText: 'user name',
                                    perfixIcon: Icons.person,
                                    controller: userNameController,
                                  ),
                                  const SizedBox(height: 10),
                                  buildTextFormField(
                                    controller: emailController,
                                    hintText: 'email',
                                    perfixIcon: Icons.email,
                                  ),
                                  const SizedBox(height: 10),
                                  buildTextFormField(
                                    controller: passwordController,
                                    hintText: 'password',
                                    perfixIcon: Icons.lock,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: Text(state is LoadingLogin
                                        ? "Loading...."
                                        : 'LOGIN'),
                                  ),
                                  Row(
                                    children: [
                                      Text('don`t have an account!'),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  RegisterScreen(),
                                            ),
                                          );
                                        },
                                        child: Text('register'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
