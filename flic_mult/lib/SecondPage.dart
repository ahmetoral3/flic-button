//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:flic_button/flic_button.dart';

//import 'main.dart';
import 'ButtonState.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonState = Provider.of<ButtonState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flic Button Plugin Example'),
      ),
      body: FutureBuilder(
        future: buttonState.flicButtonManager != null
            ? buttonState.flicButtonManager?.invokation
            : null,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // Not initialized yet, display initialization button
            return Center(
              child: ElevatedButton(
                onPressed: () => buttonState.startStopFlic2(),
                child: const Text('Start and initialize Flic2'),
              ),
            );
          } else {
            // Flic2 initialized, show buttons and scanning controls
            return Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Flic2 is initialized',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () => buttonState.startStopFlic2(),
                  child: const Text('Stop Flic2'),
                ),
                if (buttonState.flicButtonManager != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => buttonState.getButtons(),
                        child: const Text('Get Buttons'),
                      ),
                      ElevatedButton(
                        onPressed: () => buttonState.startStopScanningForFlic2(),
                        child: Text(
                          buttonState.isScanning ? 'Stop Scanning' : 'Scan for buttons',
                        ),
                      ),
                    ],
                  ),
                Text(
                  buttonState.no.toString(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the first page
                  },
                  child: Text('Go Back to First Page'),
                ),
                if (buttonState.isScanning)
                  const Text(
                      'Hold down your flic2 button so we can find it now we are scanning...'),
                Expanded(
                  child: ListView(
                    children: buttonState.buttonsFound.values
                        .map(
                          (e) => ListTile(
                            key: ValueKey(e.uuid),
                            leading: const Icon(Icons.radio_button_on, size: 48),
                            title: Text('FLIC2 @${e.buttonAddr}'),
                            subtitle: Column(
                              children: [
                                Text('${e.uuid}\n'
                                    'name: ${e.name}\n'
                                    'batt: ${e.battVoltage}V (${e.battPercentage}%)\n'
                                    'serial: ${e.serialNo}\n'
                                    'pressed: ${e.pressCount}\n'),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => buttonState.connectDisconnectButton(e),
                                      child: Text(e.connectionState == Flic2ButtonConnectionState.disconnected
                                          ? 'connect'
                                          : 'disconnect'),
                                    ),
                                    const SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () => buttonState.forgetButton(e),
                                      child: const Text('forget'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// class SecondPage extends StatefulWidget {
//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage>{
//   @override
//   Widget build(BuildContext context) {
//     final buttonState = Provider.of<ButtonState>(context);

//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Second Page'),
//           ),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//               onPressed: () {
//                 buttonState.startStopScanningForFlic2();
//               },
//               child: Text(
//                 buttonState.isScanning ? 'Stop Scanning' : 'Scan for Buttons',
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Button Press Count: ${buttonState.no}',
//               style: const TextStyle(fontSize: 18),
//             ),

//              const SizedBox(height: 20),
//             if (buttonState.buttonsFound.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: buttonState.buttonsFound.length,
//                   itemBuilder: (context, index) {
//                     final button = buttonState.buttonsFound.values.toList()[index];
//                     return ListTile(
//                       title: Text('FLIC2 @${button.buttonAddr}'),
//                       subtitle: Text(
//                         'UUID: ${button.uuid}\n'
//                         'Name: ${button.name}\n'
//                         'Battery: ${button.battVoltage}V (${button.battPercentage}%)\n'
//                         'Serial: ${button.serialNo}\n'
//                         'Press Count: ${button.pressCount}\n',
//                       ),
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               buttonState.connectDisconnectButton(button);
//                             },
//                             child: Text(
//                               button.connectionState == Flic2ButtonConnectionState.disconnected
//                                   ? 'Connect'
//                                   : 'Disconnect',
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           ElevatedButton(
//                             onPressed: () {
//                               buttonState.forgetButton(button);
//                             },
//                             child: Text('Forget'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//       )
//     );
//   }
// }
          // FutureBuilder(
          //   future: buttonState.flicButtonManager != null
          //       ? buttonState.flicButtonManager?.invokation
          //       : null,
          //   builder: (ctx, snapshot) {
          //     if (snapshot.connectionState != ConnectionState.done) {
          //       // are not initialized yet, wait a sec - should be very quick!
          //       return Center(
          //         child: ElevatedButton(
          //           onPressed: () => buttonState._startStopFlic2,
          //           child: const Text('Start and initialize Flic2'),
          //         ),
          //       );
          //     } else {
          //       // we have completed the init call, we can perform scanning etc
          //       return Column(
          //         children: [
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           const Text(
          //             'Flic2 is initialized',
          //             style: TextStyle(fontSize: 20),
          //           ),
          //           ElevatedButton(
          //             onPressed: () => _startStopFlic2(),
          //             child: const Text('Stop Flic2'),
          //           ),
          //           if (flicButtonManager != null)
          //             Row(
          //               // if we are started then show the controls to get flic2 and scan for flic2
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 ElevatedButton(
          //                     onPressed: () => _getButtons(),
          //                     child: const Text('Get Buttons')),
          //                 ElevatedButton(
          //                     onPressed: () => _startStopScanningForFlic2(),
          //                     child: Text(_isScanning
          //                         ? 'Stop Scanning'
          //                         : 'Scan for buttons')),
          //               ],
          //             ),
          //           Text(
          //             buttonState.no.toString(),
          //           ),
          //           SizedBox(height: 20),
          //          ElevatedButton(
          //           onPressed: () {
          //           Navigator.pop(context); // Navigate back to the first page
          //           },
          //           child: Text('Go Back to First Page'),
          //           ),
          //           if (_isScanning)
          //             const Text(
          //                 'Hold down your flic2 button so we can find it now we are scanning...'),
          //           // and show the list of buttons we have found at this point
          //           Expanded(
          //             child: ListView(
          //                 children: _buttonsFound.values
          //                     .map((e) => ListTile(
          //                           key: ValueKey(e.uuid),
          //                           leading:
          //                               const Icon(Icons.radio_button_on, size: 48),
          //                           title: Text('FLIC2 @${e.buttonAddr}'),
          //                           subtitle: Column(
          //                             children: [
          //                               Text('${e.uuid}\n'
          //                                   'name: ${e.name}\n'
          //                                   'batt: ${e.battVoltage}V (${e.battPercentage}%)\n'
          //                                   'serial: ${e.serialNo}\n'
          //                                   'pressed: ${e.pressCount}\n'),
          //                               Row(
          //                                 children: [
          //                                   ElevatedButton(
          //                                     onPressed: () =>
          //                                         _connectDisconnectButton(e),
          //                                     child: Text(e.connectionState ==
          //                                             Flic2ButtonConnectionState
          //                                                 .disconnected
          //                                         ? 'connect'
          //                                         : 'disconnect'),
          //                                   ),
          //                                   const SizedBox(width: 20),
          //                                   ElevatedButton(
          //                                     onPressed: () => _forgetButton(e),
          //                                     child: const Text('forget'),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ],
          //                           ),
          //                         ))
          //                     .toList()),
          //           ),
          //         ],
          //       );
          //     }
          //   },
          // )),
