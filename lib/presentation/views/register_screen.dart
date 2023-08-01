import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authCubit/register_cubit.dart';
import '../authCubit/register_state.dart';
import '../widgets/buildTextFormField.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (BuildContext context, Object? state) {
            if (state is SuccsessRegister) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else if (state is FailedRegister) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(state.message),
                    );
                  });
            }
          },
          builder: (BuildContext context, state) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 200,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Create account',
                                style: TextStyle(fontSize: 35),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildTextFormField(
                              hintText: 'name',
                              perfixIcon: Icons.person,
                              controller: nameController),
                          const SizedBox(
                            height: 15,
                          ),
                          buildTextFormField(
                              hintText: 'email',
                              perfixIcon: Icons.email,
                              controller: emailController),
                          const SizedBox(
                            height: 15,
                          ),
                          buildTextFormField(
                              hintText: 'password',
                              perfixIcon: Icons.lock,
                              controller: passwordController),
                          const SizedBox(
                            height: 15,
                          ),
                          buildTextFormField(
                              hintText: 'phone',
                              perfixIcon: Icons.phone,
                              controller: phoneController),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (BuildContext context) =>
                                  //           LayoutScreen(),
                                  //     ));
                                  // );
                                  // } else {
                                  //   ScaffoldMessenger(
                                  //     child: Text('proccess is error '),
                                  //   );
                                }
                              },
                              child: Text(state is LoadingRegister
                                  ? "is loading.. "
                                  : 'Register')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginScreen()));
                                },
                                child: Text(
                                  'login',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
