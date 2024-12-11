import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apii/models/mahasiswa_model.dart';

class MahasiswaService{
  static const String baseUrl = 'http://localhost/pemrogramanmobile/api/mahasiswa.php';
  static String message = '';

  // mendapatkan semua mahasiswa
  static Future<List<Mahasiswa>> readMahasiswa() async{
    final response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((mhs) => Mahasiswa.fromJson(mhs)).toList();
    } else{
      throw Exception('Gagal memuat data mahasiswa');
    }
  }

  // mendapatkan satu mahasiswa
  static Future<Mahasiswa> readMahasiswaById(int id) async{
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if(response.statusCode == 200){
      return Mahasiswa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail mahasiswa');
    }
  }

  // membuat mahasiswa baru
  static Future<String> createMahasiswa(Mahasiswa mahasiswa) async {
    final response = await http.post(Uri.parse(baseUrl), headers: {"Content-Type": "application/json"}, body: json.encode(mahasiswa.toJson()),);
    final responseBody = json.decode(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      message = responseBody['message'] ?? 'Mahasiswa berhasil ditambahkan';
    }
    return message;
  }

  // memperbarui mahasiswa
  static Future<String> updateMahasiswa(Mahasiswa mahasiswa) async{
    final response = await http.put(
      Uri.parse('$baseUrl/${mahasiswa.id}'), 
      headers: {"Content-Type": "application/json"},
      body: json.encode(mahasiswa.toJson()),
    );
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      message = responseBody['message'] ?? 'Mahasiswa berhasil diperbarui';
    }
    return message;
  }

  // menghapus mahasiswa
  static Future<String> deleteMahasiswa(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl/$id'),);
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      message = responseBody['message'] ?? 'Mahasiswa berhasil dihapus';
    }
    return message;
  }
}