import 'dart:ui';

bool gIsDarkMode = false;
String gUserAgent = "";

enum IdVerificationType { none, nid, passport, driving, voter }

enum PhotoType { front, back, selfie }

class AssetConstants {
  //ICONS
  static const basePathIcons = "assets/icons/";

  ///IMAGES
  static const basePathImages = "assets/images/";
  static const bot = "assets/images/bot.png";
  static const knowledge = "assets/images/knowledge.png";
  static const myAccount = "assets/images/account.png";
  static const brainAi = "assets/images/brain.png";
  static const dataset = "assets/images/dataset_text.png";
  static const document = "assets/images/document.png";

  // ANIMATIONS
  static const basePathAnimation = "assets/animations/";
  static const animationTick = "${basePathAnimation}tick.json";
}
