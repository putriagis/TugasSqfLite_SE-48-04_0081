import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_sqflite/model/barang.dart';
import 'package:latihan_sqflite/presentation/controller/barang_controller.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final ctr = Get.find<BarangController>();
    return Scaffold(
      appBar: AppBar (title: Text("Home")),
      body: Column(
        children: [
          Text ("LIST BARANG"),

          Expanded(
            child: Obx((){
              if (ctr.barangList.isEmpty){
                return Center(child: Text("Data Belum Ada"));
              }

              return ListView.builder(
                itemCount: ctr.barangList.length,
                itemBuilder:(context, index){
                  final barang = ctr.barangList[index];
                  return Card(
                    child: ListTile(
                      title: Text(barang.nama),
                      subtitle: Text("Stok Barang ${barang.stok}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              ubah(ctr, barang);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              hapus(ctr, barang);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          tambah(ctr);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void tambah(BarangController ctr){
    final namaC = TextEditingController();
    final stokC = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text("Tambah Barang"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaC,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: stokC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Stok"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
            },
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: (){
              final barang = Barang(
                nama: namaC.text,
                stok: int.tryParse(stokC.text) ?? 0,
              );
              ctr.tambahBarang(barang);
              Get.back();
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void ubah(BarangController ctr, Barang barangLama){
    final namaC = TextEditingController(text: barangLama.nama);
    final stokC = TextEditingController(text: barangLama.stok.toString());

    Get.dialog(
      AlertDialog(
        title: Text("Ubah Barang"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaC,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: stokC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Stok"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
            },
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: (){
              final barangBaru = Barang(
                id: barangLama.id,
                nama: namaC.text,
                stok: int.tryParse(stokC.text) ?? 0,
              );
              ctr.ubahBarang(barangBaru);
              Get.back();
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void hapus(BarangController ctr, Barang barang){
    Get.dialog(
      AlertDialog(
        title: Text("Hapus Barang"),
        content: Text("Yakin ingin menghapus ${barang.nama}?"),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
            },
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: (){
              ctr.hapusBarang(barang);
              Get.back();
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
  }
}
