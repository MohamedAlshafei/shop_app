import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/shared_pref/cache_helper.dart';
import 'package:shop_app/presentation/screens/shop_login_screen.dart';

import '../../business_logic/layout/cubit/shop_layout_cubit.dart';
import '../screens/search_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopLayoutCubit, ShopLayoutState>(
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('SALA'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  SearchScreen()));
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
