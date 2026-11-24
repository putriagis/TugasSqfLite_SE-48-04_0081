import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_sqflite/model/barang.dart';
import 'package:latihan_sqflite/repo/barang_repo.dart';

class BarangController extends GetxController {
  final BarangRepo repo;
  BarangController(this.repo);

  var barangList = <Barang>[].obs;

  @override
  void onInit(){
    super.onInit();
    getBarang();
  }

  Future<void> getBarang() async {
    try{
      barangList.value = await repo.getAllBarang();
      Get.snackbar("Sukses", "Berhasil");
    }catch (e){
      Get.snackbar("Error", "Gagal", backgroundColor: Colors.red);
    }
  }

  Future<void> tambahBarang(Barang barang) async {
    try{
      await repo.insert(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama${barang.nama} Berhasil ditambahkan",
      );
    }catch (e){
      Get.snackbar("Error","Gagal", backgroundColor: Colors.red);
    }
  }

  Future<void> ubahBarang(Barang barang) async {
    try{
      await repo.update(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama${barang.nama} Berhasil diubah",
      );
    }catch (e){
      Get.snackbar("Error","Gagal", backgroundColor: Colors.red);
    }
  }

  Future<void> hapusBarang(Barang barang) async {
    try{
      await repo.delete(barang.id!);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama${barang.nama} Berhasil dihapus",
      );
    }catch (e){
      Get.snackbar("Error","Gagal", backgroundColor: Colors.red);
    }
  }
}
