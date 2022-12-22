import 'package:flutter/material.dart';

abstract class LanguagesStates{}
class InitalLanguageState extends LanguagesStates{}
class ChangeLanguageState extends LanguagesStates{
  final Locale locale;

  ChangeLanguageState({required this.locale});
}