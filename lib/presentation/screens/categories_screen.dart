import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/model/home_model.dart';

import '../../model/categories_model.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopLayoutCubit,ShopLayoutState>(
      builder: (context,state){
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index)=> buildCatItem(ShopLayoutCubit.get(context).categoriesModel!.data!.data![index]), 
          separatorBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              );
          }, 
          itemCount: ShopLayoutCubit.get(context).categoriesModel!.data!.data!.length,
    );
      }
    );
  }
}

Widget buildCatItem(DataModel model){
  return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
              ),
              const SizedBox(width: 20.0,),
              Text(
                '${model.name}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}