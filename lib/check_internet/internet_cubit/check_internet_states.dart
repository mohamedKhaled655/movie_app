abstract class CheckInternetState{}
class InitailInternetState extends CheckInternetState{}
class InternetConnectedState extends CheckInternetState{
  final String message;

  InternetConnectedState({required this.message});
}
class InternetNotConnectedState extends CheckInternetState{
  final String message;

  InternetNotConnectedState({required this.message});
}