import 'package:get/get.dart';
import 'package:latihan_sqflite/model/barang.dart';
import 'package:latihan_sqflite/repo/barang_repo.dart';

class BarangController extends GetxController {
  final BarangRepo _repo;

  BarangController(this._repo);

  final barangList = <Barang>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBarang();
  }

  Future<void> loadBarang() async {
    isLoading.value = true;
    try {
      barangList.assignAll(await _repo.getAllBarang());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> tambahBarang(String nama, int stok) async {
    await _repo.insert(Barang(nama: nama, stok: stok));
    await loadBarang();
  }
}
