class Customer {
  static List purchasedproduct = [];
  static List<int> purchasedPRprice = [];

  void funcCount() {
    int sum = 0;
    for (var i = 0; i < purchasedPRprice.length; i++) {
      sum += purchasedPRprice[i];
    }
    print("Hisob: $sum");
  }

  
}
