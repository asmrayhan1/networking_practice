class RegisterGeneric{
  bool isLoading;
  RegisterGeneric({this.isLoading=false});
  RegisterGeneric update({bool? isLoading}) {
    return RegisterGeneric(isLoading: isLoading?? this.isLoading);
  }
}