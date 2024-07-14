import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cubit/search/search_cubit.dart';
import 'package:shop_app/shared/components/text_from.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15.0),
              child: Column(
                children: [
                 TextForm(
                   hintText: 'Search',
                   keyBoard: TextInputType.text,
                   labelStyle: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontFamily: 'font',
                       fontSize: 20.sp,
                       color: Colors.black
                   ),
                   validate: (value){
                     if(value!.isEmpty){
                       return "enter text to search";
                     }
                     return null;
                   },
                   onEditingComplete: (){
                     SearchCubit.get(context).getSearch(text: searchController.text);
                   },
                   hintStyle: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontFamily: 'font',
                     fontSize: 20.sp,
                     color: Colors.black
                   ),
                   prefixIcon: const Icon(Icons.search),
                 ),
                 const  SizedBox(
                   height:  20,
                  ),
                  if(state is SearchLoadingState)
                   const  Center(child: CircularProgressIndicator()),
                  if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index){
                          final cubit = state.searchModel.data.data[index];
                            return SizedBox(
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width/4,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width/2.5,
                                    child: Image(
                                        image: NetworkImage(cubit.image),),
                                  ),
                                   SizedBox(
                                    width:MediaQuery.of(context).size.width/35,
                                  ),
                                  Expanded(
                                      child: Column(
                                         crossAxisAlignment :CrossAxisAlignment.start,
                                         mainAxisAlignment :MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(cubit.name,style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                              fontFamily: 'font',
                                            ),),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(cubit.price.round().toString(),style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.blueAccent,
                                          ),),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context ,index) =>  Divider(
                            height: 30.h,
                            thickness: 2,
                          ),
                          itemCount: state.searchModel.data.data.length),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
