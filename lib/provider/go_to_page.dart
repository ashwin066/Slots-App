 
   
import 'package:flutter/material.dart';

class GoToPageProvider with ChangeNotifier{
   String?  goToPath ;

 
  void addPath(String path) {
    goToPath = path;
    notifyListeners();
  }

  void removePath() {
    goToPath =null;
    notifyListeners();
  }
 
}
