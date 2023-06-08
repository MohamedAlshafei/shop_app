import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/layout/cubit/shop_layout_cubit.dart';
import '../../components/constants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (state,context){

      },
      builder: (state ,context){
        return ListView.separated(
      itemBuilder: (context,index)=> buildFavItem(index),
      separatorBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Container(
            height: 1.0,
            color: const Color.fromARGB(255, 194, 191, 191),
          ),
        );
      }, 
      itemCount: 10
      );
      } , 
      
      );
  }

  Widget buildFavItem(int index){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100.0,
        child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        const Image(
                          image: NetworkImage( "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          // fit: BoxFit.cover,
                        ),
                        if(1 != 0)
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
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mohamed Abd El Nasser Mostafa Mohameddsdx',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              height: 1.3
                            ),
                          ),
                          const Spacer(),
                      Row(
                        children: [
                          const Text(
                        '5000',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0
                        ),
                      ),
                      const SizedBox(width: 5,),
                      if(1 != 0)
                          const Text(
                          '6000',
                          style:TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          print(token.toString());
                          // ShopLayoutCubit.get(context).changeFavorites(model.id);
                          // print(model.id);
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
      ),
    );
  }
}