import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'check_internet_states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class CheckInternetCubit extends Cubit<CheckInternetState>{
  CheckInternetCubit() : super(InitailInternetState());

  static CheckInternetCubit get(context)=>BlocProvider.of(context);

  StreamSubscription? subscription;
  void checkInternet(){
    subscription=Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if(result==ConnectivityResult.wifi||result==ConnectivityResult.mobile){
      emit(InternetConnectedState(message: "connected"));
    }else{
      emit(InternetNotConnectedState(message: "Not Connected"));
    }
   });
  }
  @override
  Future<void> close() {
    subscription!.cancel();
    return super.close();
  }
 
}