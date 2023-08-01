import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layoutCubit/layout_cubit.dart';
import '../layoutCubit/layout_state.dart';
import '../layoutCubit/logout_cubit.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (BuildContext context, Object? state) {
        if (state is ProfileDataFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
            ),
          );
        }
      },
      builder: (BuildContext context, state) {
        return cubit.user != null
            ? SafeArea(
                child: Scaffold(
                  body: Column(
                    children: [
                      if (cubit.user == null)
                        CircularProgressIndicator()
                      else if (cubit.user != null)
                        Column(
                          children: [
                            Center(
                              child: Text(cubit.user!.name),
                            ),
                            Image.network(cubit.user!.img),
                          ],
                        ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<LogoutCubit>(context).logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : CupertinoActivityIndicator();
      },
    );
  }
}
