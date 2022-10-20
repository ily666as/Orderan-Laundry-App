class Orderan{
    int? id;
    String? nama;
    String? jenis;
    String? berat;
    String? pembayaran;
    String? tanggalAmbil;
    
    Orderan({this.id, this.nama, this.jenis, this.berat, this.pembayaran, this.tanggalAmbil});
    
    Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
    
        if (id != null) {
          map['id'] = id;
        }
        map['nama'] = nama;
        map['jenis'] = jenis;
        map['berat'] = berat;
        map['pembayaran'] = pembayaran;
        map['tanggalambil'] = tanggalAmbil;
        
        return map;
    }
    
    Orderan.fromMap(Map<String, dynamic> map) {
        this.id = map['id'];
        this.nama = map['nama'];
        this.jenis = map['jenis'];
        this.berat = map['berat'];
        this.pembayaran = map['pembayaran'];
        this.tanggalAmbil = map['tanggalambil'];
    }
}