const languages = [
  'en_US',
  'fa_IR',
  'zh_CN',
  'zh_HK',
  'ms_MY',
  'my_MM',
  'ru_RU',
  'tr_TR',
  'hi_IN',
  'ur_IN',
  'ar_EG',
  'vi_VN',
  'th_TH',
  'es_ES',
  'es_CU',
  'fr_FR',
  'bn_BD',
];

String checkSupportedLanguages(String language){
  if(languages.contains(language)){
    return language;
  }
  return 'en_Us';
}

String displayLanguage(String languageCode) {
  if (languageCode == 'ar_EG') {
    return 'العربية';
  }
  if (languageCode == 'fa_IR') {
    return 'فارسی';
  }
  if (languageCode == 'zh_CN') {
    return '中文 (简体)';
  }
  if (languageCode == 'zh_HK') {
    return '中文 (繁體)';
  }
  if (languageCode == 'es_CU') {
    return 'Español (Cuba)';
  }
  if (languageCode == 'my_MM') {
    return 'မြန်မာစာ';
  }
  var plainLanguageCode = languageCode;
  if (languageCode.contains('_')) {
    var splits = languageCode.split('_');
    if (splits.isNotEmpty) {
      plainLanguageCode = splits.first;
    }
  }
  var displayName = localizedLocaleNames[plainLanguageCode];
  if (displayName != null) {
    return displayName;
  }
  return 'English';
}

const localizedLocaleNames = {
  'id_ID': 'Bahasa Indonesia (Indonesia)',
  'hy': 'հայերեն',
  'ff_GN': 'Pulaar (Gine)',
  'ar_SA': 'العربية (المملكة العربية السعودية)',
  'zh': '中文',
  'en_AG': 'English (Antigua & Barbuda)',
  'es_HN': 'español (Honduras)',
  'ga_IE': 'Gaeilge (Éire)',
  'tr_TR': 'Türkçe (Türkiye)',
  'de_LI': 'Deutsch (Liechtenstein)',
  'zh_SG': '中文 (新加坡)',
  'en_KI': 'English (Kiribati)',
  'ky_Cyrl': 'кыргызча (Кирилик)',
  'qu_EC': 'Runasimi (Ecuador)',
  'lg_UG': 'Luganda (Yuganda)',
  'ti_ET': 'Tigrinya (Ethiopia)',
  'sv_AX': 'svenska (Åland)',
  'en_IE': 'English (Ireland)',
  'ha_GH': 'Hausa (Gana)',
  'ps': 'پښتو',
  'ks': 'کٲشُر',
  'ms_MY': 'Bahasa Melayu (Malaysia)',
  'en_BM': 'English (Bermuda)',
  'el_CY': 'Ελληνικά (Κύπρος)',
  'rn_BI': 'Ikirundi (Uburundi)',
  'hu_HU': 'magyar (Magyarország)',
  'en_SC': 'English (Seychelles)',
  'yo_NG': 'Èdè Yorùbá (Orílẹ́ède Nàìjíríà)',
  'dz': 'རྫོང་ཁ',
  'pt_TL': 'português (Timor-Leste)',
  'ar_AE': 'العربية (الإمارات العربية المتحدة)',
  'en_CK': 'English (Cook Islands)',
  'fr_MA': 'français (Maroc)',
  'tr': 'Türkçe',
  'br_FR': 'brezhoneg (Frañs)',
  'or': 'ଓଡ଼ିଆ',
  'mk': 'македонски',
  'qu': 'Runasimi',
  'sl': 'slovenščina',
  'ne_IN': 'नेपाली (भारत)',
  'hu': 'magyar',
  'en_SZ': 'English (Swaziland)',
  'es_VE': 'español (Venezuela)',
  'af_NA': 'Afrikaans (Namibië)',
  'ne_NP': 'नेपाली (नेपाल)',
  'mr': 'मराठी',
  'en_KE': 'English (Kenya)',
  'pt_PT': 'português (Portugal)',
  'bn_IN': 'বাংলা (ভারত)',
  'lt': 'lietuvių',
  'zh_HK': '中文 (中国香港特别行政区)',
  'ms_SG': 'Bahasa Melayu (Singapura)',
  'sw_TZ': 'Kiswahili (Tanzania)',
  'ee': 'eʋegbe',
  'is': 'íslenska',
  'it_SM': 'italiano (San Marino)',
  'sv_SE': 'svenska (Sverige)',
  'ar_EH': 'العربية (الصحراء الغربية)',
  'bn': 'বাংলা',
  'fy_NL': 'West-Frysk (Nederlân)',
  'pt_GW': 'português (Guiné Bissau)',
  'es_PH': 'español (Filipinas)',
  'ar_LY': 'العربية (ليبيا)',
  'en_MH': 'English (Marshall Islands)',
  'ar_QA': 'العربية (قطر)',
  'no_NO': 'Norwegian (Norway)',
  'fo': 'føroyskt',
  'rw_RW': 'Kinyarwanda (Rwanda)',
  'pt_CV': 'português (Cabo Verde)',
  'pt_AO': 'português (Angola)',
  'mg': 'Malagasy',
  'ru_MD': 'русский (Молдова)',
  'en_VI': 'English (U.S. Virgin Islands)',
  'ks_Arab_IN': 'کٲشُر (اَربی, ہِنٛدوستان)',
  'dz_BT': 'རྫོང་ཁ (འབྲུག)',
  'ko_KR': '한국어 (대한민국)',
  'ha': 'Hausa',
  'ar_SY': 'العربية (سوريا)',
  'es_SV': 'español (El Salvador)',
  'fr_ML': 'français (Mali)',
  'ig': 'Igbo',
  'fr_BE': 'français (Belgique)',
  'sr_Latn_RS': 'srpski (latinica, Srbija)',
  'yo': 'Èdè Yorùbá',
  'ur_PK': 'اردو (پاکستان)',
  'om_ET': 'Oromoo (Itoophiyaa)',
  'bo': 'བོད་སྐད་',
  'en_GG': 'English (Guernsey)',
  'bo_IN': 'བོད་སྐད་ (རྒྱ་གར་)',
  'kk': 'қазақ тілі',
  'ar_PS': 'العربية (الأراضي الفلسطينية)',
  'ca_AD': 'català (Andorra)',
  'ln_AO': 'lingála (Angóla)',
  'es_ES': 'español (España)',
  'ru_BY': 'русский (Беларусь)',
  'nl': 'Nederlands',
  'lu': 'Tshiluba',
  'be_BY': 'беларуская (Беларусь)',
  'sh_BA': 'Serbo-Croatian (Bosnia & Herzegovina)',
  'ar_DZ': 'العربية (الجزائر)',
  'de_AT': 'Deutsch (Österreich)',
  'ms': 'Bahasa Melayu',
  'zh_Hant_HK': '中文 (繁體字, 中華人民共和國香港特別行政區)',
  'en_DM': 'English (Dominica)',
  'es_AR': 'español (Argentina)',
  'nn_NO': 'nynorsk (Noreg)',
  'en_FM': 'English (Micronesia)',
  'ug_Arab_CN': 'ئۇيغۇرچە (ئەرەب, جۇڭگو)',
  'ja_JP': '日本語 (日本)',
  'ta_IN': 'தமிழ் (இந்தியா)',
  'sn_ZW': 'chiShona (Zimbabwe)',
  'os': 'ирон',
  'en_AS': 'English (American Samoa)',
  'en_SB': 'English (Solomon Islands)',
  'ar_MR': 'العربية (موريتانيا)',
  'ps_AF': 'پښتو (افغانستان)',
  'es_CR': 'español (Costa Rica)',
  'fr_BI': 'français (Burundi)',
  'es_PE': 'español (Perú)',
  'en_NZ': 'English (New Zealand)',
  'en_LC': 'English (St. Lucia)',
  'rm_CH': 'rumantsch (Svizra)',
  'gd': 'Gàidhlig',
  'fa_AF': 'دری (افغانستان)',
  'sq_MK': 'shqip (Maqedoni)',
  'en_ER': 'English (Eritrea)',
  'fr_GN': 'français (Guinée)',
  'fr_WF': 'français (Wallis-et-Futuna)',
  'it_CH': 'italiano (Svizzera)',
  'ha_Latn_GH': 'Hausa (Latin, Ghana)',
  'en_PH': 'English (Philippines)',
  'fr_PM': 'français (Saint-Pierre-et-Miquelon)',
  'fr_KM': 'français (Comores)',
  'zh_CN': '中文 (中国)',
  'bg_BG': 'български (България)',
  'fr_VU': 'français (Vanuatu)',
  'fr_MU': 'français (Maurice)',
  'en_MP': 'English (Northern Mariana Islands)',
  'ja': '日本語',
  'ky_Cyrl_KG': 'кыргызча (Кирилик, Кыргызстан)',
  'de': 'Deutsch',
  'se_FI': 'davvisámegiella (Suopma)',
  'es_CL': 'español (Chile)',
  'fr_SY': 'français (Syrie)',
  'en_JE': 'English (Jersey)',
  'ca_IT': 'català (Itàlia)',
  'en_ZM': 'English (Zambia)',
  'fr_TG': 'français (Togo)',
  'om': 'Oromoo',
  'zh_Hans_MO': '中文 (简体中文, 中国澳门特别行政区)',
  'mt': 'Malti',
  'ii_CN': 'ꆈꌠꉙ (ꍏꇩ)',
  'ru': 'русский',
  'pl': 'polski',
  'lv_LV': 'latviešu (Latvija)',
  'ar_YE': 'العربية (اليمن)',
  'ug_CN': 'ئۇيغۇرچە (جۇڭگو)',
  'fr_GP': 'français (Guadeloupe)',
  'en_GU': 'English (Guam)',
  'uk': 'українська',
  'fr_PF': 'français (Polynésie française)',
  'kl': 'kalaallisut',
  'nb_SJ': 'norsk bokmål (Svalbard og Jan Mayen)',
  'en_IO': 'English (British Indian Ocean Territory)',
  'ha_Latn_NG': 'Hausa (Latin, Nigeria)',
  'lg': 'Luganda',
  'es_EA': 'español (Ceuta y Melilla)',
  'et_EE': 'eesti (Eesti)',
  'ln_CD': 'lingála (Repibiki demokratiki ya Kongó)',
  'es_NI': 'español (Nicaragua)',
  'ky': 'кыргызча',
  'ru_KZ': 'русский (Казахстан)',
  'gu_IN': 'ગુજરાતી (ભારત)',
  'fr_CD': 'français (Congo-Kinshasa)',
  'en_CA': 'English (Canada)',
  'ki_KE': 'Gikuyu (Kenya)',
  'fi': 'suomi',
  'fr_DZ': 'français (Algérie)',
  'el_GR': 'Ελληνικά (Ελλάδα)',
  'mg_MG': 'Malagasy (Madagasikara)',
  'it_IT': 'italiano (Italia)',
  'ta': 'தமிழ்',
  'fr_MR': 'français (Mauritanie)',
  'en_MW': 'English (Malawi)',
  'th_TH': 'ไทย (ไทย)',
  'en_CX': 'English (Christmas Island)',
  'en_ZA': 'English (South Africa)',
  'uz_Arab_AF': 'اوزبیک (عربی, افغانستان)',
  'bm_Latn_ML': 'Bambara (Latin, Mali)',
  'om_KE': 'Oromoo (Keeniyaa)',
  'hy_AM': 'հայերեն (Հայաստան)',
  'en_GY': 'English (Guyana)',
  'eo': 'esperanto',
  'gv': 'Gaelg',
  'ug': 'ئۇيغۇرچە',
  'ti_ER': 'Tigrinya (Eritrea)',
  'ar_KM': 'العربية (جزر القمر)',
  'es_GT': 'español (Guatemala)',
  'bs_BA': 'bosanski (Bosna i Hercegovina)',
  'ur': 'اردو',
  'es_CU': 'español (Cuba)',
  'en_CM': 'English (Cameroon)',
  'pa_PK': 'ਪੰਜਾਬੀ (ਪਾਕਿਸਤਾਨ)',
  'fr_CH': 'français (Suisse)',
  'fr_MG': 'français (Madagascar)',
  'pt_ST': 'português (São Tomé e Príncipe)',
  'mn_Cyrl': 'монгол (кирил)',
  'en_FJ': 'English (Fiji)',
  'en_FK': 'English (Falkland Islands)',
  'sk': 'slovenčina',
  'ml': 'മലയാളം',
  'en_VC': 'English (St. Vincent & Grenadines)',
  'en_TZ': 'English (Tanzania)',
  'kk_Cyrl': 'қазақ тілі (кирилл жазуы)',
  'az': 'azərbaycan',
  'fr_CI': 'français (Côte d’Ivoire)',
  'en_AU': 'English (Australia)',
  'ar_SS': 'العربية (جنوب السودان)',
  'fr_MF': 'français (Saint-Martin (partie française))',
  'en_SD': 'English (Sudan)',
  'ar_OM': 'العربية (عُمان)',
  'sw_KE': 'Kiswahili (Kenya)',
  'kk_KZ': 'қазақ тілі (Қазақстан)',
  'en_GM': 'English (Gambia)',
  'ff_MR': 'Pulaar (Muritani)',
  'pt': 'português',
  'rm': 'rumantsch',
  'sr_Cyrl_RS': 'српски (ћирилица, Србија)',
  'be': 'беларуская',
  'az_AZ': 'azərbaycan (Azərbaycan)',
  'qu_BO': 'Runasimi (Bolivia)',
  'fr_LU': 'français (Luxembourg)',
  'en': 'English',
  'ar_BH': 'العربية (البحرين)',
  'en_RW': 'English (Rwanda)',
  'en_PN': 'English (Pitcairn Islands)',
  'ka': 'ქართული',
  'en_KN': 'English (St. Kitts & Nevis)',
  'pa': 'ਪੰਜਾਬੀ',
  'fr_HT': 'français (Haïti)',
  'en_DG': 'English (Diego Garcia)',
  'my': 'ဗမာ',
  'en_TO': 'English (Tonga)',
  'ar_MA': 'العربية (المغرب)',
  'lo_LA': 'ລາວ (ລາວ)',
  'en_TV': 'English (Tuvalu)',
  'or_IN': 'ଓଡ଼ିଆ (ଭାରତ)',
  'sg': 'Sängö',
  'en_SH': 'English (St. Helena)',
  'en_MO': 'English (Macau SAR China)',
  'en_PW': 'English (Palau)',
  'yi': 'ייִדיש',
  'gd_GB': 'Gàidhlig (An Rìoghachd Aonaichte)',
  'en_IN': 'English (India)',
  'km': 'ខ្មែរ',
  'sr_RS': 'српски (Србија)',
  'it': 'italiano',
  'en_BS': 'English (Bahamas)',
  'ha_NG': 'Hausa (Najeriya)',
  'my_MM': 'ဗမာ (မြန်မာ)',
  'es_IC': 'español (islas Canarias)',
  'ar_IL': 'العربية (إسرائيل)',
  'fr_GQ': 'français (Guinée équatoriale)',
  'fo_FO': 'føroyskt (Føroyar)',
  'en_TC': 'English (Turks & Caicos Islands)',
  'sr': 'српски',
  'uz_Arab': 'اوزبیک (عربی)',
  'hr': 'hrvatski',
  'hr_BA': 'hrvatski (Bosna i Hercegovina)',
  'ms_BN': 'Bahasa Melayu (Brunei)',
  'tl': 'Tagalog',
  'ky_KG': 'кыргызча (Кыргызстан)',
  'ar_DJ': 'العربية (جيبوتي)',
  'sr_XK': 'српски (Косово)',
  'en_HK': 'English (Hong Kong SAR China)',
  'ug_Arab': 'ئۇيغۇرچە (ئەرەب)',
  'fi_FI': 'suomi (Suomi)',
  'tr_CY': 'Türkçe (Güney Kıbrıs Rum Kesimi)',
  'fr_SN': 'français (Sénégal)',
  'fr_CF': 'français (République centrafricaine)',
  'en_CC': 'English (Cocos (Keeling) Islands)',
  'lb_LU': 'Lëtzebuergesch (Lëtzebuerg)',
  'zu': 'isiZulu',
  'eu_ES': 'euskara (Espainia)',
  'et': 'eesti',
  'ln_CF': 'lingála (Repibiki ya Afríka ya Káti)',
  'en_BE': 'English (Belgium)',
  'cy_GB': 'Cymraeg (Y Deyrnas Unedig)',
  'es_EC': 'español (Ecuador)',
  'en_US': 'English (United States)',
  'ha_Latn_NE': 'Hausa (Latin, Niger)',
  'en_IM': 'English (Isle of Man)',
  'en_GB': 'English (United Kingdom)',
  'as_IN': 'অসমীয়া (ভাৰত)',
  'kn': 'ಕನ್ನಡ',
  'en_NF': 'English (Norfolk Island)',
  'es_PY': 'español (Paraguay)',
  'fr_NC': 'français (Nouvelle-Calédonie)',
  'mn_Cyrl_MN': 'монгол (кирил, Монгол)',
  'sr_Cyrl_BA': 'српски (ћирилица, Босна и Херцеговина)',
  'rw': 'Kinyarwanda',
  'de_CH': 'Deutsch (Schweiz)',
  'cy': 'Cymraeg',
  'sq': 'shqip',
  'to': 'lea fakatonga',
  'ms_Latn_BN': 'Bahasa Melayu (Latin, Brunei)',
  'en_MY': 'English (Malaysia)',
  'sh': 'Serbo-Croatian',
  'ar_TN': 'العربية (تونس)',
  'ks_IN': 'کٲشُر (ہِنٛدوستان)',
  'os_RU': 'ирон (Уӕрӕсе)',
  'ee_TG': 'eʋegbe (Togo nutome)',
  'bm_Latn': 'Bambara (Latin)',
  'en_SG': 'English (Singapore)',
  'es_MX': 'español (México)',
  'fr_BL': 'français (Saint-Barthélemy)',
  'sr_BA': 'српски (Босна и Херцеговина)',
  'ga': 'Gaeilge',
  'kw': 'kernewek',
  'rn': 'Ikirundi',
  'ka_GE': 'ქართული (საქართველო)',
  'pa_Arab_PK': 'پنجابی (عربی, پکستان)',
  'en_LS': 'English (Lesotho)',
  'uz_Latn': 'oʻzbekcha (Lotin)',
  'en_WS': 'English (Samoa)',
  'ur_IN': 'اردو (بھارت)',
  'ne': 'नेपाली',
  'bs': 'bosanski',
  'en_VU': 'English (Vanuatu)',
  'zh_Hans_CN': '中文 (简体中文, 中国)',
  'hi_IN': 'हिंदी (भारत)',
  'pa_Arab': 'پنجابی (عربی)',
  'en_MU': 'English (Mauritius)',
  'sr_Cyrl_XK': 'српски (ћирилица, Косово)',
  'fr': 'français',
  'vi_VN': 'Tiếng Việt (Việt Nam)',
  'en_SS': 'English (South Sudan)',
  'ro_MD': 'română (Republica Moldova)',
  'tl_PH': 'Tagalog (Philippines)',
  'fr_MQ': 'français (Martinique)',
  'en_MT': 'English (Malta)',
  'ar_SD': 'العربية (السودان)',
  'to_TO': 'lea fakatonga (Tonga)',
  'am': 'አማርኛ',
  'bs_Latn': 'bosanski (latinica)',
  'az_Cyrl': 'Азәрбајҹан (kiril)',
  'sr_Cyrl_ME': 'српски (ћирилица, Црна Гора)',
  'zh_Hans_SG': '中文 (简体中文, 新加坡)',
  'is_IS': 'íslenska (Ísland)',
  'nd': 'isiNdebele',
  'br': 'brezhoneg',
  'es_US': 'español (Estados Unidos)',
  'ca_FR': 'català (França)',
  'sq_AL': 'shqip (Shqipëri)',
  'gu': 'ગુજરાતી',
  'el': 'Ελληνικά',
  'af_ZA': 'Afrikaans (Suid-Afrika)',
  'en_LR': 'English (Liberia)',
  'sg_CF': 'Sängö (Ködörösêse tî Bêafrîka)',
  'bg': 'български',
  'ro': 'română',
  'en_KY': 'English (Cayman Islands)',
  'km_KH': 'ខ្មែរ (កម្ពុជា)',
  'fr_RE': 'français (La Réunion)',
  'es_PA': 'español (Panamá)',
  'kw_GB': 'kernewek (Rywvaneth Unys)',
  'ff': 'Pulaar',
  'hi': 'हिंदी',
  'nl_SX': 'Nederlands (Sint-Maarten)',
  'fr_SC': 'français (Seychelles)',
  'ha_Latn': 'Hausa (Latin)',
  'kk_Cyrl_KZ': 'қазақ тілі (кирилл жазуы, Қазақстан)',
  'ca': 'català',
  'uz_Latn_UZ': 'oʻzbekcha (Lotin, Oʻzbekiston)',
  'en_ZW': 'English (Zimbabwe)',
  'mn': 'монгол',
  'az_Cyrl_AZ': 'Азәрбајҹан (kiril, Азәрбајҹан)',
  'si': 'සිංහල',
  'so_SO': 'Soomaali (Soomaaliya)',
  'zh_Hans_HK': '中文 (简体中文, 中国香港特别行政区)',
  'es_CO': 'español (Colombia)',
  'se_SE': 'davvisámegiella (Ruoŧŧa)',
  'bs_Cyrl_BA': 'босански (Ћирилица, Босна и Херцеговина)',
  'mk_MK': 'македонски (Македонија)',
  'fr_TD': 'français (Tchad)',
  'kn_IN': 'ಕನ್ನಡ (ಭಾರತ)',
  'ml_IN': 'മലയാളം (ഇന്ത്യ)',
  'ru_RU': 'русский (Россия)',
  'qu_PE': 'Runasimi (Perú)',
  'sr_Latn': 'srpski (latinica)',
  'en_UG': 'English (Uganda)',
  'ar_KW': 'العربية (الكويت)',
  'fr_YT': 'français (Mayotte)',
  'ff_SN': 'Pulaar (Senegaal)',
  'ha_NE': 'Hausa (Nijar)',
  'en_NG': 'English (Nigeria)',
  'ee_GH': 'eʋegbe (Ghana nutome)',
  'ko': '한국어',
  'sl_SI': 'slovenščina (Slovenija)',
  'mt_MT': 'Malti (Malta)',
  'fr_GF': 'français (Guyane française)',
  'de_LU': 'Deutsch (Luxemburg)',
  'so_KE': 'Soomaali (Kiiniya)',
  'si_LK': 'සිංහල (ශ්\u200dරී ලංකාව)',
  'ln_CG': 'lingála (Kongo)',
  'en_NR': 'English (Nauru)',
  'nl_NL': 'Nederlands (Nederland)',
  'eu': 'euskara',
  'gl': 'galego',
  'sr_ME': 'српски (Црна Гора)',
  'fr_CG': 'français (Congo-Brazzaville)',
  'he_IL': 'עברית (ישראל)',
  'zh_Hans': '中文 (简体中文)',
  'pa_Guru_IN': 'ਪੰਜਾਬੀ (ਗੁਰਮੁਖੀ, ਭਾਰਤ)',
  'he': 'עברית',
  'se': 'davvisámegiella',
  'en_TT': 'English (Trinidad & Tobago)',
  'sn': 'chiShona',
  'mr_IN': 'मराठी (भारत)',
  'es_DO': 'español (República Dominicana)',
  'ar_JO': 'العربية (الأردن)',
  'fa_IR': 'فارسی (ایران)',
  'fr_MC': 'français (Monaco)',
  'vi': 'Tiếng Việt',
  'nb_NO': 'norsk bokmål (Norge)',
  'nl_CW': 'Nederlands (Curaçao)',
  'sw_UG': 'Kiswahili (Uganda)',
  'fa': 'فارسی',
  'ks_Arab': 'کٲشُر (اَربی)',
  'uz_Cyrl': 'Ўзбек (Кирил)',
  'fr_BJ': 'français (Bénin)',
  'nl_BQ': 'Nederlands (Caribisch Nederland)',
  'en_GH': 'English (Ghana)',
  'da_DK': 'dansk (Danmark)',
  'lu_CD': 'Tshiluba (Ditunga wa Kongu)',
  'lo': 'ລາວ',
  'en_BZ': 'English (Belize)',
  'ta_MY': 'தமிழ் (மலேஷியா)',
  'sr_Latn_BA': 'srpski (latinica, Bosna i Hercegovina)',
  'fr_RW': 'français (Rwanda)',
  'en_PK': 'English (Pakistan)',
  'ar_LB': 'العربية (لبنان)',
  'ru_KG': 'русский (Киргизия)',
  'ff_CM': 'Pulaar (Kameruun)',
  'so_ET': 'Soomaali (Itoobiya)',
  'en_JM': 'English (Jamaica)',
  'cs': 'čeština',
  'te': 'తెలుగు',
  'en_MS': 'English (Montserrat)',
  'as': 'অসমীয়া',
  'ca_ES': 'català (Espanya)',
  'ar_TD': 'العربية (تشاد)',
  'de_DE': 'Deutsch (Deutschland)',
  'zh_Hant': '中文 (繁體)',
  'en_PR': 'English (Puerto Rico)',
  'ta_SG': 'தமிழ் (சிங்கப்பூர்)',
  'id': 'Bahasa Indonesia',
  'en_NU': 'English (Niue)',
  'uz': 'oʻzbekcha',
  'fr_BF': 'français (Burkina Faso)',
  'se_NO': 'davvisámegiella (Norga)',
  'pt_BR': 'português (Brasil)',
  'sq_XK': 'shqip (Kosovë)',
  'ig_NG': 'Igbo (Nigeria)',
  'fr_GA': 'français (Gabon)',
  'en_GD': 'English (Grenada)',
  'zh_TW': '中文 (台湾)',
  'en_PG': 'English (Papua New Guinea)',
  'bn_BD': 'বাংলা (বাংলাদেশ)',
  'fr_NE': 'français (Niger)',
  'lv': 'latviešu',
  'no': 'Norwegian',
  'os_GE': 'ирон (Гуырдзыстон)',
  'af': 'Afrikaans',
  'fr_FR': 'français (France)',
  'gl_ES': 'galego (España)',
  'sr_Latn_XK': 'srpski (latinica, Kosovo)',
  'sw': 'Kiswahili',
  'en_SX': 'English (Sint Maarten)',
  'da': 'dansk',
  'yo_BJ': 'Èdè Yorùbá (Orílɛ́ède Bɛ̀nɛ̀)',
  'en_AI': 'English (Anguilla)',
  'zh_Hant_MO': '中文 (繁體, 中華人民共和國澳門特別行政區)',
  'nl_AW': 'Nederlands (Aruba)',
  'cs_CZ': 'čeština (Česká republika)',
  'ti': 'ትግርኛ',
  'ar_SO': 'العربية (الصومال)',
  'th': 'ไทย',
  'uk_UA': 'українська (Україна)',
  'fy': 'West-Frysk',
  'sr_Latn_ME': 'srpski (latinica, Crna Gora)',
  'pt_MO': 'português (Macau, RAE da China)',
  'fr_DJ': 'français (Djibouti)',
  'am_ET': 'አማርኛ (ኢትዮጵያ)',
  'sv': 'svenska',
  'da_GL': 'dansk (Grønland)',
  'zh_Hant_TW': '中文 (繁體, 台灣)',
  'pa_IN': 'ਪੰਜਾਬੀ (ਭਾਰਤ)',
  'zh_MO': '中文 (中国澳门特别行政区)',
  'es_UY': 'español (Uruguay)',
  'sk_SK': 'slovenčina (Slovensko)',
  'nn': 'nynorsk',
  'en_BW': 'English (Botswana)',
  'zu_ZA': 'isiZulu (i-South Africa)',
  'ro_RO': 'română (România)',
  'en_NA': 'English (Namibia)',
  'ki': 'Gikuyu',
  'es_BO': 'español (Bolivia)',
  'ms_Latn_SG': 'Bahasa Melayu (Latin, Singapura)',
  'bm': 'bamanakan',
  'lb': 'Lëtzebuergesch',
  'en_BB': 'English (Barbados)',
  'sv_FI': 'svenska (Finland)',
  'mn_MN': 'монгол (Монгол)',
  'es': 'español',
  'sr_Cyrl': 'српски (ћирилица)',
  'gv_IM': 'Gaelg (Ellan Vannin)',
  'uz_Cyrl_UZ': 'Ўзбек (Кирил, Ўзбекистон)',
  'fr_CA': 'français (Canada)',
  'ak_GH': 'Akan (Gaana)',
  'az_Latn_AZ': 'azərbaycan (latın, Azərbaycan)',
  'pl_PL': 'polski (Polska)',
  'nl_SR': 'Nederlands (Suriname)',
  'en_SL': 'English (Sierra Leone)',
  'lt_LT': 'lietuvių (Lietuva)',
  'ko_KP': '한국어 (조선 민주주의 인민 공화국)',
  'pt_MZ': 'português (Moçambique)',
  'so_DJ': 'Soomaali (Jabuuti)',
  'ar': 'العربية',
  'bs_Latn_BA': 'bosanski (latinica, Bosna i Hercegovina)',
  'en_TK': 'English (Tokelau)',
  'fr_TN': 'français (Tunisie)',
  'ak': 'Akan',
  'nb': 'norsk bokmål',
  'de_BE': 'Deutsch (Belgien)',
  'en_UM': 'English (U.S. Outlying Islands)',
  'ar_ER': 'العربية (أريتريا)',
  'uz_AF': 'oʻzbekcha (Afgʻoniston)',
  'nl_BE': 'Nederlands (België)',
  'ru_UA': 'русский (Украина)',
  'pa_Guru': 'ਪੰਜਾਬੀ (ਗੁਰਮੁਖੀ)',
  'es_PR': 'español (Puerto Rico)',
  'es_GQ': 'español (Guinea Ecuatorial)',
  'ar_EG': 'العربية (مصر)',
  'hr_HR': 'hrvatski (Hrvatska)',
  'ar_IQ': 'العربية (العراق)',
  'kl_GL': 'kalaallisut (Kalaallit Nunaat)',
  'ln': 'lingála',
  'en_GI': 'English (Gibraltar)',
  'nd_ZW': 'isiNdebele (Zimbabwe)',
  'ii': 'ꆈꌠꉙ',
  'te_IN': 'తెలుగు (భారత దేశం)',
  'ms_Latn_MY': 'Bahasa Melayu (Latin, Malaysia)',
  'bo_CN': 'བོད་སྐད་ (རྒྱ་ནག)',
  'en_MG': 'English (Madagascar)',
  'ta_LK': 'தமிழ் (இலங்கை)',
  'uz_UZ': 'oʻzbekcha (Oʻzbekiston)',
  'ms_Latn': 'Bahasa Melayu (Latin)',
  'az_Latn': 'azərbaycan (latın)',
  'bs_Cyrl': 'босански (Ћирилица)',
  'fr_CM': 'français (Cameroun)',
  'en_VG': 'English (British Virgin Islands)',
  'so': 'Soomaali'
};
