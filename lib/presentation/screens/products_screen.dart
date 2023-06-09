import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/model/home_model.dart';

import '../../business_logic/layout/cubit/shop_layout_cubit.dart';
import '../../model/categories_model.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state){
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model!.status!){
            showToast(text: state.model!.message!, state: ToastState.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null && 
          ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (context)=> slider(ShopLayoutCubit.get(context).homeModel!, ShopLayoutCubit.get(context).categoriesModel!,context),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget slider(HomeModel model, CategoriesModel categoriesModel,context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners!.map((e) 
              => Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ).toList(),
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            ),
          ),
          const SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
            'Categories',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800
            ),
          ),
          const SizedBox(height: 20.0,),
          Container(
            height: 100.0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=> buildCategoryItem(categoriesModel.data!.data![index]), 
              separatorBuilder: (context,index)=>const SizedBox(width: 10.0,), 
              itemCount: categoriesModel.data!.data!.length
              ),
          ),
          const SizedBox(height: 20.0,),
          const Text(
            'New Products',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800
            ),
          ),
              ],
            ),
            ),
          const SizedBox(height: 20.0,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.55,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products!.length, 
                (index) => buildGridProduct(model.data!.products![index],context),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model){
    return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.8),
                width: 100.0,
                child: Text(
                  '${model.name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
  }

  Widget buildGridProduct(ProductsModel model, context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image.toString()),
                      width: double.infinity,
                      height: 170,
                      // fit: BoxFit.cover,
                    ),
                    if(model.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white
                          ),
                        ),
                      ),  
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                    '${model.price?.round()}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0
                    ),
                  ),
                  const SizedBox(width: 5,),
                  if(model.discount != 0)
                      Text(
                      '${model.oldPrice.round()}',
                      style:const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                    
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopLayoutCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    }, 
                    icon:  const CircleAvatar(
                      radius: 15.0,
                      // backgroundColor: ShopLayoutCubit!.get(context).favorites[model.id] ? Colors.blue:Colors.grey ,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    )
                    ),
                    
                    ],
                  ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}