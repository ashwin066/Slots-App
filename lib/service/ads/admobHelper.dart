import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shop_ecommerce/components/info_bottom_sheet.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class AdmobHelper {
  // BannerAd? _bannerAd;
  // InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  FirebaseService _service = FirebaseService();

  // void loadBannerAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: Platform.isIOS
  //         ? "ca-app-pub-3940256099942544/2934735716"
  //         : "ca-app-pub-3940256099942544/6300978111",
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: const BannerAdListener(),
  //   );

  //   _bannerAd?.load();
  // }

  // void loadInterstitialAd() {
  //   String interstitialAdId = Platform.isIOS
  //       ? "ca-app-pub-3940256099942544/4411468910"
  //       : "ca-app-pub-3940256099942544/1033173712";

  //   InterstitialAd.load(
  //       adUnitId: interstitialAdId,
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           // Keep a reference to the ad so you can show it later.
  //           _interstitialAd = ad;

  //           ad.fullScreenContentCallback = FullScreenContentCallback(
  //             onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //               ad.dispose();
  //               loadInterstitialAd();
  //             },
  //             onAdFailedToShowFullScreenContent:
  //                 (InterstitialAd ad, AdError error) {
  //               ad.dispose();
  //               loadInterstitialAd();
  //             },
  //           );
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  void loadRewardedAd(BuildContext? context) {
    EasyLoading.show(
      status: 'Loading',
    );
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? "ca-app-pub-3940256099942544/5224354917"
            : "ca-app-pub-3940256099942544/1712485313",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (
          RewardedAd ad,
        ) {
          _rewardedAd = ad;

          EasyLoading.dismiss(animation: false);
          _service.showAlertDialog(
            context!,
            "Are you sure?",
            "Watch an commercial ad.\n🅐 You will earn 1 ticket/ad.\n🅑 Maximum of 4 tickets can be earned/day via ads.",
            "Cancel",
            () {
              Navigator.of(context).pop();
               disposeAds();

            },
            "Watch",
            () {
              Navigator.of(context).pop();
              showRewardedAd(context);
            },
          );
        }, onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          Fluttertoast.showToast(
              msg: "Failed to load Commercials.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: DarkPurple,
              textColor: aWhite,
              fontSize: 16.0);
          EasyLoading.dismiss(animation: false);
        }));
  }

  void addAds(
      // bool interstitial,
      //bool bannerAd,
      BuildContext context,
      bool rewardedAd) {
    // if (interstitial) {
    //   loadInterstitialAd();
    // }

    // if (bannerAd) {
    //   loadBannerAd();
    // }

    if (rewardedAd) {
      loadRewardedAd(context);
    }
  }

  // void showInterstitial() {
  //   _interstitialAd?.show();
  // }

  // BannerAd? getBannerAd() {
  //   return _bannerAd;
  // }

  void showRewardedAd(
    context,
  ) {
    if (_rewardedAd != null)
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {
        print("Ad onAdShowedFullScreenContent");
      }, onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        // loadRewardedAd(null);
      }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        // loadRewardedAd(null);
      });

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      _service.addRemoveTickets(
          ticketData: {"tickets": FieldValue.increment(reward.amount)});
      print("${reward.amount} ${reward.type}");
      Fluttertoast.showToast(
          msg: "Reward Granted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: DarkPurple,
          textColor: aWhite,
          fontSize: 16.0);

      showInfoBottomSheet(
          context,
          "Congratulations! 🥳\nYou Just Earned ${reward.amount} tickets.",
          "${reward.amount} tickets added to your account.",
          null);
    });
  }

  void disposeAds() {
    // _bannerAd?.dispose();
    // _interstitialAd?.dispose();
    EasyLoading.dismiss(animation: false);
    _rewardedAd?.dispose();
  }
}
