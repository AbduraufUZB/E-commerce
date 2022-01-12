class Seller {
  static List productslst = ["Mandarin", "Banan", "Non"];
  static List numofproducts = [10, 5, 50];
  static List priceproducts = [15990, 19990, 2000];
  static final sellerlogin = "korzinka.uz";
  static final sellerpassword = "korzinka";

  //Yangi mahsulot qo'shish
  void addProducts({
    required String product,
    required int num,
    required int price,
  }) {
    productslst.add(product);
    numofproducts.add(num);
    priceproducts.add(price);
  }

  //Mahsulotlar sonini ortirish
  void changeNumProducts({required int num, required int index}) {
    numofproducts[index] += num;
  }

  //Mahsulotlar narxini oshirish
  void changePriceProducts({required int price, required int index}) {
    priceproducts[index] = price;
  }

  void funcMin({required int num, required int index}) {
    numofproducts[index] -= num;
  }
}
