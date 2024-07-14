import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cubit/categories/categories_cubit.dart';
import 'package:shop_app/cubit/favorite/favorite_cubit.dart';
import 'package:shop_app/cubit/product/products_cubit.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BottomHomeLoadingState ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BottomHomeSuccessState) {
            return BuildProduct(homeModel: state.homeModel);
          }
          if (state is BottomHomeFailureState) {
            return Text(state.errorMessage.toString());
          } return const
          Center(child:  Text('Mohamed'));
        },
      ),
    );
  }
}

class BuildProduct extends StatelessWidget {
  const BuildProduct({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .4,
                  initialPage: 0,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  reverse: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,
                  autoPlayInterval: const Duration(seconds: 3))),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoriesSuccessState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BuildCategoriesItem(
                                categoriesModel:
                                    state.categoriesModel.data.data[index],
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 10.w,
                                ),
                            itemCount: state.categoriesModel.data.data.length),
                      ),
                    ],
                  ),
                );
              }
              if (state is CategoriesFailureState) {
                return Center(child: Text(state.errorMessage));
              }
              return const Text('data');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "New Products",
              style: TextStyle(
                fontSize: 30.sp,
                color: Colors.black,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.5.h,
            children: List.generate(
                homeModel.data.products.length,
                (index) => BuildGridView(
                      homeModel: homeModel.data.products[index],
                    )),
          ),
        ],
      ),
    );
  }
}

class BuildGridView extends StatelessWidget {
  const BuildGridView({super.key, required this.homeModel});

  final Product homeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                homeModel.image,
              ),
              height: 173.h,
              width: double.infinity,
            ),
            if (homeModel.discount != 0)
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
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                homeModel.name,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.1.h,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    homeModel.price.round().toString(),
                    style: TextStyle(fontSize: 10.sp, color: Colors.blueAccent),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  if (homeModel.discount != 0)
                    Text(
                      homeModel.oldPrice.round().toString(),
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      ProductsCubit.get(context).changeFavorites(homeModel.id);
                        FavoriteCubit.get(context).getFavoriteData();
                    },
                    icon:  CircleAvatar(
                      radius: 20,
                        backgroundColor:
                        ProductsCubit.get(context).favorite[homeModel.id]?? false ?
                        Colors.blueAccent:
                        Colors.grey,
                        child: Icon(Icons.favorite,
                          color:
                          ProductsCubit.get(context).favorite[homeModel.id] ?? false ? Colors.red :
                          Colors.white,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildCategoriesItem extends StatelessWidget {
  const BuildCategoriesItem({super.key, required this.categoriesModel});

  final Datum categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30.w,
          backgroundImage: NetworkImage(categoriesModel.image),
        ),
        Text(
          categoriesModel.name,
          maxLines: 1,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
