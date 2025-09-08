import '../models/question.dart';
import 'package:flutter/material.dart';

// ទិន្នន័យសំណួរសម្រាប់ Categories នីមួយៗ
final Map<String, List<Question>> categorizedQuizQuestions = {
  'ចំរុះ': [
    Question(
      id: 'gen_001', // Added ID
      questionText: 'តើភពផែនដីវិលជុំវិញអ្វី?',
      options: ['ក) ព្រះច័ន្ទ', 'ខ) ព្រះអាទិត្យ', 'គ) ភពអង្គារ', 'ឃ) ផែនដី'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'gen_002', // Added ID
      questionText: 'តើមហាសមុទ្រណាធំជាងគេ?',
      options: ['ក) ឥណ្ឌា', 'ខ) អាត្លង់ទិក', 'គ) ប៉ាស៊ីហ្វិក', 'ឃ) អាកទិក'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_003', // Added ID
      questionText: 'តើបេះដូងមនុស្សមានប៉ុន្មានបន្ទប់?',
      options: ['ក) ២', 'ខ) ៣', 'គ) ៤', 'ឃ) ៥'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_004', // Added ID
      questionText: 'តើត្រីផ្សោតជាថនិកសត្វ ឬ ត្រី?',
      options: ['ក) ថនិកសត្វ', 'ខ) ត្រី', 'គ) សត្វលូនវារ', 'ឃ) សត្វស្លាប'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'gen_005', // Added ID
      questionText: 'តើប្រទេសជប៉ុនស្ថិតនៅទ្វីបណា?',
      options: ['ក) អឺរ៉ុប', 'ខ) អាហ្រ្វិក', 'គ) អាស៊ី', 'ឃ) អាមេរិក'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_006', // Added ID
      questionText: 'តើមួយឆ្នាំមានប៉ុន្មានថ្ងៃ?',
      options: ['ក) ៣៦០', 'ខ) ៣៦៥', 'គ) ៣៦៦', 'ឃ) ៣៥០'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'gen_007', // Added ID
      questionText: 'តើទឹកកកជាស្ថានភាពអ្វីរបស់ទឹក?',
      options: ['ក) រាវ', 'ខ) ឧស្ម័ន', 'គ) រឹង', 'ឃ) ប្លាស្មា'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_008', // Added ID
      questionText: 'តើពន្លឺធ្វើដំណើរលឿនជាងសម្លេងឬអត់?',
      options: [
        'ក) លឿនជាង',
        'ខ) យឺតជាង',
        'គ) ស្មើគ្នា',
        'ឃ) អាស្រ័យលើបរិយាកាស',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'gen_009', // Added ID
      questionText: 'តើកីឡាអូឡាំពិករៀបចំឡើងប៉ុន្មានឆ្នាំម្តង?',
      options: ['ក) ២ឆ្នាំ', 'ខ) ៣ឆ្នាំ', 'គ) ៤ឆ្នាំ', 'ឃ) ៥ឆ្នាំ'],
      correctAnswerIndex: 2,
    ),
  ],
  'ភូមិសាស្ត្រ': [
    Question(
      id: 'geo_001', // Added ID
      questionText: 'តើរាជធានីភ្នំពេញស្ថិតនៅប្រទេសណា?',
      options: ['ក) ឡាវ', 'ខ) វៀតណាម', 'គ) ថៃ', 'ឃ) កម្ពុជា'],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 'geo_002', // Added ID
      questionText: 'តើទន្លេណាវែងជាងគេលើពិភពលោក?',
      options: [
        'ក) ទន្លេមេគង្គ',
        'ខ) ទន្លេនីល',
        'គ) ទន្លេអាម៉ាហ្សូន',
        'ឃ) ទន្លេយង់ហ្សេ',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'geo_003', // Added ID
      questionText: 'តើប្រទេសណាមានផ្ទៃដីធំជាងគេលើពិភពលោក?',
      options: ['ក) កាណាដា', 'ខ) រុស្ស៊ី', 'គ) ចិន', 'ឃ) សហរដ្ឋអាមេរិក'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'geo_004', // Added ID
      questionText: 'តើប្រទេសចិនស្ថិតនៅទ្វីបណា?',
      options: ['ក) អឺរ៉ុប', 'ខ) អាមេរិកខាងជើង', 'គ) អាស៊ី', 'ឃ) អាហ្រ្វិក'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'geo_005', // Added ID
      questionText: 'តើវាលខ្សាច់ Sahara ស្ថិតនៅទ្វីបណា?',
      options: [
        'ក) អាស៊ី',
        'ខ) អាហ្រ្វិក',
        'គ) អូស្ត្រាលី',
        'ឃ) អាមេរិកខាងត្បូង',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'geo_006', // Added ID
      questionText: 'តើភ្នំដែលខ្ពស់ជាងគេនៅលើពិភពលោកមានឈ្មោះអ្វី?',
      options: [
        'ក) ភ្នំគូលែន',
        'ខ) ភ្នំអេវឺរេស',
        'គ) ភ្នំគីលីម៉ាន់ចារ៉ូ',
        'ឃ) ភ្នំហ្វូជី',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'geo_007', // Added ID
      questionText: 'តើទីក្រុងរ៉ូមជារាជធានីនៃប្រទេសណា?',
      options: ['ក) បារាំង', 'ខ) អេស្ប៉ាញ', 'គ) អ៊ីតាលី', 'ឃ) អាល្លឺម៉ង់'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'geo_008', // Added ID
      questionText: 'តើប្រទេសណាដែលល្បីល្បាញដោយសារ Pyramid?',
      options: ['ក) ក្រិក', 'ខ) ទួរគី', 'គ) អេហ្ស៊ីប', 'ឃ) ឥណ្ឌា'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'geo_009', // Added ID
      questionText: 'តើទ្វីបណាដែលតូចជាងគេបំផុត?',
      options: ['ក) អាស៊ី', 'ខ) អូស្ត្រាលី', 'គ) អង់តាក់ទិក', 'ឃ) អឺរ៉ុប'],
      correctAnswerIndex: 1,
    ),
  ],
  'កីឡា': [
    Question(
      id: 'sport_001', // Added ID
      questionText: 'តើកីឡាប្រភេទអ្វី ដែលប្រើបាល់ទាត់ និងប្រើជើង?',
      options: ['ក) បាល់បោះ', 'ខ) បាល់ទះ', 'គ) បាល់ទាត់', 'ឃ) បាល់វាយកូនបាល់'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'sport_002', // Added ID
      questionText: 'តើកីឡាករបាល់ទាត់ Lionel Messi មកពីប្រទេសណា?',
      options: ['ក) ប្រេស៊ីល', 'ខ) បារាំង', 'គ) អាហ្សង់ទីន', 'ឃ) ព័រទុយហ្គាល់'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'sport_003', // Added ID
      questionText: 'តើការប្រកួតកីឡាអូឡាំពិករៀបចំឡើងប៉ុន្មានឆ្នាំម្តង?',
      options: ['ក) ២ឆ្នាំ', 'ខ) ៣ឆ្នាំ', 'គ) ៤ឆ្នាំ', 'ឃ) ៥ឆ្នាំ'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'sport_004', // Added ID
      questionText: 'តើកីឡាប្រដាល់មានប៉ុន្មានទឹក?',
      options: ['ក) ៣ទឹក', 'ខ) ៥ទឹក', 'គ) ៧ទឹក', 'ឃ) ១២ទឹក'],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 'sport_005', // Added ID
      questionText: 'តើកីឡាណាដែលប្រើរ៉ាកែត?',
      options: ['ក) បាល់ទាត់', 'ខ) បាល់បោះ', 'គ) វាយសី', 'ឃ) ហែលទឹក'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'sport_006', // Added ID
      questionText:
          'តើកីឡាបាល់បោះមានកីឡាករប៉ុន្មាននាក់នៅក្នុងទីលានសម្រាប់ក្រុមនីមួយៗ?',
      options: ['ក) ៤នាក់', 'ខ) ៥នាក់', 'គ) ៦នាក់', 'ឃ) ៧នាក់'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'sport_007', // Added ID
      questionText: 'តើកីឡាហែលទឹកមានប៉ុន្មានប្រភេទក្នុងការប្រកួតផ្លូវការ?',
      options: ['ក) ២', 'ខ) ៣', 'គ) ៤', 'ឃ) ៥'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'sport_008', // Added ID
      questionText: 'តើប្រទេសណាជាម្ចាស់ហូល? (World Cup)',
      options: ['ក) អាល្លឺម៉ង់', 'ខ) បារាំង', 'គ) អាហ្សង់ទីន', 'ឃ) ប្រេស៊ីល'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'sport_009', // Added ID
      questionText: 'តើកីឡាណាដែលលេងនៅលើទីលានរាងពេជ្រ?',
      options: ['ក) បាល់បោះ', 'ខ) បេស្បល', 'គ) កីឡាវាយកូនបាល់', 'ឃ) បាល់ទាត់'],
      correctAnswerIndex: 1,
    ),
  ],
  'ចំណេះដឹងទូទៅ': [
    Question(
      id: 'gen_know_001', // Added ID
      questionText: 'តើភាសាអ្វីដែលត្រូវបាននិយាយច្រើនជាងគេលើពិភពលោក?',
      options: ['ក) អង់គ្លេស', 'ខ) អេស្ប៉ាញ', 'គ) ចិនកុកងឺ', 'ឃ) ហិណ្ឌូ'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_know_002', // Added ID
      questionText: 'តើប្រទេសណាជាម្ចាស់ហូល? (World Cup)',
      options: ['ក) អាល្លឺម៉ង់', 'ខ) បារាំង', 'គ) អាហ្សង់ទីន', 'ឃ) ប្រេស៊ីល'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_know_003', // Added ID
      questionText: 'តើល្បឿនពន្លឺ ដំណើរក៏ដូច នៅក្នុងមូលនីតិ ?',
      options: ['ក) សុញ្ញកាស', 'ខ) កញ្ចក់ថ្លា', 'គ) ទឹក', 'ឃ) ពេជ្រ'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'gen_know_004', // Added ID
      questionText: 'តើអ្នកណាជាអ្នកបង្កើត Facebook?',
      options: [
        'ក) Elon Musk',
        'ខ) Bill Gates',
        'គ) Mark Zuckerberg',
        'ឃ) Jeff Bezos',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_know_005', // Added ID
      questionText: 'តើអ្វីជាឈ្មោះវិទ្យាសាស្ត្ររបស់មនុស្ស?',
      options: [
        'ក) Pan troglodytes',
        'ខ) Gorilla gorilla',
        'គ) Homo sapiens',
        'ឃ) Pongo pygmaeus',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_know_006', // Added ID
      questionText: 'តើប្រទេសណាដែលមានប្រជាជនច្រើនជាងគេលើពិភពលោក?',
      options: ['ក) ឥណ្ឌា', 'ខ) ចិន', 'គ) សហរដ្ឋអាមេរិក', 'ឃ) ឥណ្ឌូនេស៊ី'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'gen_know_007', // Added ID
      questionText: 'តើថ្ងៃណាជាបុណ្យឯករាជ្យជាតិរបស់កម្ពុជា?',
      options: ['ក) ៧ មករា', 'ខ) ១៣ មេសា', 'គ) ៩ វិច្ឆិកា', 'ឃ) ១៨ មិថុនា'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'gen_know_008', // Added ID
      questionText: 'តើភាសាអង់គ្លេសមានអក្សរប៉ុន្មាន?',
      options: ['ក) ២៤', 'ខ) ២៦', 'គ) ២៨', 'ឃ) ៣០'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'gen_know_009', // Added ID
      questionText: 'តើអ្វីជាឧបករណ៍ដែលប្រើសម្រាប់វាស់សីតុណ្ហភាព?',
      options: [
        'ក) Barometer',
        'ខ) Anemometer',
        'គ) Thermometer',
        'ឃ) Hydrometer',
      ],
      correctAnswerIndex: 2,
    ),
  ],
  'ទេសចរណ៍': [
    Question(
      id: 'tour_001', // Added ID
      questionText: 'តើប្រាសាទអង្គរវត្តស្ថិតនៅខេត្តណា?',
      options: ['ក) បាត់ដំបង', 'ខ) សៀមរាប', 'គ) កំពង់ចាម', 'ឃ) ភ្នំពេញ'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'tour_002', // Added ID
      questionText: 'តើប៉ម Eiffel ស្ថិតនៅទីក្រុងណា?',
      options: ['ក) ឡុងដ៍', 'ខ) រ៉ូម', 'គ) ប៉ារីស', 'ឃ) ប៊ែកឡាំង'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tour_003', // Added ID
      questionText: 'តើរូបសំណាកសេរីភាព (Statue of Liberty) ស្ថិតនៅប្រទេសណា?',
      options: ['ក) បារាំង', 'ខ) សហរដ្ឋអាមេរិក', 'គ) អាល្លឺម៉ង់', 'ឃ) អ៊ីតាលី'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'tour_004', // Added ID
      questionText: 'តើទីក្រុង Venice ស្ថិតនៅប្រទេសណា?',
      options: ['ក) អ៊ីតាលី', 'ខ) ក្រិក', 'គ) អេស្ប៉ាញ', 'ឃ) ព័រទុយហ្គាល់'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'tour_005', // Added ID
      questionText: 'តើអ្វីជាឈ្មោះភ្នំភ្លើងដ៏ល្បីល្បាញនៅជប៉ុន?',
      options: [
        'ក) ភ្នំ Fuji',
        'ខ) ភ្នំ Etna',
        'គ) ភ្នំ Vesuvius',
        'ឃ) ភ្នំ Kilimanjaro',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'tour_006', // Added ID
      questionText: 'តើទីក្រុងណាដែលត្រូវបានគេស្គាល់ថាជា "ទីក្រុងស្នេហា"?',
      options: ['ក) ញូវយ៉ក', 'ខ) ប៉ារីស', 'គ) ទីក្រុងឡុងដ៍', 'ឃ) រ៉ូម'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'tour_007', // Added ID
      questionText: 'តើជញ្ជាំងមហាប្រទេសចិនស្ថិតនៅប្រទេសណា?',
      options: ['ក) ឥណ្ឌា', 'ខ) ជប៉ុន', 'គ) ចិន', 'ឃ) កូរ៉េ'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tour_008', // Added ID
      questionText: 'តើប្រទេសណាដែលល្បីល្បាញដោយសារ Great Barrier Reef?',
      options: ['ក) នូវែលសេឡង់', 'ខ) អូស្ត្រាលី', 'គ) ហ្វីជី', 'ឃ) ឥណ្ឌូនេស៊ី'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'tour_009', // Added ID
      questionText: 'តើ Big Ben ស្ថិតនៅទីក្រុងណា?',
      options: ['ក) ប៉ារីស', 'ខ) ទីក្រុងឡុងដ៍', 'គ) ប៊ែកឡាំង', 'ឃ) ម៉ាឌ្រីដ'],
      correctAnswerIndex: 1,
    ),
  ],
  'បច្ចេកវិទ្យា': [
    Question(
      id: 'tech_001', // Added ID
      questionText: 'តើអ្នកណាជាស្ថាបនិកក្រុមហ៊ុន Microsoft?',
      options: [
        'ក) Steve Jobs',
        'ខ) Mark Zuckerberg',
        'គ) Bill Gates',
        'ឃ) Elon Musk',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tech_002', // Added ID
      questionText: 'តើភាសាកម្មវិធី Flutter ប្រើភាសាអ្វី?',
      options: ['ក) JavaScript', 'ខ) Python', 'គ) Dart', 'ឃ) Java'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tech_003', // Added ID
      questionText: 'តើអ្វីជាអក្សរកាត់សម្រាប់ World Wide Web?',
      options: ['ក) WWW', 'ខ) HTTP', 'គ) URL', 'ឃ) HTML'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'tech_004', // Added ID
      questionText: 'តើ RAM តំណាងឱ្យអ្វី?',
      options: [
        'ក) Read Access Memory',
        'ខ) Random Access Memory',
        'គ) Run Application Module',
        'ឃ) Remote Access Module',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'tech_005', // Added ID
      questionText: 'តើបណ្តាញអ៊ីនធឺណិតដំបូងគេមានឈ្មោះអ្វី?',
      options: ['ក) WWW', 'ខ) ARPANET', 'គ) Ethernet', 'ឃ) Netscape'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'tech_006', // Added ID
      questionText: 'តើឧបករណ៍អ្វីដែលប្រើសម្រាប់បញ្ចូលទិន្នន័យចូលកុំព្យូទ័រ?',
      options: ['ក) Monitor', 'ខ) Printer', 'គ) Keyboard', 'ឃ) Speaker'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tech_007', // Added ID
      questionText:
          'តើអ្វីជាប្រព័ន្ធប្រតិបត្តិការទូរស័ព្ទដែលត្រូវបានប្រើប្រាស់ច្រើនជាងគេ?',
      options: ['ក) iOS', 'ខ) Windows Phone', 'គ) Android', 'ឃ) BlackBerry OS'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tech_008', // Added ID
      questionText: 'តើ Hard Drive តំណាងឱ្យអ្វី?',
      options: [
        'ក) ឧបករណ៍បញ្ចូលទិន្នន័យ',
        'ខ) ឧបករណ៍បង្ហាញលទ្ធផល',
        'គ) ឧបករណ៍ផ្ទុកទិន្នន័យ',
        'ឃ) ឧបករណ៍បណ្តាញ',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'tech_009', // Added ID
      questionText: 'តើអ្វីជាភាសាសម្គាល់សម្រាប់បង្កើតទំព័រ Web?',
      options: ['ក) CSS', 'ខ) JavaScript', 'គ) Python', 'ឃ) HTML'],
      correctAnswerIndex: 3,
    ),
  ],
};

// categoriesData remains the same
final List<Map<String, dynamic>> categoriesData = [
  {'icon': Icons.lightbulb, 'name': 'ចំរុះ'},
  {'icon': Icons.map, 'name': 'ភូមិសាស្ត្រ'},
  {'icon': Icons.sports_basketball, 'name': 'កីឡា'},
  {'icon': Icons.menu_book, 'name': 'ចំណេះដឹងទូទៅ'},
  {'icon': Icons.location_on, 'name': 'ទេសចរណ៍'},
  {'icon': Icons.science, 'name': 'បច្ចេកវិទ្យា'},
];
