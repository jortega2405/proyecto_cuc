import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:proyecto_cuc/components/geo_fire.dart';

class MapController {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialPosition = CameraPosition(
    target: LatLng(10.99236, -74.787066),
    zoom: 14.0
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker> {};

  Position _position;
  StreamSubscription<Position> _positionStream;
  BitmapDescriptor marker;

  GeofireProvider _geofireProvider;
  bool isConnect = false;

  StreamSubscription<DocumentSnapshot> _statusSuscription;
  

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _geofireProvider = new GeofireProvider();
    marker = await createMarkerImageFromAssets('assets/images/grupo-de-chat.png');
    checkGPS();
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }

  void dispose(){

    _positionStream?.cancel();
    _statusSuscription?.cancel();
  }

  void onMapCreated(GoogleMapController controller){
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    _mapController.complete(controller);
  }

  void saveLocation() async {
    await _geofireProvider.create( _position.latitude, _position.longitude);
  }

  void connect(){
    if (isConnect) {
      isConnect = false;
      disconnect();
    }else{
      isConnect = true;
      updateLocation();
    }
  }

  void disconnect(){
    _positionStream?.cancel();
  }

  void checkIfIsConnect(){
    Stream<DocumentSnapshot> status = _geofireProvider.getLocationByIdStream();

    _statusSuscription = status.listen((DocumentSnapshot document) {
      if (document.exists) {
        isConnect = true;
      }else{
        isConnect = false;
      }

      refresh();
     });
  }



  void updateLocation() async {
    try {
      await _determinePosition();
      _position = await Geolocator.getLastKnownPosition();
      centerPosition();
      getNearbyUsers();
      saveLocation();
      addMarker(
        'person',
        _position.latitude,
        _position.longitude,
        'Tu Posición',
        '',
        marker
      );
      refresh();
      _positionStream = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.best,
        distanceFilter: 1
      ).listen((Position position) {
        _position = position;
        addMarker(
        'person',
        _position.latitude,
        _position.longitude,
        'Tu Posición',
        '',
        marker,

        );
        animateCameraToPosition(position.latitude, position.longitude);
        saveLocation();
        refresh();
      });
    } catch (error) { 
      print('Error en la localizacion: $error');
    }
  }

  void getNearbyUsers(){
    Stream<List<DocumentSnapshot>> stream = _geofireProvider.getNearbyUsers(_position.latitude, _position.longitude, 20);
    
    stream.listen((List<DocumentSnapshot> documentList) { 

      for (MarkerId m in markers.keys) {
        bool remove = true;

        for(DocumentSnapshot d in documentList){
          if (m.value == d.id) {
            remove = false;
          }
        }
        if (remove) {
          markers.remove(m);
          refresh();
        }

        for(DocumentSnapshot d in documentList){
          GeoPoint point = d.data()['position']['geopoint'];
          addMarker(
            'person',
            point.latitude,
            point.longitude,
            "Usuario X",
            '',
            marker
          );
        }
        
      }
    });
  }

  void centerPosition() {
    if (_position != null ) {
      animateCameraToPosition(_position.latitude, _position.longitude);
          }else{
            displayToastMessage('Activa el GPS para obtener la posicion', context);
          }
        }
      
        void checkGPS() async{
          bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
          if (isLocationEnabled) {
            print("GPS activado");
            updateLocation();
            checkIfIsConnect();
          }
          else{
            print("GPS desactivado"); 
            bool locationGps = await location.Location().requestService();
            if (locationGps) {
              updateLocation();
              checkIfIsConnect();
              print("Usuario activó GPS");
            }
          }
        }
      
        Future<Position> _determinePosition() async {
        bool serviceEnabled;
        LocationPermission permission;
      
        // Test if location services are enabled.
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // Location services are not enabled don't continue
          // accessing the position and request users of the 
          // App to enable the location services.
          return Future.error('Location services are disabled.');
        }
      
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // Permissions are denied, next time you could try
            // requesting permissions again (this is also where
            // Android's shouldShowRequestPermissionRationale 
            // returned true. According to Android guidelines
            // your App should show an explanatory UI now.
            return Future.error('Location permissions are denied');
          }
        }
        
        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately. 
          return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
        } 
      
        // When we reach here, permissions are granted and we can
        // continue accessing the position of the device.
        return await Geolocator.getCurrentPosition();
        }
      
        displayToastMessage(String message, BuildContext context){
        Fluttertoast.showToast(msg: message);
      }
      
    void animateCameraToPosition(double latitude, double longitude) async {
      GoogleMapController controller = await _mapController.future;
      if (controller != null) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(latitude, longitude),
            zoom: 17,
          ),
        ));
        
      }
    }

  Future<BitmapDescriptor> createMarkerImageFromAssets(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapDescriptor = 
      await BitmapDescriptor.fromAssetImage(configuration, path);
      return bitmapDescriptor;
  }
   void addMarker(String markerId, double lat, double lng, String title, String content, BitmapDescriptor iconMarker) {
     MarkerId id = MarkerId(markerId);
     Marker marker = Marker(
       markerId: id,
       icon: iconMarker,
       position: LatLng(lat, lng),
       infoWindow: InfoWindow(title: title, snippet: content),
       draggable: false,
       zIndex: 2,
       flat: true,
       anchor: Offset(0.5, 0.5),
       rotation: _position.heading,
     );
    
    markers[id] = marker;

   }


}