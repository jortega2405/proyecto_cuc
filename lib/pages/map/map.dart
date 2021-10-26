import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_cuc/pages/map/components/button_drawer.dart';
import 'package:proyecto_cuc/pages/map/components/center_position.dart';
import 'package:proyecto_cuc/pages/map/components/map_controller.dart';
import 'package:proyecto_cuc/widgets/widgets.dart';

class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

MapController _con = new MapController();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    
  }

  @override
  void dispose(){
    super.dispose();
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonDrawer(),
                    CenterPosition(),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 70, right: 70),
                  child: RaisedButton(
                              color: _con.isConnect ? Colors.grey[200]: Colors.grey[800].withOpacity(0.5),
                              textColor: Colors.white,
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    _con.isConnect ? "DESCONECTARSE" : "CONECTARSE",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: () {
                                _con.connect;
                              },
                            ),
                ),
              ],
            ),
          )
        ],  
      ),
    );
  }

  Widget _googleMapsWidget (){
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),

    );
  }

  void refresh(){
    setState(() {
      
    });
  }
}