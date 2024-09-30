import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/models/m_carousel.dart';

class LoginGatewayController extends GetxController {
  ValueNotifier<int> carouselIndex = ValueNotifier(0);
  List<CarouselModel> carouselList = [
    CarouselModel(
        image: 'assets/images/Illustration.png',
        title: 'Gain total control of your money',
        body: 'Become your own money manager and make every cent count'),
    CarouselModel(
        image: 'assets/images/Illustration2.png',
        title: 'Know where your \nmoney goes',
        body:
            'Track your transaction easily, with categories and financial report '),
    CarouselModel(
        image: 'assets/images/Illustration3.png',
        title: 'Planning ahead',
        body: 'Setup your budget for each category so you in control'),
  ];
}
