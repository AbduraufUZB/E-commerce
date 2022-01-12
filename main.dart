import 'dart:io';

import 'seller.dart';
import 'customer.dart';

void main(List<String> args) async {
  //O'zgaruvchilar
  int m = 0;
  String? select;

  while (m == 0) {
    stdout.write(
        "Sotuvchi yoki Mijoz\nDasturdan chiqish uchun - QUIT\nTanlash: ");
    select = stdin.readLineSync()!;
    if (select.toLowerCase() == "mijoz") {
      //mijoz
      await funcSearch(soz: "Qidirilmoqda");
      await funcCustomer();
    } else if (select.toLowerCase() == "sotuvchi") {
      //sotuvchi
      await funcSearch(soz: "Qidirilmoqda");
      await funcSeller();
    } else if (select.toLowerCase() == "quit") {
      m += 1;
    } else {
      await funcSearch(soz: "Qidirilmoqda");
      print("\nBunday tanlash turi yo'q!\nIltimos boshqatdan tanlang :)\n");
    }
  }
}

Future funcCustomer() async {
  //Mijoz
  String? select, productname;
  int m = 0, n = 0, productnum, productprice, index;
  while (m == 0) {
    stdout.write(
        "\nMahsulotlar haqida ma'lumot olish - 0\nMahsulotlar sotib olish - 1\nSotib olingan mahsulotlarni ko'rish - 2\nDasturdan chiqish uchun - QUIT\n");
    Customer().funcCount();
    stdout.write("Kiritish: ");
    select = stdin.readLineSync()!;
    if (select == "0") {
      print("");
      for (var i = 0; i < Seller.numofproducts.length; i++) {
        print(
            "Mahsulot: ${Seller.productslst[i]}, Mahsulot soni: ${Seller.numofproducts[i]}, Mahsulot narxi: ${Seller.priceproducts[i]} so'm");
      }
      print("");
    } else if (select == "1") {
      n = 0;
      while (n == 0) {
        stdout.write("\nMahsulot nomi: ");
        productname = stdin.readLineSync();
        if (Seller.productslst.contains(productname)) {
          index = Seller.productslst.indexOf(productname);
          print(
              "Mahsulotning qolgan soni: ${Seller.numofproducts[index]}\nMahsulot narxi: ${Seller.priceproducts[index]}");
          stdout.write("Nechta olmoqchisiz: ");
          productnum = int.parse(stdin.readLineSync()!);
          if (Seller.numofproducts[index] >= productnum) {
            productprice = Seller.priceproducts[index] * productnum;
            Seller().funcMin(num: productnum, index: index);
            await funcSearch(soz: "Qo'shilmoqda");
            Customer.purchasedPRprice.add(productprice);
            Customer.purchasedproduct.add(productname);
            stdout.write("Dasturni tugatishni xohlaysizmi Y/N!\nKiritish: ");
            select = stdin.readLineSync()!;
            if (select.toLowerCase() == "y") {
              continue;
            } else {
              n += 1;
            }
          } else {
            print("\nMahsulot soni kam!\n");
          }
        } else {
          print("\nBunday mahsulot yo'q!\n");
        }
      }
    } else if (select == "2") {
      print("");
      for (var i = 0; i < Customer.purchasedproduct.length; i++) {
        print(
            "Mahsulot: ${Customer.purchasedproduct[i]}, Mahsulot narxi: ${Customer.purchasedproduct} so'm");
      }
    } else if (select.toLowerCase() == "quit") {
      print("");
      m += 1;
    } else {
      print("\nBunday funskiya yo'q!\nIltimos boshqatdan kiriting!\n");
    }
  }
}

Future funcSeller() async {
  //Sotuvchi
  String? login, password, select, productname;
  int m = 0, productprice, index, productnum;

  stdout.write("\nLogin: ");
  login = stdin.readLineSync()!;
  stdout.write("Parol: ");
  password = stdin.readLineSync()!;

  if (login == Seller.sellerlogin && password == Seller.sellerpassword) {
    await funcSearch(soz: "Qidirilmoqda");
    print("Login va parol to'g'ri kiritilgan :)\n");
    while (m == 0) {
      stdout.write(
          "\nMa'lumotlar - 0\nMaxsulot narxini o'zgarirish - 1\nMaxsulot soniga qo'shish - 2\nMaxsulot qo'shish - 3\nTanlash: ");
      select = stdin.readLineSync()!;

      if (select == "0") {
        print("");
        for (var i = 0; i < Seller.numofproducts.length; i++) {
          print(
              "Mahsulot: ${Seller.productslst[i]}, Mahsulot soni: ${Seller.numofproducts[i]}, Mahsulot narxi: ${Seller.priceproducts[i]} so'm");
        }
        stdout.write("Dasturni tugatishni xohlaysizmi Y/N!\nKiritish: ");
        select = stdin.readLineSync()!;
        if (select.toLowerCase() == "y") {
          continue;
        } else {
          m += 1;
        }
      } else if (select == "1") {
        stdout.write("\nMahsulot nomini kiriting: ");
        productname = stdin.readLineSync()!;
        if (Seller.productslst.contains(productname)) {
          index = Seller.productslst.indexOf(productname);
          stdout.write("Narxni kiriting: ");
          productprice = int.parse(stdin.readLineSync()!);
          Seller().changePriceProducts(price: productprice, index: index);
          await funcSearch(soz: "O'zgartirildi");
          stdout.write("Dasturni tugatishni xohlaysizmi Y/N!\nKiritish: ");
          select = stdin.readLineSync()!;
          if (select.toLowerCase() == "y") {
            continue;
          } else {
            m += 1;
          }
        } else {
          print("\nBunday mahsulot topilmadi!\n");
        }
      } else if (select == "2") {
        stdout.write("\nMahsulot nomini kiriting: ");
        productname = stdin.readLineSync()!;
        if (Seller.productslst.contains(productname)) {
          index = Seller.productslst.indexOf(productname);
          stdout.write("Mahsulot sonini kriting: ");
          productnum = int.parse(stdin.readLineSync()!);
          Seller().changeNumProducts(num: productnum, index: index);
          await funcSearch(soz: "O'zgartirilmoqda");
          stdout.write("Dasturni tugatishni xohlaysizmi Y/N!\nKiritish: ");
          select = stdin.readLineSync()!;
          if (select.toLowerCase() == "y") {
            continue;
          } else {
            m += 1;
          }
        } else {
          print(
              "\nBunday mahsulot mavud emas!\nIltimos boshqatdan kiriting!\n");
        }
      } else if (select == "3") {
        stdout.write("\nMahsulot nomi: ");
        productname = stdin.readLineSync()!;
        stdout.write("Mahsulot soni: ");
        productnum = int.parse(stdin.readLineSync()!);
        stdout.write("Mahsulot narxi: ");
        productprice = int.parse(stdin.readLineSync()!);
        Seller().addProducts(
            product: productname, num: productnum, price: productprice);
        await funcSearch(soz: "Qo'shilmoqda");
        stdout.write("Dasturni tugatishni xohlaysizmi Y/N!\nKiritish: ");
        select = stdin.readLineSync()!;
        if (select.toLowerCase() == "y") {
          continue;
        } else {
          m += 1;
        }
      } else {
        print("\nBunday funksiya yo'q!\nIltimos boshqatdan kiriting!\n");
      }
    }
  } else {
    await funcSearch(soz: "Qidirilmoqda");
    print("Afususki login yoki parol to'g'ri kelmadi!\n");
  }
}

Future funcSearch({required String soz}) async {
  print("");
  for (var i = 0; i < 3; i++) {
    await Future.delayed(Duration(milliseconds: 50), () {
      stdout.write(".");
    });
  }
  for (var i in soz.split("")) {
    await Future.delayed(Duration(milliseconds: 50), () {
      stdout.write("$i");
    });
  }
  for (var i = 0; i < 3; i++) {
    await Future.delayed(Duration(milliseconds: 50), () {
      stdout.write(".");
    });
  }
  print("");
  print("");
}
