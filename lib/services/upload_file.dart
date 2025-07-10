import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:agents_app/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
// import 'dart:html' as html;

class UploadFileService extends BaseService {
  Future<String?> uploadPhotoMobile(File file, String folder) async {
    try {
      final uri = Uri.parse('$baseUrl/upload-photo/photo');
      final request = http.MultipartRequest('POST', uri)
        ..fields['folder'] = folder;

      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      final mimeSplit = mimeType.split('/');

      final multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType(mimeSplit[0], mimeSplit[1]),
      );
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return decoded['url'];
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Upload failed: $e');
      return null;
    }
  }

  Future<String?> uploadPhotoWebFromBase64({
    required String base64String,
    required String fileName,
    required String folder,
    required String mimeType,
  }) async {
    try {
      final base64Data =
          base64String.split(',').last; // limpia encabezado si existe
      final Uint8List bytes = base64Decode(base64Data);
      final uri = Uri.parse('$baseUrl/upload-photo/photo');

      final request = http.MultipartRequest('POST', uri)
        ..fields['folder'] = folder;

      final mimeSplit = mimeType.split('/');

      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: fileName,
        contentType: MediaType(mimeSplit[0], mimeSplit[1]),
      );

      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return decoded['url'];
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Upload failed (web): $e');
      return null;
    }
  }

  Future<File> base64ToFile(String base64String, String fileName) async {
    final bytes = base64Decode(base64String);

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');

    await file.writeAsBytes(bytes);
    return file;
  }
}
