import 'package:flutter/material.dart';
import 'package:water_tracker_app/Model/WaterTrack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController(text: "1");

  List<WaterTrackModel> _waterTrackerList = [];
  int _totalGlassOfWater = 0;


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracker"),
      ),
      body: Column(
        children: [
          _buildWaterTrackCounter(),

          _buildWaterTrackerList(),
        ],
      ),
    );
  }



  Widget _buildWaterTrackCounter(){
    return Column(
      children: [
        Text("$_totalGlassOfWater", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("Glass/s"),

        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(width: 15),

            ElevatedButton(
                onPressed: _addNewWaterTrack,
                child: const Text("Add")
            ),

          ],
        ),
      ],
    );
  }

  Widget _buildWaterTrackerList(){
    return Expanded(
      child: ListView.separated(
        itemCount: _waterTrackerList.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          WaterTrackModel waterTrackModel = _waterTrackerList[index];
          return ListTile(
            leading: CircleAvatar(child: Text("${waterTrackModel.noOfGlasses}")),
            title: Text("${waterTrackModel.dateTime.hour}:${waterTrackModel.dateTime.minute}:${waterTrackModel.dateTime.second}"),
            subtitle: Text("${waterTrackModel.dateTime.day}/${waterTrackModel.dateTime.month}:${waterTrackModel.dateTime.year}"),
            trailing: CircleAvatar(
              child: IconButton(
                onPressed: () => _removeWaterOfGlassItem(index),
                icon: const Icon(Icons.delete)
              ),
            ),
          );
        },
      ),
    );
  }

  void _addNewWaterTrack(){
    if(_textEditingController.text.isEmpty){
      _textEditingController.text = "1";
    }

    final int noOfGlasses = int.tryParse(_textEditingController.text) ?? 1;
    WaterTrackModel waterTrackModel = WaterTrackModel(noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    _totalGlassOfWater += noOfGlasses;

    _waterTrackerList.add(waterTrackModel);
    setState(() {

    });
  }

  void _removeWaterOfGlassItem(int index){
    setState(() {
      _waterTrackerList.removeAt(index);
    });
  }
}
