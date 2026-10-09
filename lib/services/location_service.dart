import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  // ওপেনস্ট্রিটম্যাপ (OSM) ব্যবহার করে Lat/Lng থেকে টেক্সট ঠিকানা বের করার ফাংশন
  static Future<String> getAddressFromCoordinates(double lat, double lng) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1');

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'KhabarLagbeApp'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];

        if (address != null) {
          String area = address['suburb'] ??
              address['neighbourhood'] ??
              address['residential'] ??
              address['road'] ??
              '';
          String city = address['city'] ??
              address['town'] ??
              address['state_district'] ??
              'Dhaka';

          if (area.isNotEmpty && city.isNotEmpty) {
            return "$area, $city";
          } else if (city.isNotEmpty) {
            return city;
          }
        }
      }
    } catch (e) {
      return "Lat: ${lat.toStringAsFixed(2)}, Lng: ${lng.toStringAsFixed(2)}";
    }

    return "Lat: ${lat.toStringAsFixed(2)}, Lng: ${lng.toStringAsFixed(2)}";
  }
}