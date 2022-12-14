// ignore_for_file: use_string_buffers, avoid_multiple_declarations_per_line

import 'dart:math';

import 'package:levels_dart_pyramid_funnels/models/level/level.dart';

class LevelTree {
  static Level? getLevelByLevelIndex(int levelIndex) {
    return LevelTree.levels
        .singleWhere((level) => level.levelIndex == levelIndex);
  }

  /// returns more difficult level if there is any
  static Level getMoreDifficultLevel(Level level) {
    Level? newLevel;
    var newLevelIndex = level.levelIndex;

    /// avoid not implemented levels
    while (newLevel == null) {
      newLevelIndex++;

      /// max level -> return the same level
      if (level.levelIndex == levels.last.levelIndex) return level;
      newLevel = getLevelByLevelIndex(newLevelIndex);
    }
    return newLevel;

//    return getLevelByLevelIndex(level.levelIndex + 1);
  }

  /// returns less difficult level if there is any
  static Level getLessDifficultLevel(Level level) {
    var newLevelIndex = level.levelIndex;
    Level? newLevel;

    /// avoid not implemented levels
    while (newLevel == null) {
      newLevelIndex--;

      /// min level -> return the same level
      if (newLevelIndex == 0) return level;
      newLevel = getLevelByLevelIndex(newLevelIndex);
    }
    return newLevel;
  }

  /// returns levelIndex number based
  static int schoolClassToLevelIndex(int schoolClass, int monthInSchool) {
    assert(schoolClass > -1, ''); // 0 schoolClass is tutorial
    assert(monthInSchool > -1 && monthInSchool < 10, ''); // 0..Sept, 9..June
    // highest defined schoolClass
    return schoolClassToLevelMap[schoolClass > 5 ? 5 : schoolClass]
        [monthInSchool];
  }

  /// Returns the List of List<int> schoolClass based on the given index
  /// or of the closest lower possible index, if the given index is not found
  /// in the mapping table
  static List<int> getSchoolClasses(int levelIndex) {
    final result = <int>[];

    for (var yIndex = 0; yIndex < schoolClassToLevelMap.length; yIndex++) {
      final y = schoolClassToLevelMap[yIndex];
      final yMin = y.reduce(min);
      final yMax = y.reduce(max);

      if ((yMin <= levelIndex) & (levelIndex <= yMax)) result.add(yIndex);
    }

    assert(
      result.isNotEmpty,
      'Level $levelIndex does not have class assigned.',
    );
    return result;
  }

////////////////////////////////////////////////// lookups to find levels

// each row is the schoolClass (0-5)
// each column is the schoolMonth (0-9)
  static final List<List<int>> schoolClassToLevelMap = [
    //9  10  11  12  01  02  03  04  05  06 -- months in the school year
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00], // 0 class => tutorial
    [02, 02, 02, 02, 08, 12, 16, 20, 24, 24], // 1st class
    [21, 30, 39, 39, 48, 48, 57, 57, 61, 61], // 2nd
    [60, 60, 60, 62, 64, 64, 64, 64, 67, 67], // 3rd
    [66, 66, 66, 72, 72, 72, 78, 78, 85, 85], // 4th
    [84, 84, 84, 90, 90, 90, 96, 96, 96, 96], // 5th
  ];

  /// level definitions

  static final List<Level> levels = [
    Level(
      levelIndex: 2,
      maxTotal: 10,
      masks: [
        [0, 1, 1],
      ],
    ),
    Level(
      levelIndex: 3,
      maxTotal: 10,
      masks: [
        [1, 0, 1],
        [1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 4,
      maxTotal: 10,
      masks: [
        [0, 0, 0, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 5,
      maxTotal: 10,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 6,
      maxTotal: 10,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 7,
      maxTotal: 10,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0]
      ],
    ),
    Level(
      levelIndex: 8,
      maxTotal: 12,
      masks: [
        [0, 0, 0, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 9,
      maxTotal: 12,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),
///////////// 10+
    Level(
      levelIndex: 10,
      maxTotal: 12,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 11,
      maxTotal: 12,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 12,
      maxTotal: 15,
      masks: [
        [0, 0, 0, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 13,
      maxTotal: 15,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 14,
      maxTotal: 15,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 15,
      maxTotal: 15,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),

    Level(
      levelIndex: 16,
      maxTotal: 18,
      masks: [
        [0, 0, 0, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 17,
      maxTotal: 18,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0]
      ],
    ),
    Level(
      levelIndex: 18,
      maxTotal: 18,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 19,
      maxTotal: 18,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),

///////////// 20+
    Level(
      levelIndex: 20,
      maxTotal: 20,
      masks: [
        [0, 0, 0, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 21,
      maxTotal: 20,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0]
      ],
    ),

    Level(
      levelIndex: 22,
      maxTotal: 20,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 23,
      maxTotal: 20,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),

    Level(
      levelIndex: 24,
      maxTotal: 20,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 25,
      maxTotal: 20,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 26,
      maxTotal: 20,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 27,
      maxTotal: 20,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 28,
      maxTotal: 20,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 29,
      maxTotal: 20,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),

///////////// 30+

    Level(
      levelIndex: 30,
      maxTotal: 30,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 31,
      maxTotal: 30,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 32,
      maxTotal: 30,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 33,
      maxTotal: 30,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 34,
      maxTotal: 30,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 35,
      maxTotal: 30,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 36,
      maxTotal: 30,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 37,
      maxTotal: 30,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 38,
      maxTotal: 30,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),

    Level(
      levelIndex: 39,
      maxTotal: 40,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),

///////////// 40+
    Level(
      levelIndex: 40,
      maxTotal: 40,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 41,
      maxTotal: 40,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 42,
      maxTotal: 40,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 43,
      maxTotal: 40,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 44,
      maxTotal: 40,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 45,
      maxTotal: 40,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 46,
      maxTotal: 40,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 47,
      maxTotal: 40,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 48,
      maxTotal: 60,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 49,
      maxTotal: 60,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),

///////////// 50+
    Level(
      levelIndex: 50,
      maxTotal: 60,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 51,
      maxTotal: 60,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 52,
      maxTotal: 60,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 53,
      maxTotal: 60,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 54,
      maxTotal: 60,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 55,
      maxTotal: 60,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 56,
      maxTotal: 60,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 57,
      maxTotal: 100,
      masks: [
        [0, 1, 0, 1, 0, 1],
        [0, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 58,
      maxTotal: 100,
      masks: [
        [0, 1, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 0],
        [0, 1, 1, 1, 0, 0],
        [1, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 59,
      maxTotal: 100,
      masks: [
        [1, 1, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0, 0],
      ],
    ),

///////////// 60+ done
    Level(
      levelIndex: 60,
      maxTotal: 100,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1]
      ],
    ),
    Level(
      levelIndex: 61,
      maxTotal: 100,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 62,
      maxTotal: 100,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 63,
      maxTotal: 100,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 64,
      maxTotal: 100,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 65,
      maxTotal: 100,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 66,
      maxTotal: 200,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 67,
      maxTotal: 200,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 68,
      maxTotal: 200,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 69,
      maxTotal: 200,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),

///////////// 70+
    Level(
      levelIndex: 70,
      maxTotal: 200,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 71,
      maxTotal: 200,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 72,
      maxTotal: 350,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 73,
      maxTotal: 350,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 74,
      maxTotal: 350,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 75,
      maxTotal: 350,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 76,
      maxTotal: 350,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 77,
      maxTotal: 350,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 78,
      maxTotal: 500,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 79,
      maxTotal: 500,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),

///////////// 80+
    Level(
      levelIndex: 80,
      maxTotal: 500,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 81,
      maxTotal: 500,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 82,
      maxTotal: 500,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 83,
      maxTotal: 500,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 84,
      maxTotal: 650,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 85,
      maxTotal: 650,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 86,
      maxTotal: 650,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 87,
      maxTotal: 650,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 88,
      maxTotal: 650,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 89,
      maxTotal: 650,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),

///////////// 90+
    Level(
      levelIndex: 90,
      maxTotal: 800,
      masks: [
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelIndex: 91,
      maxTotal: 800,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 92,
      maxTotal: 800,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 93,
      maxTotal: 800,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 94,
      maxTotal: 800,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 95,
      maxTotal: 800,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
    Level(
      levelIndex: 96,
      maxTotal: 1000,
      masks: [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
      ],
    ),
    Level(
      levelIndex: 97,
      maxTotal: 1000,
      masks: [
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      ],
    ),
    Level(
      levelIndex: 98,
      maxTotal: 1000,
      masks: [
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
        [0, 1, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 0, 1, 1, 0, 0, 0, 1, 1, 0],
        [0, 0, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 1],
        [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
        [0, 0, 1, 0, 0, 1, 1, 1, 0, 0],
      ],
    ),
    Level(
      levelIndex: 99,
      maxTotal: 1000,
      masks: [
        [0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 1, 0, 0, 0, 0, 0, 1, 1],
        [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      ],
    ),

///////////// 100+
    Level(
      levelIndex: 100,
      maxTotal: 1000,
      masks: [
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 0, 1, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
        [1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 0, 1, 0, 0],
        [1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [1, 0, 1, 0, 0, 1, 0, 1, 0, 0],
        [1, 1, 0, 1, 0, 0, 0, 0, 1, 0],
      ],
    ),
  ];
} // LevelTree
