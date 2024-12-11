class Mahasiswa{
  int? id;
  String nim;
  String nama;
  String prodi;
  String email;

  Mahasiswa(
    {
      this.id,
      required this.nim,
      required this.nama,
      required this.prodi,
      required this.email,
    }
  );
  // fungsi untuk mengubah data JSON menjadi objek Mahasiswa
  factory Mahasiswa.fromJson(Map<String, dynamic> json){
    return Mahasiswa(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      nama: json['nama'], 
      nim: json['nim'],
      email: json['email'],
      prodi: json['prodi']
    );
  }

  // fungsi untuk mengubah objek Mahasiswa menjadi format JSON
  Map<String, dynamic> toJson(){
    return {'nama': nama, 'nim': nim, 'email': email, 'prodi': prodi};
  }
}