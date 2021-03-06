import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeofireProvider {
  CollectionReference _ref;
  Geoflutterfire _geo;

  GeofireProvider(){
    _ref = FirebaseFirestore.instance.collection('Locations');
    _geo = Geoflutterfire();
  }

  Stream<DocumentSnapshot> getLocationByIdState(){
    return _ref.doc().snapshots(includeMetadataChanges: true);
  }

  Future<void> create(double lat, double lng){
    GeoFirePoint myLocation = _geo.point(latitude: lat, longitude: lng);
    return _ref.doc().set({'status': 'users_available', 'position': myLocation.data});
  }

  Future<void> delete(String id){
    return _ref.doc(id).delete();
  }

  Stream<DocumentSnapshot> getLocationByIdStream() {}

}