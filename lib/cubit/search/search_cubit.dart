import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.api) : super(SearchInitial());
  
  final ApiConsumer api ;
  
  static SearchCubit get(context) => BlocProvider.of(context);
  
  SearchModel? searchModel;
  
  void getSearch ({required String text}) async {
    try {
      emit(SearchLoadingState());
      final response = await api.post(ApiKey.search,
        data: {
        ApiKey.text : text ,
        }
      );

      searchModel =SearchModel.fromJson(response);

      emit(SearchSuccessState(searchModel: searchModel!));

    } on ServerException catch (e) {
      emit(SearchFailureState(errorMessage: e.errorModel.message));
    }
  }
}
