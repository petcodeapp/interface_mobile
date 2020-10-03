import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/services/image_marker_service.dart';
import 'package:petcode_app/utils/map_constants.dart';

class ImageMarkerProvider extends ChangeNotifier {
  List<BitmapDescriptor> _markerImages;
  ImageMarkerService _imageMarkerService;

  List<BitmapDescriptor> get markerImages => _markerImages;

  ImageMarkerProvider() {
    _imageMarkerService = new ImageMarkerService();
  }

  void setImages(List<String> urls) async {
    List<Future<BitmapDescriptor>> descriptors =
        new List<Future<BitmapDescriptor>>();
    for (int i = 0; i < urls.length; i++) {
      print('url index: ' + i.toString());
      descriptors.add(_imageMarkerService.getMarkerIcon(urls[i], Size(75, 75), MapConstants.markerColors[i]));
    }
    _markerImages = await Future.wait(descriptors);
    notifyListeners();
  }

  void clear() {
    _markerImages.clear();
    notifyListeners();
  }
}
