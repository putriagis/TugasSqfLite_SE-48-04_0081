import 'package:latihan_sqflite/data/dao/barang_dao.dart';
import 'package:latihan_sqflite/model/barang.dart';

abstract class BarangRepo {
  Future<int> insert(Barang barang);
  Future<List<Barang>> getAllBarang();
  Future<int> update(Barang barang);
  Future<int> delete(int id);
}

class BarangRepoImpl implements BarangRepo {
  final BarangDao dao;

  BarangRepoImpl(this.dao);

  @override
  Future<List<Barang>> getAllBarang() {
    return dao.getAllBarang();
  }

  @override
  Future<int> insert(Barang barang) {
    return dao.insert(barang);
  }

  @override
  Future<int> update(Barang barang) {
    return dao.update(barang);
  }

  @override
  Future<int> delete(int id) {
    return dao.delete(id);
  }
}
