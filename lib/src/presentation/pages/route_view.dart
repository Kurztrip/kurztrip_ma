import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';

class RouteView extends StatefulWidget {
  final Function onDelete;
  final TrackingRoute? route;

  const RouteView({Key? key, required this.onDelete, this.route})
      : super(key: key);
  @override
  _RouteViewState createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  final Map<String, Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      for (int i = 0; i < widget.route!.p_latitudes!.length; i++) {
        final Marker marker = Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(
              widget.route!.p_latitudes![i], widget.route!.p_longitudes![i]),
        );
        _markers[i.toString()] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(onPressed: widget.onDelete(), icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers.values.toSet(),
            initialCameraPosition:
                CameraPosition(target: const LatLng(4.63, -74.07), zoom: 11.0)),
      ),
    );
  }
}
