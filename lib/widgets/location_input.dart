import 'package:flutter/material.dart';
import 'package:great_places/screens/maps_screen.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

   Future<void> _getCurrentUserLocation() async {
  final locData=await Location().getLocation();
  final staticMapImageUrl= LocationHelper.generateLocationPreviewImage(
  latitude:locData.latitude,
  longitude:locData.longitude,
);
setState(() {
  _previewImageUrl=staticMapImageUrl;
});
   }

   Future<void> _selectOnMap() async{
final selectedLocation= await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx)=> MapScreen(
        isSelecting: true,
      )),
  );
  if(selectedLocation==null){
    return;
  }
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container( 
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border:Border.all(width: 1, color:Colors.grey)
          ),
          child: _previewImageUrl==null?
          const Text('No Location Chosen',
          textAlign: TextAlign.center,)
          : Image.network(_previewImageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
        )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          TextButton.icon(
            onPressed:_getCurrentUserLocation , 
          icon:const Icon(Icons.location_on), 
          label: const Text('Current Location'),
          ),

          TextButton.icon(
            onPressed: _selectOnMap, 
          icon:const Icon(Icons.map), 
          label: const Text('Select on Map'),
          ),

        ],)
      ],
    );
  }
}