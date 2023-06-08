import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var formKey=GlobalKey<FormState>();
  var searchController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a text to search';
                              }
                            },
                            decoration: const InputDecoration(
                              label: Text('Search'),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              SearchCubit.get(context).searchProduct(text: value);
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          if(state is SearchLoadingState)
                            const LinearProgressIndicator(),
                ],
              ),
            ),
          ),
        );
        },
        
      ),
    );
  }
}