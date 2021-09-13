import 'dart:math';

class LevelController {
  int getLevel(xp) {
    double level = (-450 + (sqrt(pow(450, 2) - 200 * -xp))) / 100;
    return level.floor() + 1;
  }
}
