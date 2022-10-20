import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/orderan.dart';

class FormOrderan extends StatefulWidget {
  final Orderan? orderan;

  FormOrderan({this.orderan});

  @override
  _FormOrderanState createState() => _FormOrderanState();
}

class _FormOrderanState extends State<FormOrderan> {
  DbHelper db = DbHelper();

  TextEditingController? nama;
  TextEditingController? jenis;
  TextEditingController? berat;
  TextEditingController? pembayaran;
  TextEditingController? tanggalAmbil;

  String? jenisCucian; // variabel menyimpan nilai dropdown
  List jenisCucians = [
    "cuci kering",
    "cuci basah",
    "cuci setrika",
    "cuci selimut"
  ]; // nilai default dropdown

  String? _pembayaran;
  List _pembayarans = ["Lunas", "Belum lunas"];

  Orderan? orderan;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.orderan == null ? '' : widget.orderan!.nama);

    jenis = TextEditingController(
        text: widget.orderan == null ? '' : widget.orderan!.jenis);

    berat = TextEditingController(
        text: widget.orderan == null ? '' : widget.orderan!.berat);

    pembayaran = TextEditingController(
        text: widget.orderan == null ? '' : widget.orderan!.pembayaran);

    tanggalAmbil = TextEditingController(
        text: widget.orderan == null ? '' : widget.orderan!.tanggalAmbil);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Orderan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton(
                borderRadius: BorderRadius.circular(8),
                hint: Text('Pilih jenis pelayanan'),
                value: jenisCucian,
                items: jenisCucians
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    jenisCucian = value as String;
                    jenis?.text = jenisCucian!;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: berat,
              decoration: InputDecoration(
                  labelText: 'Berat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton(
                  hint: Text('Status Pembayaran'),
                  value: _pembayaran,
                  items: _pembayarans
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _pembayaran = value as String;
                      pembayaran?.text = _pembayaran!;
                    });
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: tanggalAmbil,
              decoration: InputDecoration(
                  labelText: 'TanggalAmbil',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: ElevatedButton(
              child: (widget.orderan == null)
                  ? Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertOrderan();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertOrderan() async {
    if (widget.orderan != null) {
      //update
      await db.updateOrderan(Orderan.fromMap({
        'id': widget.orderan!.id,
        'nama': nama!.text,
        'jenis': jenis!.text,
        'berat': berat!.text,
        'pembayaran': pembayaran!.text,
        'tanggalambil': tanggalAmbil!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveOrderan(Orderan(
          nama: nama!.text,
          jenis: jenis!.text,
          berat: berat!.text,
          pembayaran: pembayaran!.text,
          tanggalAmbil: tanggalAmbil!.text));
      Navigator.pop(context, 'save');
    }
  }
}
