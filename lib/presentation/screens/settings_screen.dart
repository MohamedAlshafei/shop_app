import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/layout/cubit/shop_layout_cubit.dart';

import '../../components/constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

    var formKey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutState>(
      listener: (context,state){

      },
      builder: (context,state){
        // var model = ShopLayoutCubit.get(context).userModel;
        // nameController.text = model!.data!.name!;
        // mailController.text = model.data!.email!;
        // phoneController.text=model.data!.phone!;
        
        return  ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != null,
          builder: (context) {
            return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if(state is ShopLoadingUpdateUserDataState)
                const LinearProgressIndicator(),
              
              const SizedBox(height: 20.0,),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: ( value) {
                  if (value!.isEmpty) {
                      'please enter your name';
                      }
                      return null;
                  },
                decoration: const InputDecoration(
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  ),
              ),
              const SizedBox(height: 20.0,),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: ( value) {
                  if (value!.isEmpty) {
                      'please enter your email address';
                      }
                      return null;
                  },
                decoration: const InputDecoration(
                  label: Text('Email address'),
                  prefixIcon: Icon(Icons.mail_lock_outlined),
                  border: OutlineInputBorder(),
                  ),
              ),
              const SizedBox(height: 20.0,),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: ( value) {
                  if (value!.isEmpty) {
                      'please enter your phone number';
                      }
                      return null;
                  },
                decoration: const InputDecoration(
                  label: Text('Phone Number'),
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  ),
              ),
        
              const SizedBox(height: 15.0,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      ShopLayoutCubit.get(context).updateUserData(
                      name: nameController.text, 
                      email: emailController.text, 
                      phone: phoneController.text
                      );
                    }
                    ShopLayoutCubit.get(context).updateUserData(
                      name: nameController.text, 
                      email: emailController.text, 
                      phone: phoneController.text
                      );
                  }, 
                  child: const Text(
                    'UPDATE'
                  ),
                  ),
              ),
              const SizedBox(height: 15.0,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    logOut(context);
                  }, 
                  child: const Text(
                    'LOGOUT'
                  ),
                  ),
              ),
        
            ],
          ),
        ),
      );
          },
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}