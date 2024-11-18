import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'hi'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? hiText = '',
  }) =>
      [enText, hiText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Home
  {
    'f15yeth5': {
      'en': 'Welcome',
      'hi': '',
    },
    'iwn1h03a': {
      'en': 'Schedule Overview',
      'hi': '',
    },
    's5ovkvf3': {
      'en': 'More',
      'hi': '',
    },
    'uo3dbypz': {
      'en': 'Upcoming Tests',
      'hi': '',
    },
    '8zc4c2z7': {
      'en': 'More',
      'hi': '',
    },
    'd7r7v67n': {
      'en': 'No upcoming tests',
      'hi': '',
    },
    '04k2qg0i': {
      'en': 'Upcoming Assignments',
      'hi': '',
    },
    'rkbap6rk': {
      'en': 'More',
      'hi': '',
    },
    'wfsqskmw': {
      'en': 'Attendance ',
      'hi': '',
    },
    '7dj1meqx': {
      'en': 'More',
      'hi': '',
    },
    'nyoo5ol2': {
      'en': 'Home',
      'hi': '',
    },
    'ltqn4rws': {
      'en': 'Home',
      'hi': '',
    },
  },
  // AuthPage
  {
    '680bkndm': {
      'en': 'IQnaut',
      'hi': '',
    },
    '9mn21kbv': {
      'en': 'Welcome Back',
      'hi': '',
    },
    '2u9ixbnh': {
      'en': 'Email Address',
      'hi': '',
    },
    'bp82px1z': {
      'en': 'Enter your email',
      'hi': '',
    },
    'mn9c2ch1': {
      'en': 'Password',
      'hi': '',
    },
    'g5tactns': {
      'en': 'Enter your password',
      'hi': '',
    },
    'zjjl5a37': {
      'en': 'Forgot password?',
      'hi': '',
    },
    '3vqpct61': {
      'en': 'Login',
      'hi': '',
    },
    'ybvc241e': {
      'en': 'Home',
      'hi': '',
    },
  },
  // Attendance
  {
    '1m3cxiaf': {
      'en': '',
      'hi': '',
    },
    'rlkgjt7v': {
      'en': 'Select class...',
      'hi': '',
    },
    'oiloxbtj': {
      'en': 'Search for class...',
      'hi': '',
    },
    'q8dxr4mt': {
      'en': 'Attendance',
      'hi': '',
    },
    'u55qt2a9': {
      'en': 'No lecture',
      'hi': '',
    },
    'c620d7n7': {
      'en': 'History',
      'hi': '',
    },
    'm813l9j4': {
      'en': 'No lecture',
      'hi': '',
    },
    'uleibnrx': {
      'en': 'Attendance',
      'hi': '',
    },
    'e5cj8tyz': {
      'en': 'Attendance',
      'hi': '',
    },
  },
  // AssignmentCreate
  {
    'hyglxgiu': {
      'en': 'Create Assignment',
      'hi': '',
    },
    'a36vwkk5': {
      'en': 'Title',
      'hi': '',
    },
    'lo8xlx7w': {
      'en': 'Topic',
      'hi': '',
    },
    '5d2ylgqy': {
      'en': 'Option 1',
      'hi': '',
    },
    'gnv5iv2w': {
      'en': 'Subject',
      'hi': '',
    },
    'xgcvxqd5': {
      'en': 'Search for an item...',
      'hi': '',
    },
    'xoqlss0o': {
      'en': 'Points',
      'hi': '',
    },
    'cbc1hcj9': {
      'en': 'Description',
      'hi': '',
    },
    'jfkh4cmt': {
      'en': 'Set Due Date',
      'hi': '',
    },
    '1ike2tjq': {
      'en': 'Assign To',
      'hi': '',
    },
    'ufjj7xk5': {
      'en': 'Class',
      'hi': '',
    },
    'ahlcp9m3': {
      'en': 'Class',
      'hi': '',
    },
    '3ozuxa0m': {
      'en': 'Individual',
      'hi': '',
    },
    'tzjtcwv2': {
      'en': 'Assign',
      'hi': '',
    },
    'hq01cny7': {
      'en': 'Assignment',
      'hi': '',
    },
    'awe7s21h': {
      'en': 'Home',
      'hi': '',
    },
  },
  // AssignmentPast
  {
    '1bj3oihw': {
      'en': 'Description',
      'hi': '',
    },
    '45nr0ree': {
      'en': 'Scoring',
      'hi': '',
    },
    'j131exe0': {
      'en': 'Roll No',
      'hi': '',
    },
    'a4aw2d5o': {
      'en': 'Name',
      'hi': '',
    },
    'dsxy2ypx': {
      'en': 'Points',
      'hi': '',
    },
    'u343hh2t': {
      'en': 'Max Pts',
      'hi': '',
    },
    '6hig5wdr': {
      'en': 'Assignment',
      'hi': '',
    },
    '5tw86o3w': {
      'en': 'Home',
      'hi': '',
    },
  },
  // AssignmentPending
  {
    '4syuqqzy': {
      'en': 'Description',
      'hi': '',
    },
    'td8sv0kl': {
      'en': 'Scoring',
      'hi': '',
    },
    '43d5xecj': {
      'en': 'Roll No',
      'hi': '',
    },
    'xtnd1kpu': {
      'en': 'Name',
      'hi': '',
    },
    'afbb5il1': {
      'en': 'Points',
      'hi': '',
    },
    '6ktj5wwc': {
      'en': 'Max Pts',
      'hi': '',
    },
    '8das9e6l': {
      'en': 'Save Scores',
      'hi': '',
    },
    'p8of12ye': {
      'en': 'Assignment',
      'hi': '',
    },
    'xpvbgbaz': {
      'en': 'Home',
      'hi': '',
    },
  },
  // Assignments
  {
    'yoioctfm': {
      'en': '',
      'hi': '',
    },
    '5zxj85nz': {
      'en': 'Select class...',
      'hi': '',
    },
    '4vstnte8': {
      'en': 'Search for class...',
      'hi': '',
    },
    'mzmg0eer': {
      'en': 'Pending',
      'hi': '',
    },
    'j7m63l6n': {
      'en': 'Upcoming',
      'hi': '',
    },
    'hnr0hfza': {
      'en': 'Past',
      'hi': '',
    },
    'krz6q03h': {
      'en': 'Assignment',
      'hi': '',
    },
    'ihdlvf84': {
      'en': 'Assignments',
      'hi': '',
    },
  },
  // AssignmentUpcoming
  {
    'jo8p81kz': {
      'en': 'This is an upcoming assignment. It cannot be evaluated now.',
      'hi': '',
    },
    'i9xacpph': {
      'en': 'Assignment',
      'hi': '',
    },
    'ewbnau1v': {
      'en': 'Home',
      'hi': '',
    },
  },
  // AttendanceMarking
  {
    '411qs1nq': {
      'en': 'Roll No',
      'hi': '',
    },
    '6zwfmlwp': {
      'en': 'Name',
      'hi': '',
    },
    'yo09rpz5': {
      'en': 'Present',
      'hi': '',
    },
    '65da8dwe': {
      'en': 'Attendance',
      'hi': '',
    },
    '0eoukm3i': {
      'en': 'Home',
      'hi': '',
    },
  },
  // TestCreate
  {
    't0x215tj': {
      'en': 'Create Test',
      'hi': '',
    },
    'frrx0c1x': {
      'en': 'Topic-wise',
      'hi': '',
    },
    '4g34uukn': {
      'en': 'Unit Test',
      'hi': '',
    },
    'rundxk0v': {
      'en': 'Select test type...',
      'hi': '',
    },
    'qo20uae4': {
      'en': 'Search for an item...',
      'hi': '',
    },
    'pjig3qwx': {
      'en': 'Title',
      'hi': '',
    },
    'ixcggfqi': {
      'en': 'Topic',
      'hi': '',
    },
    'kojpr6u5': {
      'en': 'Option 1',
      'hi': '',
    },
    '3skw69t8': {
      'en': 'Subject',
      'hi': '',
    },
    '9yctqavr': {
      'en': 'Search for a subject...',
      'hi': '',
    },
    'tg83n8z2': {
      'en': 'Points',
      'hi': '',
    },
    'c8lylwbd': {
      'en': 'Passing marks',
      'hi': '',
    },
    'p512wm48': {
      'en': 'Description',
      'hi': '',
    },
    'k4wh9m5f': {
      'en': 'Set Date and Time',
      'hi': '',
    },
    'yt37264i': {
      'en': 'Assign To',
      'hi': '',
    },
    'r2cqh6vo': {
      'en': 'Class',
      'hi': '',
    },
    'suyvqgfj': {
      'en': 'Class',
      'hi': '',
    },
    'qi61hzp8': {
      'en': 'Individual',
      'hi': '',
    },
    'ew1ti5ih': {
      'en': 'Assign',
      'hi': '',
    },
    'lrys5d83': {
      'en': 'Test',
      'hi': '',
    },
    'zkwnige6': {
      'en': 'Home',
      'hi': '',
    },
  },
  // Tests
  {
    '0de9ul5n': {
      'en': 'Test',
      'hi': '',
    },
    'ma1owg7v': {
      'en': 'List of Tests',
      'hi': '',
    },
    'gae4ix30': {
      'en': 'Topic-wise Test',
      'hi': '',
    },
    '4zlo6743': {
      'en': 'Unit Test',
      'hi': '',
    },
    '5sr8tg2i': {
      'en': 'Semester Exam',
      'hi': '',
    },
    'gabf4877': {
      'en': 'Final Exam',
      'hi': '',
    },
    'twrokx8t': {
      'en': 'Tests',
      'hi': '',
    },
  },
  // TestUpcoming
  {
    '330easg0': {
      'en': 'This is an upcoming test. It cannot be evaluated now.',
      'hi': '',
    },
    '82i5gog9': {
      'en': 'Test',
      'hi': '',
    },
    '1e79pnmm': {
      'en': 'Home',
      'hi': '',
    },
  },
  // TestPast
  {
    'q6v78kzt': {
      'en': 'Description',
      'hi': '',
    },
    'drl0v92s': {
      'en': 'Scoring',
      'hi': '',
    },
    'f05o2rzd': {
      'en': 'All',
      'hi': '',
    },
    '861y3pl0': {
      'en': 'All',
      'hi': '',
    },
    '6h7t7wko': {
      'en': 'Passed',
      'hi': '',
    },
    'zmih4vsg': {
      'en': 'Failed',
      'hi': '',
    },
    '666ck81t': {
      'en': 'Please select...',
      'hi': '',
    },
    'ovad7paj': {
      'en': 'Search for an item...',
      'hi': '',
    },
    'b11ijaaq': {
      'en': 'Roll No',
      'hi': '',
    },
    '800ljiwq': {
      'en': 'Name',
      'hi': '',
    },
    'n8c4dcxi': {
      'en': 'Points',
      'hi': '',
    },
    'hdeu4ji9': {
      'en': 'Max Pts',
      'hi': '',
    },
    'vzt16a0x': {
      'en': 'Test',
      'hi': '',
    },
    'x97eoebp': {
      'en': 'Home',
      'hi': '',
    },
  },
  // TestPending
  {
    'ry2qi46o': {
      'en': 'Description',
      'hi': '',
    },
    'pu56ps3u': {
      'en': 'Scoring',
      'hi': '',
    },
    '35bf9w5e': {
      'en': 'Roll No',
      'hi': '',
    },
    'ddi17e7a': {
      'en': 'Name',
      'hi': '',
    },
    'rkumu4qy': {
      'en': 'Points',
      'hi': '',
    },
    'ygisptxy': {
      'en': 'Max Pts',
      'hi': '',
    },
    'fywv1nga': {
      'en': 'Save Scores',
      'hi': '',
    },
    's6o74crm': {
      'en': 'Test',
      'hi': '',
    },
    'ekgre55z': {
      'en': 'Home',
      'hi': '',
    },
  },
  // NoticeBoard
  {
    'tztnblz8': {
      'en': 'School',
      'hi': '',
    },
    'nblv9byr': {
      'en': 'Parents',
      'hi': '',
    },
    'bzjowt3s': {
      'en': 'Approve',
      'hi': '',
    },
    'czzghv4d': {
      'en': 'Reject',
      'hi': '',
    },
    'zf1gcfgj': {
      'en': 'Notice Board',
      'hi': '',
    },
    '1erafut4': {
      'en': 'Home',
      'hi': '',
    },
  },
  // EditProfile
  {
    'g5vy6qqy': {
      'en': 'Personal Information',
      'hi': '',
    },
    'lha68qzt': {
      'en': 'Full Name',
      'hi': '',
    },
    'wjdvzz82': {
      'en': 'Email',
      'hi': '',
    },
    '42yz8ri9': {
      'en': 'Address',
      'hi': '',
    },
    '9t5a3v1t': {
      'en': 'Educational Qualification',
      'hi': '',
    },
    'qkgxljy6': {
      'en': 'University',
      'hi': '',
    },
    'i073qm6a': {
      'en': 'Blood Group',
      'hi': '',
    },
    'qgr80pc9': {
      'en': 'Contact ',
      'hi': '',
    },
    'jvxumv2m': {
      'en': 'Male',
      'hi': '',
    },
    'qt10a07d': {
      'en': 'Male',
      'hi': '',
    },
    'ci6twusr': {
      'en': 'Female',
      'hi': '',
    },
    'bpuzwm76': {
      'en': 'Gender',
      'hi': '',
    },
    'tzyf78md': {
      'en': 'Search for an item...',
      'hi': '',
    },
    'w1qw8my2': {
      'en': 'Class Information',
      'hi': '',
    },
    'ddhn7p29': {
      'en': 'Class Teacher of class',
      'hi': '',
    },
    'vs5y7pju': {
      'en': 'Subjects Taught',
      'hi': '',
    },
    'm53jno19': {
      'en': 'Subjects and Classes',
      'hi': '',
    },
    'h4nrtipr': {
      'en': 'Save Changes',
      'hi': '',
    },
    '8luxgtsf': {
      'en': 'Edit Profile',
      'hi': '',
    },
    'i2fmk91p': {
      'en': 'Home',
      'hi': '',
    },
  },
  // ResetPassword
  {
    '9zueakxk': {
      'en': 'Forgot Password',
      'hi': '',
    },
    '6qjit05u': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'hi': '',
    },
    'c1bngvbe': {
      'en': 'Enter your email',
      'hi': '',
    },
    '72v7lktr': {
      'en': 'Send Link',
      'hi': '',
    },
    'bxfsiohq': {
      'en': 'Reset Password',
      'hi': '',
    },
    'narjglon': {
      'en': 'Home',
      'hi': '',
    },
  },
  // Account
  {
    'vjkfuyot': {
      'en': 'Profile',
      'hi': '',
    },
    'yzbn9jjc': {
      'en': 'Settings',
      'hi': '',
    },
    'jjdn0gox': {
      'en': 'Privacy Policy',
      'hi': '',
    },
    'amoli293': {
      'en': 'FAQ & Help',
      'hi': '',
    },
    '4m4seo18': {
      'en': 'Terms & Conditions',
      'hi': '',
    },
    '24and2bv': {
      'en': 'Log Out',
      'hi': '',
    },
    'ylmekqa7': {
      'en': 'Account',
      'hi': '',
    },
    'j19q0gyi': {
      'en': 'Account',
      'hi': '',
    },
  },
  // MinorTests
  {
    'vvegsc5a': {
      'en': '',
      'hi': '',
    },
    'qmnvx7sx': {
      'en': 'Select class...',
      'hi': '',
    },
    'amxpa6az': {
      'en': 'Search for class...',
      'hi': '',
    },
    'z4gcq60s': {
      'en': 'Pending',
      'hi': '',
    },
    'x6xk848d': {
      'en': 'Upcoming',
      'hi': '',
    },
    'slkfyq4s': {
      'en': 'Past',
      'hi': '',
    },
    '3oc4txao': {
      'en': 'Tests',
      'hi': '',
    },
  },
  // Exams
  {
    'w96csslx': {
      'en': '',
      'hi': '',
    },
    'b32k9phh': {
      'en': 'Select class...',
      'hi': '',
    },
    'dv6ildym': {
      'en': 'Search for class...',
      'hi': '',
    },
    'cvgxjkf0': {
      'en': 'Pending',
      'hi': '',
    },
    'x2eq6qd4': {
      'en': 'Upcoming',
      'hi': '',
    },
    '8uek2c3p': {
      'en': 'Past',
      'hi': '',
    },
    'eqo2n572': {
      'en': 'Tests',
      'hi': '',
    },
  },
  // Messenger
  {
    'huqvc6bm': {
      'en': 'Messenger',
      'hi': '',
    },
    '67en7ivy': {
      'en': 'Home',
      'hi': '',
    },
  },
  // ComposeMessage
  {
    'gxi1u1ia': {
      'en': 'Option 1',
      'hi': '',
    },
    'xdy1as7l': {
      'en': ' Select Class',
      'hi': '',
    },
    'c18g6pu4': {
      'en': 'Search for an item...',
      'hi': '',
    },
    'ej2aoy2p': {
      'en': 'Compose Message',
      'hi': '',
    },
    '5twm8ijx': {
      'en': 'Type Here...',
      'hi': '',
    },
    'o1a6er4h': {
      'en': 'Remark',
      'hi': '',
    },
    'ugcnlvex': {
      'en': 'Select Recipients',
      'hi': '',
    },
    '16fc851w': {
      'en': 'Send To',
      'hi': '',
    },
    'wfxm6mom': {
      'en': 'Class',
      'hi': '',
    },
    '58a99hwy': {
      'en': 'Class',
      'hi': '',
    },
    'vnttktnn': {
      'en': 'Individual',
      'hi': '',
    },
    't50x6lr5': {
      'en': 'Send',
      'hi': '',
    },
    'wyuhtavo': {
      'en': 'Messenger',
      'hi': '',
    },
    '00h9bypw': {
      'en': 'Home',
      'hi': '',
    },
  },
  // AttendanceHistory
  {
    'nc4mr5se': {
      'en': 'Roll No',
      'hi': '',
    },
    'zt2tutwt': {
      'en': 'Name',
      'hi': '',
    },
    '76kvbyn7': {
      'en': 'Present',
      'hi': '',
    },
    'ojdeelqr': {
      'en': 'Attendance',
      'hi': '',
    },
    'm3ge7fqj': {
      'en': 'Home',
      'hi': '',
    },
  },
  // ScoreCard
  {
    'yoioctfm': {
      'en': '',
      'hi': '',
    },
    'xpc6914j': {
      'en': 'Pts',
      'hi': '',
    },
    'mu5ut5zq': {
      'en': 'Remark',
      'hi': '',
    },
    'jgfr61d7': {
      'en': 'Give remark',
      'hi': '',
    },
  },
  // AssignmentCard
  {
    'sx0x5tzu': {
      'en': 'Assigned to :',
      'hi': '',
    },
  },
  // TestCard
  {
    'r5eabct8': {
      'en': 'Assigned to :',
      'hi': '',
    },
  },
  // ImageUpload
  {
    'wskhxsb3': {
      'en': 'Upload file or image',
      'hi': '',
    },
  },
  // Miscellaneous
  {
    'e4ovbo89': {
      'en': '',
      'hi': '',
    },
    'gfwa3f4j': {
      'en': '',
      'hi': '',
    },
    'v4ddttbq': {
      'en': '',
      'hi': '',
    },
    '2qr6bw8z': {
      'en': '',
      'hi': '',
    },
    'iz7auyxe': {
      'en': '',
      'hi': '',
    },
    '1aviud98': {
      'en': '',
      'hi': '',
    },
    'gouf32by': {
      'en': '',
      'hi': '',
    },
    'mx6de1if': {
      'en': '',
      'hi': '',
    },
    'd7s33c5z': {
      'en': '',
      'hi': '',
    },
    'm297asmb': {
      'en': '',
      'hi': '',
    },
    'iw6nrerg': {
      'en': '',
      'hi': '',
    },
    'lv8209lv': {
      'en': '',
      'hi': '',
    },
    'rht6x5gw': {
      'en': '',
      'hi': '',
    },
    '5g2xxzwp': {
      'en': '',
      'hi': '',
    },
    '2qiecfqa': {
      'en': '',
      'hi': '',
    },
    'um51st6q': {
      'en': '',
      'hi': '',
    },
    'vwzlgjnl': {
      'en': '',
      'hi': '',
    },
    '797udj70': {
      'en': '',
      'hi': '',
    },
    'h38ggyr2': {
      'en': '',
      'hi': '',
    },
    'r98ovu1h': {
      'en': '',
      'hi': '',
    },
    'utekpnnz': {
      'en': '',
      'hi': '',
    },
    '9g7e1s40': {
      'en': '',
      'hi': '',
    },
    'dp7m806c': {
      'en': '',
      'hi': '',
    },
    '0rs5c9m3': {
      'en': '',
      'hi': '',
    },
    'l4iawlcx': {
      'en': '',
      'hi': '',
    },
  },
].reduce((a, b) => a..addAll(b));
