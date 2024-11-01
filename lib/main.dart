import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ARViewPage(),
    );
  }
}

class ARViewPage extends StatefulWidget {
  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  void onARViewCreated(ARSessionManager arSessionManager, ARObjectManager arObjectManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "triangle.png",
      showWorldOrigin: true,
      handleTaps: true,
    );
    this.arObjectManager.onInitialize();
  }

  Future<void> addTree() async {
    var newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/tree.glb", // Path to your tree model
      scale: Vector3(0.5, 0.5, 0.5),
      position: Vector3(0.0, 0.0, 0.0),
    );
    await arObjectManager.addNode(newNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AR Tree Example")),
      body: ARView(
      onARViewCreated: onARViewCreated, // Pass the callback here
   ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTree,
        child: const Icon(Icons.add),
      ),
    );
  }
}