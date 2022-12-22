
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/services/service_locator.dart';
import '../../domain/useCase/get_search_usecase.dart';
import '../controller/search_cubit/search_cubit.dart';
import '../controller/search_cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  SearchParameters searchItem;
  SearchScreen({Key? key, required this.searchItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context)=>SearchCubit(sl(),)..getSearchMovie(searchItem),
        child: BlocConsumer<SearchCubit,SearchStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit=SearchCubit.get(context);

            print("search="+cubit.searchList.toString());
            return Scaffold(
              appBar: AppBar(),
              body: IconButton(
                onPressed: (){
                  cubit.getSearchMovie(searchItem);
                }, icon: Icon(Icons.search),

              ),
            );
          },
        ),
    );
  }
}
