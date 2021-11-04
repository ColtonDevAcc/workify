import 'package:fitstack/theme/theme.dart';
import 'package:flutter/material.dart';

import '../repositories/muscleModel_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import '../models/recovery/recovery_model.dart';
import '../repositories/customExceptions.dart';

final MuscleListControllerProvider =
    StateNotifierProvider<MuscleListController, AsyncValue<List<Muscle>>>((ref) {
  return MuscleListController(ref.read, '');
});

final groupListExceptionProvider = StateProvider<CustomException?>((_) => null);

class MuscleListController extends StateNotifier<AsyncValue<List<Muscle>>> {
  final Reader read;
  final String? userId;
  List<Muscle> muscleList = [
    Muscle('modelBackground', PrimaryMuscleGroups.empty, Colors.black, Colors.blue,
        "m 309.66,2282.11 -5.84,-3.24 a 33.87,33.87 0 0 1 -7.13,-6.48 c -0.65,-0.65 -0.65,-1.3 -1.3,-1.95 l -5.18,-3.24 c -12.32,-8.43 -13,-21.39 -7.78,-33.71 5.83,-15.56 16.2,-31.12 25.28,-44.73 a 492.72,492.72 0 0 1 43.44,-53.82 c 49.92,-57.05 47.33,-127.07 38.25,-198.38 -6.48,-48 -11.67,-96.6 -14.26,-145.23 -1.95,-36.3 -2.6,-73.9 0.64,-110.86 a 498.56,498.56 0 0 0 -0.64,-82.33 v 0 -0.65 a 317,317 0 0 0 -16.86,-88.17 c -34.36,-64.19 -31.12,-140.69 -16.21,-210.06 v 0 a 1175.26,1175.26 0 0 0 32.42,-195.79 c 0.65,-31.12 4.54,-67.43 17.5,-96 -4.54,-16.21 -3.24,-33.07 0,-49.28 6.49,-40.19 7.13,-82.33 -3.89,-121.88 q -9.72,-31.12 -21.39,-62.24 c -3.24,7.13 -6.49,14.26 -9.08,20.75 -9.08,18.15 -19.45,36.3 -29.82,53.16 -2.6,65.48 -38.25,130.31 -75.86,182.18 v 0 l -0.64,0.65 a 253.61,253.61 0 0 0 -22.05,29.82 c -10.37,15.56 -20.09,32.41 -29.17,48.62 v 0.65 0 c -6.48,9.73 -9.08,21.4 -9.08,33.07 0.65,24.63 -3.89,49.92 -11.67,73.26 v 0.64 h -0.65 c -7.78,19.45 -15.56,38.25 -23.33,57.7 -3.89,10.38 -10.38,22.05 -22.7,22.05 h -1.94 l -1.95,-1.3 a 4.94,4.94 0 0 1 -2.59,-1.3 c -3.89,11.67 -11,25.94 -25.93,25.29 l -2,-0.65 -1.29,-0.65 a 14.49,14.49 0 0 1 -6.49,-5.83 c -4.54,5.83 -10.37,10.37 -18.15,11 h -2.54 l -2,-0.65 c -9.72,-5.19 -12.32,-14.91 -11.67,-25.28 l -1.29,1.29 h -1.9 c -10.37,2 -18.15,-2.59 -21.39,-13 v 0 c -3.25,-12.32 2.59,-32.42 6.48,-44.09 8.43,-24.64 16.86,-49.92 24.64,-75.21 -1.95,0.65 -3.25,2 -5.19,3.89 -9.73,13 -23.34,19.45 -39.55,15.56 h -1.3 C 7.54,1181.16 3,1173.38 3,1163.69 v -4.54 l 4.54,-1.94 c 6.48,-3.89 12.32,-9.73 16.85,-15.56 19.45,-25.93 58.35,-42.79 88.18,-53.16 9.07,-14.27 16.2,-29.83 22,-45.39 7.78,-22.69 13.61,-45.38 18.8,-68.72 C 158.6,909 179.34,849.33 217,795.52 c 5.18,-42.15 23.34,-81 46.67,-116.7 -3.24,-36.31 -1.29,-75.21 13.62,-108.92 v 0 -0.65 c 25.93,-50.57 84.93,-69.37 137.44,-76.5 25.29,-6.48 73.26,-20.75 72.61,-54.46 -1.29,-18.15 -2.59,-36.3 -3.89,-55.11 A 139.76,139.76 0 0 1 478.92,367.62 18.2,18.2 0 0 1 473,367 c -18.15,-3.25 -22.69,-35.66 -24,-50.57 v 0 -0.65 c -0.64,-8.43 0.65,-18.8 7.78,-24 -7.13,-27.23 -9.07,-57.7 6.49,-83 -16.21,-16.21 -21.4,-38.25 -19.45,-61.59 l 0.65,-17.51 13,12.32 c 9.08,9.08 21.4,7.78 33.07,4.54 40.84,-22.69 84.93,-22.05 128.36,-7.78 h 0.65 a 70.6,70.6 0 0 1 25.93,17.5 c 13,15.56 16.86,35 16.86,54.46 14.91,25.29 14.26,55.11 7.78,83 5.19,5.18 6.48,14.26 6.48,22 v 0.65 0 c -1.94,14.91 -6.48,47.32 -24.63,50.57 a 16.33,16.33 0 0 1 -5.19,0.64 c -1.94,5.19 -3.24,10.38 -5.19,15.56 -1.29,18.81 -2.59,37 -3.88,55.11 -0.65,33.71 47.32,48 72.61,54.46 52.51,7.13 111.51,25.93 137.44,76.5 v 0.65 0 c 14.91,33.71 16.86,72.61 13.62,108.92 23.33,35.66 41.49,74.55 46.67,116.7 37.61,53.85 58.35,113.52 64.19,178.97 4.54,23.34 10.37,46 18.8,68.72 a 207.48,207.48 0 0 0 21.39,45.39 c 30.47,10.37 68.73,27.23 88.18,53.16 4.53,5.83 10.37,11.67 16.85,15.56 l 4.54,1.94 v 4.54 c 0,9.73 -4.54,17.51 -13,22 h -1.94 c -16.21,3.89 -29.82,-2.59 -39.55,-15.56 a 10.12,10.12 0 0 0 -5.19,-3.89 c 7.78,25.29 16.21,50.57 24.64,75.21 3.89,11.67 9.73,31.77 6.48,44.09 v 0 c -2.59,10.37 -11,14.91 -21.39,13 h -1.95 l -1.29,-1.29 c 0.65,10.37 -1.95,20.09 -11.67,25.28 l -2,0.65 h -2.59 c -7.78,-0.65 -13.62,-5.19 -18.15,-11 -1.3,1.94 -3.24,4.53 -5.84,5.83 l -1.94,0.65 -2,0.65 c -14.91,0.65 -22,-13.62 -25.93,-25.29 a 4.94,4.94 0 0 1 -2.59,1.3 l -2,1.3 h -1.94 c -12.32,0 -18.81,-11.67 -22.7,-22.05 -7.78,-19.45 -15.55,-38.25 -23.33,-57.7 v 0 l -0.65,-0.64 c -7.78,-23.34 -12.32,-48.63 -11.67,-73.26 0,-11.67 -2.6,-23.34 -9.08,-33.07 v 0 -0.65 c -9.08,-16.21 -18.8,-33.06 -29.17,-48.62 -6.49,-10.37 -13.62,-20.75 -22,-29.82 v -0.65 h -0.64 c -37,-51.87 -73.27,-116.7 -75.86,-182.18 -10.37,-16.86 -20.74,-35 -29.17,-53.16 a 200.83,200.83 0 0 1 -9.08,-20.75 c -8.43,20.75 -15.56,40.85 -22,61.59 -11,40.2 -10.38,82.34 -3.89,122.53 3.24,16.21 4.54,33.07 0,49.28 13,28.52 16.85,64.83 17.5,96 5.84,66.13 16.21,131.61 32.42,195.79 v 0 c 14.91,69.37 18.15,145.87 -16.21,210.06 a 371.89,371.89 0 0 0 -16.86,88.17 v 0.65 0 a 498.56,498.56 0 0 0 -0.64,82.33 c 3.24,37 2.59,74.56 0.64,110.86 -2.59,48.63 -7.78,97.25 -14.26,145.23 -9.08,71.31 -11.67,141.33 38.25,198.38 a 492.72,492.72 0 0 1 43.44,53.82 c 9.08,13.61 19.45,29.17 25.28,44.73 5.19,12.32 4.54,25.28 -7.78,33.71 l -5.18,3.24 c 0,0.65 -0.65,1.3 -1.3,1.95 a 33.87,33.87 0 0 1 -7.13,6.48 l -5.84,3.24 -1.94,1.95 a 21.58,21.58 0 0 1 -13.62,7.13 h -0.64 c -5.19,5.83 -12.32,7.13 -20.1,6.48 v 0.65 l -1.3,1.95 -1.29,0.64 c -12.32,8.43 -25.29,9.73 -38.9,3.25 l -0.65,-0.65 h -0.65 c -8.43,-7.13 -13.62,-16.86 -16.21,-27.23 -14.26,-7.78 -19.45,-16.86 -22.69,-33.71 v -0.65 0 c -1.94,-23.34 -15.56,-44.09 -33.71,-57.7 -28.53,-16.86 -38.25,-39.55 -32.42,-72 2.6,-12.31 3.89,-24.63 5.84,-36.95 Q 640,2052 641,2028.62 a 407,407 0 0 0 1.29,-48.62 c -0.65,-12.32 -1.94,-25.94 -5.18,-37.61 v -0.64 0 c -12.32,-51.22 -22,-103.74 -25.29,-156.25 -2.59,-38.25 -1.94,-79.09 6.49,-117.35 -11,-51.86 -19.45,-104.38 -25.29,-156.89 a 1077.61,1077.61 0 0 0 -17.5,-111.51 v 0 c -7.78,-46.68 -10.38,-94.65 -4.54,-141.33 0,-3.89 -0.65,-10.38 -3.89,-13 -1.3,-1.3 -3.24,-1.3 -4.54,-1.3 -1.3,0 -3.24,0 -4.54,1.3 -3.24,2.59 -3.24,9.08 -3.24,13 5.19,46.68 2.59,94.65 -5.19,141.33 v 0 A 1077.61,1077.61 0 0 0 532,1511.26 c -5.19,52.51 -14.26,105 -25.29,156.89 9.08,38.26 9.73,79.1 7.14,117.35 -3.89,52.51 -13.62,105 -25.94,156.25 v 0 0.64 c -3.24,11.67 -4.54,25.29 -4.54,37.61 a 408.77,408.77 0 0 0 0.65,48.62 c 0.65,15.56 2.6,31.12 3.89,46.68 q 2.93,18.48 5.84,36.95 c 6.48,32.42 -3.89,55.11 -32.42,72 -18.15,13.61 -31.77,34.36 -33.71,57.7 v 0 0.65 c -3.24,16.85 -8.43,25.93 -22,33.71 -3.25,10.37 -8.43,20.1 -16.86,27.23 h -0.65 l -0.65,0.65 c -13.61,6.48 -26.58,5.18 -38.9,-3.25 l -1.29,-0.64 -1.3,-1.95 v -0.65 c -7.13,0.65 -14.91,-0.65 -20.1,-6.48 h -0.65 a 23.33,23.33 0 0 1 -13.61,-7.13 l -1.94,-1.95 z M 562.5,1235.72 c -11,0.65 -16.21,7.78 -16.21,23.34 5.19,42.15 3.24,88.82 -4.54,139.39 -7.13,33.72 -13,71.32 -17.5,112.16 a 1527.93,1527.93 0 0 1 -25.93,157.54 c 15.56,65.48 9.72,155.6 -18.16,271.65 -11.67,40.84 -1.94,131.61 5.84,174.4 5.18,25.93 -1.3,46.68 -29.18,63.53 -19.45,14.27 -35,37 -36.95,63.54 -3.24,16.21 -7.78,22.69 -21.39,29.82 -3.25,11.67 -7.78,20.75 -14.92,25.93 -10.37,5.19 -20.09,3.89 -30.47,-2.59 -6.48,-10.37 -3.24,-24 10.38,-40.84 -13.62,13.61 -19.45,25.28 -16.86,36.3 -20.75,1.3 -22,-13 -3.24,-42.79 -11,11 -16.21,23.34 -16.86,35.66 -15.56,-1.94 -19.45,-20.1 -0.65,-48 -12.31,12.31 -16.85,23.34 -17.5,36.95 -12.32,-7.13 -11.67,-26.58 3.24,-46 -11,11 -16.86,22.69 -16.86,34.36 -7.78,-5.19 -9.07,-13 -4.53,-24 8.42,-21.39 34.36,-60.29 66.77,-95.3 52.52,-60.29 49.92,-132.91 40.2,-204.87 q -21.39,-162.4 -13.62,-254.79 c 1.95,-28.53 1.95,-57 -0.64,-83.63 a 325.89,325.89 0 0 0 -17.51,-91.42 C 336.88,1452.9 332.35,1384.18 349.85,1301.2 a 1190.83,1190.83 0 0 0 32.42,-197.09 c 1.29,-41.5 7.78,-73.26 18.15,-96 -3.89,-14.26 -4.54,-29.82 -0.65,-48 q 11.67,-70 -3.89,-126.42 a 883.13,883.13 0 0 0 -30.47,-83 c -5.19,22 -20.75,53.81 -46,95.3 -1.3,52.52 -25.93,112.81 -73.91,178.94 -13,14.26 -30.47,41.49 -52.51,80.39 -6.49,11 -9.73,23.34 -9.73,37.61 0.65,22 -3.24,45.38 -11.67,70.66 0,0 -7.78,19.45 -24,57.7 -3.89,11.67 -8.43,16.86 -14.92,16.86 -4.53,-2 -3.89,-8.43 -2.59,-15.56 5.84,-18.15 8.43,-33.07 13.62,-46.68 q -2,-3.88 -5.84,0 c 0,0 -6.48,21.39 -18.8,63.54 -4.54,14.91 -10.37,22 -18.15,21.39 -5.19,-2.59 -4.54,-10.37 -3.25,-20.75 4.54,-20.09 10.38,-35.65 17.51,-66.12 -1.3,-3.25 -2.59,-3.89 -5.19,-2 l -23.34,79.74 c -3.24,8.43 -8.42,12.32 -14.91,13.62 -6.48,-3.24 -8.43,-10.37 -7.13,-20.75 7.13,-27.23 15.56,-54.46 25.28,-82.33 -0.64,-3.89 -2.59,-4.54 -5.18,-3.25 -5.2,11.81 -11.7,30 -18.16,55.25 -3.89,13.62 -9.08,22 -14.92,26.58 -6.48,1.3 -10.37,-1.29 -12.31,-7.13 -2,-7.78 0.64,-20.75 6.48,-39.55 q 19.46,-57.37 29.17,-89.46 c -11,1.29 -18.8,4.53 -23.34,10.37 -9.07,11.67 -19.45,15.56 -31.76,13 -5.84,-2.59 -8.43,-7.13 -8.43,-13.61 6.48,-3.89 13,-9.72 19.45,-18.15 14.26,-19.45 43.44,-36.31 86.87,-51.22 17.51,-25.93 32.42,-66.13 43.44,-119.29 5.19,-66.13 26.58,-125.13 63.54,-177 3.89,-37.61 20.09,-77.15 47.32,-117.35 -4.54,-43.44 0,-79.74 13,-108.27 19.45,-38.9 63.53,-62.88 131.61,-72.61 53.16,-13 79.74,-33.71 79.09,-62.24 0,0 -1.29,-18.8 -3.89,-57.05 A 123.67,123.67 0 0 1 484.7,356 c -14.26,10.37 -23.34,-3.25 -27.88,-40.2 0,-13 3.25,-18.8 10.38,-18.15 v 0 c -12.32,-38.9 -9.73,-68.73 6.48,-90.12 -16.21,-13 -23.34,-33.06 -22,-59.65 10.37,10.38 24.63,12.32 42.14,5.84 35,-20.1 75.85,-22 122.53,-7.13 26.58,10.37 38.9,32.41 37.6,66.77 14.27,21.4 16.21,49.28 7.13,84.29 4.54,1.29 7.14,7.13 7.14,18.15 -4.54,36.95 -13.62,50.57 -27.88,40.2 a 92.79,92.79 0 0 1 -7.13,25.28 c -2.6,38.25 -3.89,57.05 -3.89,57.05 q -1,42.79 79.74,62.24 c 67.43,9.73 111.51,33.71 131.61,72.61 14.26,33.07 16.21,72 12.32,108.27 27.87,40.2 43.43,79.74 47.32,117.35 37,51.86 58.35,110.86 63.54,177 11,53.16 25.93,93.36 43.44,119.29 43.43,14.91 72.61,31.77 86.87,51.22 6.49,8.43 13,14.26 19.45,18.15 0.65,6.48 -2.59,11 -8.43,13.61 -12.31,2.6 -22.69,-1.29 -31.76,-13 -4.54,-5.84 -12.32,-9.08 -22.7,-10.37 5.84,21.39 15.56,51.21 28.53,89.46 6.48,18.8 8.43,31.77 6.48,39.55 -1.94,5.84 -5.83,8.43 -12.31,7.13 -5.84,-4.54 -11,-13 -14.27,-26.58 -10.37,-29.17 -12.32,-37.6 -18.8,-55.11 -2.59,-1.29 -4.54,-0.64 -5.18,3.25 9.72,27.87 18.15,55.1 25.28,82.33 1.3,10.38 -0.65,17.51 -7.13,20.75 -6.49,-1.3 -11,-5.19 -14.91,-13.62 -15.56,-53.16 -22.69,-79.74 -22.69,-79.74 -2.6,-1.94 -4.54,-1.3 -5.84,2 7.78,33.06 13.62,45.38 18.15,65.48 1.3,9.72 1.3,18.8 -3.89,21.39 -7.78,0.65 -13.61,-6.48 -18.15,-21.39 -12.32,-42.15 -18.8,-63.54 -18.8,-63.54 q -3.89,-3.88 -5.84,0 c 5.19,13.61 7.78,28.53 13.62,46.68 1.3,7.13 1.94,13.61 -2.59,15.56 -5.84,0 -11,-5.19 -14.92,-16.86 -15.56,-38.25 -24,-57.7 -24,-57.7 -8.43,-25.28 -12.32,-48.62 -11,-70.66 A 72.54,72.54 0 0 0 932,1105.41 c -22,-38.9 -39.55,-66.13 -52.51,-80.39 -48,-66.13 -72.61,-126.42 -73.91,-178.94 -25.28,-41.49 -40.84,-73.26 -46,-95.3 a 883.13,883.13 0 0 0 -30.47,83 q -15.55,56.4 -3.89,126.42 c 3.89,18.15 3.24,33.71 -0.65,48 10.37,22.7 16.86,54.46 18.15,96 a 1190.83,1190.83 0 0 0 32.42,197.09 c 18.15,83 13,151.7 -15.56,204.86 a 325.89,325.89 0 0 0 -17.51,91.42 c -2.59,26.58 -2.59,55.1 -0.64,83.63 q 7.77,92.39 -13.62,254.79 c -9.72,72 -12.32,144.58 40.2,204.87 32.41,35 58.35,73.91 66.77,95.3 4.54,11 3.25,18.8 -4.53,24 0,-11.67 -5.84,-23.34 -16.86,-34.36 14.91,19.45 16.21,38.9 3.24,46 -0.65,-13.61 -5.19,-24.64 -17.5,-36.95 18.8,27.87 14.91,46 -0.65,48 -0.65,-12.32 -5.84,-24.63 -16.86,-35.66 18.8,29.83 17.51,44.09 -3.24,42.79 2.59,-11 -3.24,-22.69 -16.86,-36.3 13.62,16.85 16.86,30.47 10.38,40.84 -10.38,6.48 -20.1,7.78 -30.47,2.59 -7.14,-5.18 -11.67,-14.26 -14.92,-25.93 -13.61,-7.13 -18.15,-13.61 -21.39,-29.82 -1.94,-26.58 -17.5,-49.27 -37,-63.54 -27.88,-16.85 -34.36,-37.6 -29.18,-63.53 7.78,-42.79 17.51,-133.56 5.84,-174.4 -27.88,-116 -33.72,-206.17 -18.16,-271.65 a 1527.93,1527.93 0 0 1 -25.93,-157.54 998.13,998.13 0 0 0 -17.5,-112.16 c -7.78,-50.57 -9.73,-97.24 -4.54,-139.39 0,-15.56 -5.19,-22.69 -16.21,-23.34 z"),
    Muscle('hand', PrimaryMuscleGroups.hand, Apptheme.mainButonColor, Colors.blue,
        "m 167,1117.73 c 9.08,10.37 9.73,35.66 1.95,73.91 -1.95,7.78 -6.48,13 -14.26,14.26 -16.86,2.6 -39.55,-0.65 -67.43,-10.37 -8.43,-1.3 -11.67,-6.48 -9.07,-14.26 3.88,-13 5.18,-24 3.24,-33.07 -20.1,-2.59 -25.94,-8.43 -16.86,-17.5 a 198.18,198.18 0 0 1 57.7,-25.29 c 16.86,-1.94 31.77,1.95 44.73,12.32 z"),
    Muscle('Left_ForeArm', PrimaryMuscleGroups.forearms, Apptheme.mainButonColor, Colors.blue,
        "m 229.91,816.91 c 5.19,-5.19 10.38,-0.65 14.26,14.26 q 34.05,198.39 -91.41,258 -18.48,8.76 -7.78,-13.61 c 17.51,-34.36 28.53,-73.26 33.07,-117.35 3.89,-48.62 20.74,-96 51.86,-141.33 z"),
    Muscle(
        'Left_Inner_ForeArm',
        PrimaryMuscleGroups.brachioradialis,
        Apptheme.mainButonColor,
        Colors.blue,
        "m 270.11,853.86 c 19.45,-20.09 31.77,-25.28 35.66,-14.26 4.53,37.6 -8.43,79.74 -38.26,127.07 -7.13,9.08 -10.37,7.78 -8.42,-2.59 A 340.87,340.87 0 0 0 263,875.26 c -0.65,-9.08 1.94,-16.21 7.13,-21.4 z"),
    Muscle('bicept', PrimaryMuscleGroups.biceps, Apptheme.mainButonColor, Colors.blue,
        "m 368,717.07 c -17.5,38.9 -40.84,71.31 -70.66,97.9 -22.69,16.2 -37.61,10.37 -44.09,-17.51 q -11.67,-42.8 31.12,-105 c 5.84,-6.48 13.62,-9.72 22.69,-10.37 29.82,-4.54 44.74,-6.48 44.74,-6.48 23.34,-5.19 28.52,8.42 16.2,41.49 z"),
    Muscle('shoulders', PrimaryMuscleGroups.deltoids, Apptheme.mainButonColor, Colors.blue,
        "m 527.49,558.23 c 25.93,-4.54 30.47,-9.72 14.26,-14.91 -54.46,-18.15 -108.27,-24 -162.72,-16.86 -60.95,13 -92.07,55.11 -92.71,126.43 -0.65,22 7.13,26.58 22,12.31 44.08,-57.05 116.7,-92.71 219.13,-107 z"),
    Muscle('shoulders', PrimaryMuscleGroups.trapezius, Apptheme.mainButonColor, Colors.blue,
        "m 541.11,526.46 c 7.13,4.54 11,2.6 13,-6.48 1.95,-21.39 0,-35 -5.83,-41.49 -20.1,-11.67 -34.36,-32.42 -42.14,-62.24 -3.25,-5.19 -5.19,-5.19 -6.49,0 1.95,25.28 0.65,42.79 -3.89,51.86 -9.72,11.67 -24.63,22.05 -43.43,30.48 -6.49,5.18 -4.54,8.42 5.83,9.07 37.6,3.89 65.48,9.73 83,18.8 z"),
    Muscle('chest', PrimaryMuscleGroups.pectorals, Apptheme.mainButonColor, Colors.blue,
        "m 550.83,759.21 c 0,22 -11,27.88 -33.71,18.15 -70.67,-29.82 -118,-71.31 -141.34,-123.18 -4.53,-11.67 -3.24,-20.74 3.25,-26.58 31.76,-24.64 68.07,-37 108.91,-37.6 39.55,1.3 60.3,20.1 62.89,56.4 z"),
    Muscle('obliques', PrimaryMuscleGroups.obliques, Apptheme.mainButonColor, Colors.blue,
        "m 471.09,1060 c -7.78,-51.87 -9.08,-117.35 -5.19,-195.79 -4.54,-61.59 -24.64,-109.57 -59.65,-143.93 -10.37,-12.32 -18.15,-11.67 -23.33,1.3 -6.49,13 -5.84,25.93 1.29,38.25 24.64,53.16 37,111.51 37,175.69 -6.49,35.66 -7.14,67.43 -1.3,94 3.24,13.61 34.36,83 46,81.69 9.73,-1.3 7.78,-41.5 5.19,-51.22 z"),
    Muscle('outterQuad', PrimaryMuscleGroups.vastusLateralist, Apptheme.mainButonColor, Colors.blue,
        "m 434.13,1161.17 c -25.93,140 -37.6,243.12 -35.65,309.9 -3.25,42.14 -13.62,37.6 -31.77,-13 -15.56,-53.81 -10.38,-127.72 17.5,-222.38 a 955.44,955.44 0 0 0 15.56,-112.8 c 3.24,-19.45 9.73,-24 18.8,-14.27 q 23.34,21.4 15.56,52.52 z"),
    Muscle('quads', PrimaryMuscleGroups.quadriceps, Apptheme.mainButonColor, Colors.blue,
        "m 499.61,1556 c 11.67,-93.35 23.34,-191.25 34.36,-294.33 0,-14.27 -2.59,-27.88 -7.78,-39.55 q -21.39,-30.15 -54.45,-56.4 c -11,-8.43 -19.45,-2 -24.64,18.8 -30.47,156.24 -34.36,276.83 -12.32,363.06 30.47,115.4 51.87,118.64 64.83,8.42 z"),
    Muscle('calves', PrimaryMuscleGroups.calves, Apptheme.mainButonColor, Colors.blue,
        "m 457.47,1939.8 c -15.56,57.7 -27.88,57 -38.25,-2.59 -18.15,-103.73 -20.74,-204.87 -8.43,-302.12 4.54,-20.75 14.27,-25.28 28.53,-13.61 30.47,42.78 45.38,90.11 46.68,142 -5.84,65.48 -15.56,124.47 -28.53,176.34 z"),
    Muscle('abdominal', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 621.5,1055.49 c 11,-7.13 16.85,-1.94 16.85,16.21 -5.83,64.18 -20.74,107.62 -44.08,130.31 -22,21.4 -39.55,21.4 -62.24,0.65 -24,-21.39 -39.55,-65.48 -45.38,-131 0,-18.15 5.83,-23.34 16.85,-16.21 45.39,34.36 72.61,34.36 118,0 z"),
    Muscle('leftTopAbb', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 543.7,894.71 c 9.08,0 13,-5.19 12.32,-15.56 v -54.46 c -0.65,-7.13 -6.49,-10.37 -16.21,-10.37 -13.62,0 -29.82,-3.24 -49.92,-8.43 -8.43,-2.59 -11.67,1.94 -10.38,12.32 5.19,20.79 6.49,41.49 5.19,62.24 2.59,7.13 7.78,11 16.21,11 28.53,1.94 42.79,3.24 42.79,3.24 z"),
    Muscle('leftMiddleAbb', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 556.67,963.43 c -0.65,-34.36 -1.3,-44.09 -1.3,-44.09 0,-6.48 -3.89,-10.37 -11,-11 0,0 -17.51,-1.94 -51.87,-4.53 -6.48,-0.65 -10.37,2.59 -12.32,9.72 -1.29,21.39 -1.29,31.77 0.65,44.73 1.95,4.54 5.84,7.78 11.67,9.08 36.31,2.59 54.46,3.24 54.46,3.24 6.48,0 9.73,-2.59 9.73,-7.13 z"),
    Muscle('leftBottomAbb', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 556.67,1058.09 c 0.64,-18.81 -0.65,-44.09 -0.65,-66.13 -0.65,-5.84 -3.89,-9.08 -10.38,-9.08 0,0 -18.8,-1.3 -55.75,-3.24 -7.13,1.94 -9.73,7.13 -7.13,16.21 9.07,27.23 31.12,51.86 64.18,66.13 q 7.78,3.88 9.73,-3.89 z"),
    Muscle('FrontRightHand', PrimaryMuscleGroups.hand, Apptheme.mainButonColor, Colors.blue,
        "m 958,1117.73 c -8.43,10.37 -9.08,35.66 -1.3,73.91 1.3,7.78 6.48,13 13.61,14.26 16.86,2.6 39.55,-0.65 68.08,-10.37 8.42,-1.3 11,-6.48 8.42,-14.26 -3.89,-13 -5.18,-24 -3.24,-33.07 20.1,-2.59 25.94,-8.43 16.86,-17.5 a 190.88,190.88 0 0 0 -57.7,-25.29 c -16.86,-1.94 -31.77,1.95 -44.73,12.32 z"),
    Muscle(
        'FrontRightOutterForearm',
        PrimaryMuscleGroups.forearms,
        Apptheme.mainButonColor,
        Colors.blue,
        "m 895.74,816.91 c -5.84,-5.19 -11,-0.65 -14.27,14.26 -22.69,132.26 7.13,218.49 90.77,258 q 18.48,8.76 7.78,-13.61 c -17.51,-34.36 -28.53,-73.26 -33.07,-117.35 -3.89,-48.62 -20.74,-96 -51.21,-141.33 z"),
    Muscle(
        'FrontRightInnerForearm',
        PrimaryMuscleGroups.brachioradialis,
        Apptheme.mainButonColor,
        Colors.blue,
        "m 854.89,853.86 c -19.45,-20.09 -31.77,-25.28 -35.66,-14.26 -4.53,37.6 8.43,79.74 38.26,127.07 7.13,9.08 10.37,7.78 9.07,-2.59 A 315.11,315.11 0 0 1 862,875.26 c 0.65,-9.08 -1.94,-16.21 -7.13,-21.4 z"),
    Muscle('bicept', PrimaryMuscleGroups.biceps, Apptheme.mainButonColor, Colors.blue,
        "m 757,717.07 c 17.5,38.9 40.84,71.31 70.66,97.9 23.34,16.2 37.61,10.37 44.09,-17.51 q 11.67,-42.8 -31.12,-105 c -5.84,-6.48 -13.62,-9.72 -22.69,-10.37 -29.82,-4.54 -44.74,-6.48 -44.74,-6.48 -23.34,-5.19 -28.52,8.42 -16.2,41.49 z"),
    Muscle('shoulder', PrimaryMuscleGroups.deltoids, Apptheme.mainButonColor, Colors.blue,
        "m 597.51,558.23 c -25.93,-4.54 -30.47,-9.72 -14.26,-14.91 54.46,-18.15 108.27,-24 162.72,-16.86 q 91.42,19.45 93.36,126.43 c 0,22 -7.78,26.58 -22.69,12.31 -44.08,-57.05 -116.7,-92.71 -219.13,-107 z"),
    Muscle('neck', PrimaryMuscleGroups.trapezius, Apptheme.mainButonColor, Colors.blue,
        "m 583.89,526.46 c -6.48,4.54 -11,2.6 -13,-6.48 -1.95,-21.39 0,-35 5.83,-41.49 20.75,-11.67 34.36,-32.42 42.14,-62.24 3.25,-5.19 5.19,-5.19 6.49,0 -1.95,25.28 -0.65,42.79 4.54,51.86 9.72,11.67 24,22.05 42.78,30.48 6.49,5.18 5.19,8.42 -5.83,9.07 -37.6,3.89 -65.48,9.73 -83,18.8 z"),
    Muscle('chest', PrimaryMuscleGroups.pectorals, Apptheme.mainButonColor, Colors.blue,
        "m 574.17,759.21 c 0,22 11,27.88 33.71,18.15 71.32,-29.82 118.64,-71.31 142,-123.18 3.89,-11.67 3.25,-20.74 -3.89,-26.58 -31.76,-24.64 -68.07,-37 -108.91,-37.6 -38.9,1.3 -60.3,20.1 -62.89,56.4 v 112.81 z"),
    Muscle('obliques', PrimaryMuscleGroups.obliques, Apptheme.mainButonColor, Colors.blue,
        "m 654.56,1060 c 7.13,-51.87 8.43,-117.35 4.54,-195.79 4.54,-61.59 24.64,-109.57 59.65,-143.93 10.37,-12.32 18.15,-11.67 23.33,1.3 6.49,13 6.49,25.93 -1.29,38.25 -24.64,53.16 -37,111.51 -37,175.69 6.49,35.66 7.14,67.43 1.3,94 -2.59,13.61 -34.36,83 -46,81.69 -9.73,-1.3 -7.78,-41.5 -4.54,-51.22 z"),
    Muscle(
        'outterrightquad',
        PrimaryMuscleGroups.vastusLateralist,
        Apptheme.mainButonColor,
        Colors.blue,
        "m 690.87,1161.17 c 25.93,140 38.25,243.12 35.65,309.9 3.25,42.14 13.62,37.6 31.77,-13 16.21,-53.81 10.38,-127.72 -17.5,-222.38 a 955.44,955.44 0 0 1 -15.56,-112.8 c -3.24,-19.45 -9.73,-24 -18.8,-14.27 q -23.34,21.4 -15.56,52.52 z"),
    Muscle('frontrightquad', PrimaryMuscleGroups.quadriceps, Apptheme.mainButonColor, Colors.blue,
        "m 625.39,1556 c -11.67,-93.35 -23.34,-191.25 -34.36,-294.33 0,-14.27 2.59,-27.88 7.78,-39.55 q 21.39,-30.15 54.45,-56.4 c 11,-8.43 19.45,-2 24.64,18.8 30.47,156.24 35,276.83 12.32,363.06 -30.47,115.4 -51.87,118.64 -64.83,8.42 z"),
    Muscle('frontrightclave', PrimaryMuscleGroups.calves, Apptheme.mainButonColor, Colors.blue,
        "m 668.18,1939.8 c 14.91,57.7 27.23,57 37.6,-2.59 18.15,-103.73 20.74,-204.87 8.43,-302.12 -4.54,-20.75 -14.27,-25.28 -28.53,-13.61 q -44.73,64.17 -46.68,142 c 5.84,65.48 15.56,124.47 29.18,176.34 z"),
    Muscle('abb', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 581.3,894.71 c -9.08,0 -13,-5.19 -12.32,-15.56 v -54.46 c 0.65,-7.13 6.49,-10.37 16.21,-10.37 13.62,0 29.82,-3.24 49.92,-8.43 8.43,-2.59 11.67,1.94 10.37,12.32 C 641,839 639,859.7 641,880.45 c -2.6,7.13 -8.43,11 -16.86,11 -28.53,1.94 -42.79,3.24 -42.79,3.24 z"),
    Muscle('abb', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 568.33,963.43 c 0.65,-34.36 1.3,-44.09 1.3,-44.09 0,-6.48 3.89,-10.37 11,-11 0,0 17.51,-1.94 51.87,-4.53 6.48,-0.65 10.37,2.59 12.32,9.72 1.29,21.39 1.29,31.77 -0.65,44.73 -2,4.54 -5.84,7.78 -11.67,9.08 -36.31,2.59 -54.46,3.24 -54.46,3.24 -5.84,0 -9.08,-2.59 -9.73,-7.13 z"),
    Muscle('abb', PrimaryMuscleGroups.abdominals, Apptheme.mainButonColor, Colors.blue,
        "m 568.33,1058.09 c -0.64,-18.81 0.65,-44.09 0.65,-66.13 0.65,-5.84 3.89,-9.08 10.38,-9.08 0,0 18.8,-1.3 55.75,-3.24 7.78,1.94 9.73,7.13 7.13,16.21 -9.07,27.23 -31.12,51.86 -64.18,66.13 q -7.78,3.88 -9.73,-3.89 z"),
  ];
  List<Muscle> parsedMusclist = [];

  MuscleListController(this.read, this.userId) : super(AsyncValue.loading()) {
    userId == null ? muscleModelImageParser() : recoveryImageParser();
  }

  recoveryImageParser({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      for (Muscle muscle in muscleList) {
        muscle.parsedPath = parseSvgPath(muscle.path);
        parsedMusclist.add(muscle);
      }
      if (mounted) {
        state = AsyncValue.data(parsedMusclist);
      }
      return parsedMusclist;
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  selectMuscleGroup({selectedMuscle: Muscle, muscleList: List}) async {
    List<Muscle> newMuscleList = await read(MuscleModelRepositoryProvider)
        .selectMuscleGroup(muscleList: muscleList, selectedMuscle: selectedMuscle);

    state = AsyncValue.data(newMuscleList);
  }

  getSelectedMuscleGroup() => read(MuscleModelRepositoryProvider).getSelectedMuscleGroup();

  muscleModelImageParser() {}
}