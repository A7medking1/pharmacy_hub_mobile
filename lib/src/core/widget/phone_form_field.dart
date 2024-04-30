import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    super.key,
    this.hintText,
    this.title,
    this.controller,
    this.onChanged,
  });

  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final void Function(PhoneNumber)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != '') ...[
          Text(
            title ?? 'Phone number',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.grey, fontSize: 16.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
        IntlPhoneField(
          controller: controller,
          countries: countriesField,
          invalidNumberMessage: 'Please enter a valid Number',
          validator: (value) {
            if (value!.number.isEmpty) {
              return 'Please enter a valid Number';
            }
            return null;
          },
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: Colors.white,
            countryNameStyle: context.titleSmall,
            countryCodeStyle: context.titleSmall,
            searchFieldInputDecoration: InputDecoration(
              hintText: 'search country',
              isDense: true,
              hintStyle: context.titleSmall.copyWith(
                fontSize: 16.sp,
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: CustomFontFamily.vazirmatn,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            // LengthLimitingTextInputFormatter(10)
          ],
          dropdownTextStyle: context.titleSmall,
          decoration: InputDecoration(
            counterStyle: context.titleSmall.copyWith(fontSize: 12.sp),
            labelStyle: context.titleSmall,
            hintText: hintText ?? 'Phone number',
            fillColor: AppColors.backGroundColor,
            filled: true,
            hintStyle: TextStyle(
              color: AppColors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: CustomFontFamily.vazirmatn,
            ),
            isDense: true,
            errorStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.red, fontSize: 10.sp),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                16,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: AppColors.red,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
          initialCountryCode: 'EG',
          onChanged: onChanged,
        ),
      ],
    );
  }
}

const List<Country> countriesField = [
  Country(
    name: "Egypt",
    nameTranslations: {
      "sk": "Egypt",
      "se": "Egypt",
      "pl": "Egipt",
      "no": "Egypt",
      "ja": "エジプト",
      "it": "Egitto",
      "zh": "埃及",
      "nl": "Egypt",
      "de": "Ägypt",
      "fr": "Égypte",
      "es": "Egipt",
      "en": "Egypt",
      "pt_BR": "Egito",
      "sr-Cyrl": "Египат",
      "sr-Latn": "Egipat",
      "zh_TW": "埃及",
      "tr": "Mısır",
      "ro": "Egipt",
      "ar": "مصر",
      "fa": "مصر",
      "yue": "埃及"
    },
    flag: "🇪🇬",
    code: "EG",
    dialCode: "20",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "United Arab Emirates",
    nameTranslations: {
      "sk": "Spojené arabské emiráty",
      "se": "Ovttastuvvan Arábaemiráhtat",
      "pl": "Zjednoczone Emiraty Arabskie",
      "no": "De forente arabiske emirater",
      "ja": "アラブ首長国連邦",
      "it": "Emirati Arabi Uniti",
      "zh": "阿拉伯联合酋长国",
      "nl": "Verenigde Arabische Emiraten",
      "de": "Vereinigte Arabische Emirate",
      "fr": "Émirats arabes unis",
      "es": "Emiratos Árabes Unidos",
      "en": "United Arab Emirates",
      "pt_BR": "Emirados Árabes Unidos",
      "sr-Cyrl": "Уједињени Арапски Емирати",
      "sr-Latn": "Ujedinjeni Arapski Emirati",
      "zh_TW": "阿拉伯聯合大公國",
      "tr": "Birleşik Arap Emirlikleri",
      "ro": "Emiratele Arabe Unite",
      "ar": "الإمارات العربية المتحدة",
      "fa": "امارات متحده عربی",
      "yue": "阿拉伯聯合酋長國"
    },
    flag: "🇦🇪",
    code: "AE",
    dialCode: "971",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Saudi Arabia",
    nameTranslations: {
      "sk": "Saudská Arábia",
      "se": "Saudi-Arábia",
      "pl": "Arabia Saudyjska",
      "no": "Saudi-Arabia",
      "ja": "サウジアラビア",
      "it": "Arabia Saudita",
      "zh": "沙特阿拉伯",
      "nl": "Saoedi-Arabië",
      "de": "Saudi-Arabien",
      "fr": "Arabie saoudite",
      "es": "Arabia Saudí",
      "en": "Saudi Arabia",
      "pt_BR": "Arábia Saudita",
      "sr-Cyrl": "Саудијска Арабија",
      "sr-Latn": "Saudijska Arabija",
      "zh_TW": "沙烏地阿拉",
      "tr": "Suudi Arabistan",
      "ro": "Arabia Saudită",
      "ar": "السعودية",
      "fa": "عربستان سعودی",
      "yue": "沙地阿拉伯"
    },
    flag: "🇸🇦",
    code: "SA",
    dialCode: "966",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Oman",
    nameTranslations: {
      "sk": "Omán",
      "se": "Oman",
      "pl": "Oman",
      "no": "Oman",
      "ja": "オマーン",
      "it": "Oman",
      "zh": "阿曼",
      "nl": "Oman",
      "de": "Oman",
      "fr": "Oman",
      "es": "Omán",
      "en": "Oman",
      "pt_BR": "Omã",
      "sr-Cyrl": "Оман",
      "sr-Latn": "Oman",
      "zh_TW": "阿曼",
      "tr": "Umman",
      "ro": "Oman",
      "ar": "عمان",
      "fa": "عمان",
      "yue": "阿曼"
    },
    flag: "🇴🇲",
    code: "OM",
    dialCode: "968",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Kuwait",
    nameTranslations: {
      "sk": "Kuvajt",
      "se": "Kuwait",
      "pl": "Kuwejt",
      "no": "Kuwait",
      "ja": "クウェート",
      "it": "Kuwait",
      "zh": "科威特",
      "nl": "Koeweit",
      "de": "Kuwait",
      "fr": "Koweït",
      "es": "Kuwait",
      "en": "Kuwait",
      "pt_BR": "Kuwait",
      "sr-Cyrl": "Кувајт",
      "sr-Latn": "Kuvajt",
      "zh_TW": "科威特",
      "tr": "Kuveyt",
      "ro": "Kuweit",
      "ar": "الكويت",
      "fa": "کویت",
      "yue": "科威特"
    },
    flag: "🇰🇼",
    code: "KW",
    dialCode: "965",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Qatar",
    nameTranslations: {
      "sk": "Katar",
      "se": "Qatar",
      "pl": "Katar",
      "no": "Qatar",
      "ja": "カタール",
      "it": "Qatar",
      "zh": "卡塔尔",
      "nl": "Qatar",
      "de": "Katar",
      "fr": "Qatar",
      "es": "Catar",
      "en": "Qatar",
      "pt_BR": "Catar",
      "sr-Cyrl": "Катар",
      "sr-Latn": "Katar",
      "zh_TW": "卡達",
      "tr": "Katar",
      "ro": "Qatar",
      "ar": "قطر",
      "fa": "قطر",
      "yue": "卡塔爾"
    },
    flag: "🇶🇦",
    code: "QA",
    dialCode: "974",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Bahrain",
    nameTranslations: {
      "sk": "Bahrajn",
      "se": "Bahrain",
      "pl": "Bahrajn",
      "no": "Bahrain",
      "ja": "バーレーン",
      "it": "Bahrein",
      "zh": "巴林",
      "nl": "Bahrein",
      "de": "Bahrain",
      "fr": "Bahreïn",
      "es": "Baréin",
      "en": "Bahrain",
      "pt_BR": "Bahrein",
      "sr-Cyrl": "Бахреин",
      "sr-Latn": "Bahrein",
      "zh_TW": "巴林",
      "tr": "Bahreyn",
      "ro": "Bahrain",
      "ar": "البحرين",
      "fa": "بحرین",
      "yue": "巴林"
    },
    flag: "🇧🇭",
    code: "BH",
    dialCode: "973",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Iraq",
    nameTranslations: {
      "sk": "Irak",
      "se": "Irak",
      "pl": "Irak",
      "no": "Irak",
      "ja": "イラク",
      "it": "Iraq",
      "zh": "伊拉克",
      "nl": "Irak",
      "de": "Irak",
      "fr": "Irak",
      "es": "Irak",
      "en": "Iraq",
      "pt_BR": "Iraque",
      "sr-Cyrl": "Ирак",
      "sr-Latn": "Irak",
      "zh_TW": "伊拉克",
      "tr": "Irak",
      "ro": "Irak",
      "ar": "العراق",
      "fa": "عراق",
      "yue": "伊拉克"
    },
    flag: "🇮🇶",
    code: "IQ",
    dialCode: "964",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Jordan",
    nameTranslations: {
      "sk": "Jordánsko",
      "se": "Jordánia",
      "pl": "Jordania",
      "no": "Jordan",
      "ja": "ヨルダン",
      "it": "Giordania",
      "zh": "约旦",
      "nl": "Jordanië",
      "de": "Jordanien",
      "fr": "Jordanie",
      "es": "Jordania",
      "en": "Jordan",
      "pt_BR": "Jordânia",
      "sr-Cyrl": "Јордан",
      "sr-Latn": "Jordan",
      "zh_TW": "約旦",
      "tr": "Mavera-i Ürdün",
      "ro": "Iordania",
      "ar": "الأردن",
      "fa": "اردن",
      "yue": "約旦"
    },
    flag: "🇯🇴",
    code: "JO",
    dialCode: "962",
    minLength: 9,
    maxLength: 9,
  ),
];
