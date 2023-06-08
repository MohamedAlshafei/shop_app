import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/ligon/cubit/shop_login_cubit.dart';
import '../../business_logic/register/cubit/shop_register_cubit.dart';
import '../../business_logic/shared_pref/cache_helper.dart';
import '../../components/constants.dart';
import '../layOut/home_layout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context,state){
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              // print(state.loginModel.message!);
              // print(state.loginModel.data!.token!);

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
        builder: (context, state){
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
                              'REGISTER',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 22, color: Colors.black),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              'Register now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your name';
                                }
                              },
                              decoration: const InputDecoration(
                                label: Text('User Name'),
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
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
                            const SizedBox(height: 20.0,),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              obscureText: ShopRegisterCubit.get(context).isPassword,
                              decoration: InputDecoration(
                                label: const Text('Password'),
          
                                prefixIcon: const Icon(Icons.lock),
                                suffix: InkWell(
                                    onTap: () {
                                      ShopRegisterCubit.get(context)
                                          .changePasswordVisibilty();
                                    },
                                    child: ShopRegisterCubit.get(context).suffix),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height:20.0),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your phone number';
                                }
                              },
                              decoration: const InputDecoration(
                                label: Text('Phone Number'),
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ConditionalBuilder(
                              // condition: state is! ShopLoginLoadingState,
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text
                                          );
                                    }
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
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