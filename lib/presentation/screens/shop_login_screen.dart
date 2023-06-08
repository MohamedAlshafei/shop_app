// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/shared_pref/cache_helper.dart';
import 'package:shop_app/presentation/screens/shop_register_screen.dart';
import '../../business_logic/ligon/cubit/shop_login_cubit.dart';
import '../../components/constants.dart';
import '../layOut/home_layout.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message!);
              print(state.loginModel.data!.token!);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token!).then((value){
                token=state.loginModel.data!.token!;
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeLayout()));
              });
              
            } else {
              print(state.loginModel.message!);
              showToast(
                text: state.loginModel.message!,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 22, color: Colors.black),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text('Email Address'),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),

                            prefixIcon: const Icon(Icons.lock),
                            suffix: InkWell(
                                onTap: () {
                                  ShopLoginCubit.get(context)
                                      .changePasswordVisibilty();
                                },
                                child: ShopLoginCubit.get(context).suffix),
                            // IconButton(
                            //   onPressed: (){

                            //   },
                            //   icon:
                            //   ),

                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ConditionalBuilder(
                          // condition: state is! ShopLoginLoadingState,
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterScreen()));
                              },
                              child: const Text('Register now'),
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
        },
      ),
    );
  }
}
