import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart' as geo;
import 'package:location/location.dart' as loc;
import 'package:map_location_picker/map_location_picker.dart';

class UserLocation {
  double? latitude;
  double? longitude;
  String? city;
  String? state;
  String? country;
  String? address;
  String? postalCode;
  geo.Placemark? placemark;

  UserLocation({
    this.latitude,
    this.longitude,
    this.address,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.placemark,
  });

  UserLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['address'] = address;
    data['postalCode'] = postalCode;
    return data;
  }

  @override
  String toString() {
    return "lat : $latitude lng : $longitude address : $address postalCode : $postalCode city : $city state : $state country : $country";
  }
}

final locationService = LocationService._();

class LocationService {
  LocationService._();

  static LocationService get instance => LocationService._();

  UserLocation? currentLocation;
  loc.Location location = loc.Location();

  Future<bool> checkForPermissions() async {
    final hasPermissions = await location.requestPermission();

    // debugPrint("checkForPermissions hasPermissions =====>>> $hasPermissions");

    return hasPermissions == loc.PermissionStatus.granted;
  }

  /// Checks if the location service is enabled.
  Future<bool> serviceEnabled() {
    return location.serviceEnabled();
  }

  /// Request the activation of the location service.
  Future<bool> requestService() {
    return location.requestService();
  }

  Future<UserLocation?> getLocations() async {
    try {
      final hasPermissions = await checkForPermissions();

      debugPrint("getLocations hasPermissions =====>>> $hasPermissions");

      if (!hasPermissions) {
        return null;
      }

      var userLocation = await location.getLocation();

      // var placeMarks = await placemarkFromCoordinates(
      //   "18.457525295338364".toDouble(),
      //   "-69.91110167521971".toDouble(),
      //   localeIdentifier: "es_US",
      // );

      var placeMarks = await placemarkFromCoordinates(
        userLocation.latitude!,
        userLocation.longitude!,
        localeIdentifier: "es_US",
      );

      print("placeMarks =======>>> $placeMarks");

      currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        address: placeMarks[0].name,
        postalCode: placeMarks[0].postalCode,
        city: placeMarks[0].locality,
        state: placeMarks[0].administrativeArea,
        country: placeMarks[0].country,
        placemark: placeMarks.first,
      );
      return currentLocation;
    } catch (e) {
      print('Could not get the getLocations : $e');
    }

    return null;
  }

  Future<UserLocation?> getCurrentLocation() async {
    try {
      final hasPermissions = await checkForPermissions();

      if (!hasPermissions) {
        return null;
      }

      var userLocation = await location.getLocation();
      currentLocation ??= UserLocation()
        ..latitude = userLocation.latitude?.toDouble()
        ..longitude = userLocation.longitude?.toDouble();

      return UserLocation(
        latitude: userLocation.latitude?.toDouble(),
        longitude: userLocation.longitude?.toDouble(),
      );
    } catch (e) {
      print('Could not get the getCurrentLocation: $e');
    }

    return currentLocation;
  }

  Future<UserLocation?> getAddress(double lat, double lng) async {
    try {
      final hasPermissions = await checkForPermissions();

      if (!hasPermissions) {
        return null;
      }

      var placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        return UserLocation(
          latitude: lat,
          longitude: lng,
          address:
              "${placemarks[0].street.toString()}, ${placemarks[0].subLocality.toString()}, ${placemarks[0].locality.toString()}, ${placemarks[0].country}",
        );
      }
    } catch (e) {
      print('Could not get the location address: $e');
    }

    return null;
  }

  Future<List<geo.Placemark>> getFullAddress(double lat, double lng) async {
    try {
      final hasPermissions = await checkForPermissions();

      if (!hasPermissions) {
        return [];
      }
      var placemarks = await placemarkFromCoordinates(lat, lng);

      return placemarks;
    } catch (e) {
      print('Could not get the location address: $e');
    }

    return [];
  }

  Future<List<geo.Location>> getLatLng(String address) async {
    try {
      final hasPermissions = await checkForPermissions();

      if (!hasPermissions) {
        return [];
      }
      var locations = await locationFromAddress(address);

      return locations;
    } catch (e) {
      print('Could not get the location address: $e');
    }

    return [];
  }

  Future<dynamic> pickLocation({
    required BuildContext context,
    required Function(UserLocation) onPicked,
  }) async {
    final apiKey = "AIzaSyC-CEV17tzC57Y9QjLdArdVDXlxrKM_ScU";

    final currentLocation = await locationService.getCurrentLocation();

    if (currentLocation == null) {
      //showToast("Location is not available!");
      return null;
    }

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MapLocationPicker(
              apiKey: apiKey,
              language: "en",
              popOnNextButtonTaped: true,
              currentLatLng:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              onNext: (GeocodingResult? result) {
                //showLog("pickNewLocation onNext =====>>> $result");

                if (result == null) return;

                try {
                  final postalCode = result.addressComponents
                      .firstWhereOrNull(
                          (element) => element.types.contains("postal_code"))
                      ?.longName;
                  final city = result.addressComponents
                      .firstWhere(
                          (element) => element.types.contains("locality"))
                      .longName;
                  final state = result.addressComponents
                      .firstWhere((element) =>
                          element.types.contains("administrative_area_level_1"))
                      .longName;
                  final country = result.addressComponents
                      .firstWhere(
                          (element) => element.types.contains("country"))
                      .longName;

                  currentLocation.latitude = result.geometry.location.lat;
                  currentLocation.longitude = result.geometry.location.lng;
                  currentLocation.address = result.formattedAddress;
                  currentLocation.postalCode = postalCode;
                  currentLocation.city = city;
                  currentLocation.state = state;
                  currentLocation.country = country;
                  onPicked.call(currentLocation);
                } catch (e, stacktrace) {
                  print("pickNewLocation exception =====>>> $e");
                  print(
                      "pickNewLocation exception stacktrace =====>>> $stacktrace");
                }
              },
              onSuggestionSelected: (PlacesDetailsResponse? newResult) {
                //showLog("onSuggestionSelected onSuggestionSelected =====>>> $newResult");

                if (newResult == null) return;
                try {
                  final result = newResult.result;

                  final postalCode = result.addressComponents
                      .firstWhereOrNull(
                          (element) => element.types.contains("postal_code"))
                      ?.longName;
                  final city = result.addressComponents
                      .firstWhere(
                          (element) => element.types.contains("locality"))
                      .longName;
                  final state = result.addressComponents
                      .firstWhere((element) =>
                          element.types.contains("administrative_area_level_1"))
                      .longName;
                  final country = result.addressComponents
                      .firstWhere(
                          (element) => element.types.contains("country"))
                      .longName;

                  currentLocation.latitude = result.geometry!.location.lat;
                  currentLocation.longitude = result.geometry!.location.lng;
                  currentLocation.address = result.formattedAddress;
                  currentLocation.postalCode = postalCode;
                  currentLocation.city = city;
                  currentLocation.state = state;
                  currentLocation.country = country;
                  onPicked.call(currentLocation);
                } catch (e, stacktrace) {
                  print("pickNewLocation exception =====>>> $e");
                  print(
                      "pickNewLocation exception stacktrace =====>>> $stacktrace");
                }
              },
            );
          },
        ),
      );
    });
  }
}
