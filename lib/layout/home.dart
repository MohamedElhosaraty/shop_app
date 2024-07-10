import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cubit/bottomNav/bottom_cubit.dart';
import 'package:shop_app/modules/search.dart';
import 'package:shop_app/shared/components/navigatorto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomCubit, BottomState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BottomCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Salla",style: TextStyle(
              fontSize: 20.sp,
              fontFamily: 'font',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, const SearchScreen());
              }, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomNav[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              showUnselectedLabels: false,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Setting')
              ]),
        );
      },
    );
  }
}
