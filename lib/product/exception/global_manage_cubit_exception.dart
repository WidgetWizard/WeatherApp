
class GlobalManageCubitException implements Exception{
  @override
  String toString(){
    return "GlobalManageCubit instance has not been initialized.";
  }
}