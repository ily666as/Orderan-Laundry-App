import 'package:flutter/material.dart';
import 'form_orderan.dart';

import 'database/db_helper.dart';
import 'model/orderan.dart';
    
    class ListOrderanPage extends StatefulWidget {
        const ListOrderanPage({ Key? key }) : super(key: key);
    
        @override
        _ListOrderanPageState createState() => _ListOrderanPageState();
    }
    
    class _ListOrderanPageState extends State<ListOrderanPage> {

        List<Orderan> listOrderan = [];
        DbHelper db = DbHelper();
    
        @override
        void initState() {
        //menjalankan fungsi getallorderan saat pertama kali dimuat
        _getAllOrderan();
        super.initState();
        }
    
        @override
        Widget build(BuildContext context) {
        return Scaffold(
            
            appBar: AppBar(
                title: Center(
                child: Text("Orderan Laundry App"),
                ),
            ),
            body: ListView.builder(
                itemCount: listOrderan.length,
                itemBuilder: (context, index) {
                    Orderan orderan = listOrderan[index];
                    return Padding(
                    padding: const EdgeInsets.only(
                        top: 20
                    ),
                    child: ListTile(
                        leading: Icon(
                        Icons.local_laundry_service_outlined, 
                        size: 40,
                        ),
                        title: Text(
                        '${orderan.nama}'
                        ),
                        subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 8, 
                            ),
                            child: Text("Jenis: ${orderan.jenis}"),
                            ), 
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 8,
                            ),
                            child: Text("Berat: ${orderan.berat}"),
                            ),
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 8,
                            ),
                            child: Text("Pembayaran: ${orderan.pembayaran}"),
                            ),
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 8, 
                            ),
                            child: Text("Tanggal Ambil: ${orderan.tanggalAmbil}"),
                            )
                        ],
                        ),
                        trailing: 
                        FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                            children: [
                            // button edit 
                            IconButton(
                                onPressed: () {
                                _openFormEdit(orderan);
                                },
                                icon: Icon(Icons.edit_note)
                            ),
                            // button hapus
                            IconButton(
                                icon: Icon(Icons.delete_sweep),
                                onPressed: (){
                                //membuat dialog konfirmasi hapus
                                AlertDialog hapus = AlertDialog(
                                    title: Text("Information"),
                                    content: Container(
                                    height: 100, 
                                    child: Column(
                                        children: [
                                        Text(
                                            "Yakin ingin Menghapus Data ${orderan.nama}"
                                        )
                                        ],
                                    ),
                                    ),
                                    //terdapat 2 button.
                                    //jika ya maka jalankan _deleteOrderan() dan tutup dialog
                                    //jika tidak maka tutup dialog
                                    actions: [
                                    TextButton(
                                        onPressed: (){
                                        _deleteOrderan(orderan, index);
                                        Navigator.pop(context);
                                        }, 
                                        child: Text("Ya")
                                    ), 
                                    TextButton(
                                        child: Text('Tidak'),
                                        onPressed: () {
                                        Navigator.pop(context);
                                        },
                                    ),
                                    ],
                                );
                                showDialog(context: context, builder: (context) => hapus);
                                }, 
                            )
                            ],
                        ),
                        ),
                    ),
                    );
                }),
                //membuat button mengapung di bagian bawah kanan layar
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: (){
                    _openFormCreate();
                    },
                ),
            
        );
        }
    
        //mengambil semua data Orderan
        Future<void> _getAllOrderan() async {
        //list menampung data dari database
        var list = await db.getAllOrderan();
    
        //ada perubahanan state
        setState(() {
            //hapus data pada listOrderan
            listOrderan.clear();
    
            //lakukan perulangan pada variabel list
            list!.forEach((orderan) {
            
            //masukan data ke listOrderan
            listOrderan.add(Orderan.fromMap(orderan));
            });
        });
        }
    
        //menghapus data Orderan
        Future<void> _deleteOrderan(Orderan orderan, int position) async {
        await db.deleteOrderan(orderan.id!);
        setState(() {
            listOrderan.removeAt(position);
        });
        }
    
        // membuka halaman tambah Orderan
        Future<void> _openFormCreate() async {
        var result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormOrderan()));
        if (result == 'save') {
            await _getAllOrderan();
        }
        }
    
        //membuka halaman edit Orderan
        Future<void> _openFormEdit(Orderan orderan) async {
        var result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => FormOrderan(orderan: orderan)));
        if (result == 'update') {
            await _getAllOrderan();
        }
        }
    }