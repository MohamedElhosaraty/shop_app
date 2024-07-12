import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cubit/favorite/favorite_cubit.dart';
import 'package:shop_app/cubit/product/products_cubit.dart';
import 'package:shop_app/shared/components/textbest.dart';

class FavouriteScreen extends StatelessWidget {
   FavouriteScreen({super.key});

  final controller = FixedExtentScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FavouriteScreen",
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'font'
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            final nextIndex = controller.selectedItem + 1;
            controller.animateToItem(nextIndex,
                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
          }),
    body: BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is BottomLoading2FavoriteState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is BottomSuccessFavoriteState) {
          return ListWheelScrollView.useDelegate(
            controller: controller,
            physics: const FixedExtentScrollPhysics(),
            itemExtent: MediaQuery
                .sizeOf(context)
                .height / 1.9,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: state.getFavouriteModel.data.data.length,
              builder: (context, index) {
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image(image: NetworkImage(state.getFavouriteModel.data.data[index].product.image,)),
                              if (state.getFavouriteModel.data.data[index].product.discount != 0)
                                Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "DISCOUNT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextBest(
                                text: state.getFavouriteModel.data.data[index].product.name,
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.getFavouriteModel.data.data[index].product.price.toString(),
                                    style: TextStyle(fontSize: 15.sp, color: Colors.blueAccent),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 20,
                                  ),
                                  if (state.getFavouriteModel.data.data[index].product.discount != 0)
                                    Text(
                                      state.getFavouriteModel.data.data[index].product.oldPrice.round().toString(),
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      ProductsCubit.get(context).changeFavorites(state.getFavouriteModel.data.data[index].product.id);
                        
                                    },
                                    icon:  CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                        ProductsCubit.get(context).favorite[state.getFavouriteModel.data.data[index].product.id]?? false ?
                                        Colors.blueAccent:
                                        Colors.grey,
                                        child: Icon(Icons.favorite,
                                          size: 25,
                                          color:
                                          ProductsCubit.get(context).favorite[state.getFavouriteModel.data.data[index].product.id] ?? false ? Colors.red :
                                          Colors.white,)),
                                  ),
                                ],
                              ),
                        
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          );
        }
        if (state is BottomFailureGetFavoriteState) {
          return Center(child: Text(state.errorMessage));
        }
        return const Text('data');
      },
    ),
    );
  }
}
