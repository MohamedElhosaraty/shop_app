import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cubit/categories/categories_cubit.dart';
import 'package:shop_app/shared/components/textbest.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({super.key});

  final controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CategoriesScreen",
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
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is CategoriesSuccessState) {
            return ListWheelScrollView.useDelegate(
              controller: controller,
              physics: const FixedExtentScrollPhysics(),
              itemExtent: MediaQuery
                  .sizeOf(context)
                  .height / 2,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: state.categoriesModel.data.data.length,
                builder: (context, index) {
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                            child: Image(image: NetworkImage(state.categoriesModel.data.data[index].image))),
                         SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextBest(
                            text: state.categoriesModel.data.data[index].name,
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (state is CategoriesFailureState) {
            return Center(child: Text(state.errorMessage));
          }
          return const Text('data');
        },
      ),
    );
  }
}
