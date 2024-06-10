import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiService {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final host = 'http://10.0.2.2:8000/api';
// Authentication
  Future<String?> login(String email, String password) async {
    final url = Uri.parse(host + '/student/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await storage.write(key: 'token', value: token);
        return null; // Indicate success
      } else {
        final data = jsonDecode(response.body);
        String errorMessage = data['message'] ?? 'Login failed';
        return errorMessage; // Return the error message
      }
    } catch (e) {
      print('Login failed with error: $e');
      return 'An error occurred. Please try again.';
    }
  }

// Get student details
  Future<Map<String, dynamic>> getStudentDetails() async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse(host + '/student/details');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load student details');
    }
  }

// Get all courses
  Future<Map<String, dynamic>> fetchCourses() async {
    final url = Uri.parse(host + '/courses');
    final token = await storage.read(key: 'token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        // Handle the error here
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load courses');
    }
  }

// Upload video
  Future<Map<String, dynamic>> uploadVideo(
      int courseId, File videoFile, String name, String description) async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse(host + '/course/$courseId/video');

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['name'] = name
      ..fields['description'] = description
      ..files.add(await http.MultipartFile.fromPath(
        'video',
        videoFile.path,
        contentType: MediaType('video', 'mp4'),
      ));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('=============================================================>');
      print('Request URL: $url');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files}');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Redirection Location: ${response.headers['location']}');
      print('=============================================================>');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 302) {
        print('Redirection detected to: ${response.headers['location']}');
        throw Exception('Redirection detected');
      } else {
        print('Upload failed: ${response.body}');
        throw Exception('Failed to upload video');
      }
    } catch (e) {
      print('Upload failed: $e');
      throw Exception('Failed to upload video');
    }
  }

  // Future<Map<String, dynamic>> uploadVideo(
  //     int courseId, File videoFile, String name, String description) async {
  //   final token = await storage.read(key: 'token');
  //   final url = Uri.parse(host + '/course/$courseId/video');

  //   final request = http.MultipartRequest('POST', url)
  //     ..headers['Authorization'] = 'Bearer $token'
  //     ..fields['name'] = name
  //     ..fields['description'] = description
  //     ..files.add(await http.MultipartFile.fromPath(
  //       'video',
  //       videoFile.path,
  //       contentType: MediaType('video', 'mp4'),
  //     ));

  //   final streamedResponse = await request.send();
  //   final response = await http.Response.fromStream(streamedResponse);
  //   print('=============================================================>');
  //   print(url);
  //   print(response);
  //   print('=============================================================>');

  //   print('Upload response status: ${response.statusCode}');
  //   print('Upload response body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to upload video');
  //   }
  // }

// Upload comment
  Future<Map<String, dynamic>> uploadComment(
      int courseId, String comment) async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse(host + '/course/$courseId/comment');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'content': comment,
      }),
    );

    print('Upload comment response status: ${response.statusCode}');
    print('Upload comment response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to upload comment');
    }
  }

// Get course content
  Future<Map<String, dynamic>> getCourseDetails(int courseId) async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse(host + '/course/$courseId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Get course details response status: ${response.statusCode}');
    print('Get course details response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load course details');
    }
  }

// Logout
  Future<String?> logout() async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse(host + '/student/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Logout response status: ${response.statusCode}');
      print('Logout response body: ${response.body}');

      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
        return null; // Indicate success
      } else {
        return 'Logout failed';
      }
    } catch (e) {
      print('Logout failed with error: $e');
      return 'An error occurred. Please try again.';
    }
  }
}
