
import 'dart:ffi';

class Customer {
  String lastName;
  String firstName;
  String birthday;
  String email;
  String phoneNumber;
  String whatsappNumber;

  Customer(
      {
        this.lastName = '',
        this.firstName = '',
        this.birthday = '',
        this.email = '',
        this.phoneNumber = '',
        this.whatsappNumber = ''
      }
  );
}

class Course {
  int kursID;
  String kursName;
  String kursPrice;
  String kursBeschreibung;
  bool hatFixTermin;
  bool istKursAktive;
  String teilnehmerBegrenzung;
  String kursDauer;
  String minAlter;
  String maxAlter;

  Course(
      {
        this.kursID = 0,
        this.kursName = '',
        this.kursPrice = '',
        this.kursBeschreibung = '',
        this.hatFixTermin = false,
        this.istKursAktive = false,
        this.teilnehmerBegrenzung = '',
        this.kursDauer = '',
        this.minAlter = '',
        this.maxAlter = '',

      }
  );
}

class OpenTime {
  late String day;
  late String openTime;
  late String closeTime;

  OpenTime(this.day, this.openTime, this.closeTime);

  OpenTime.fromJson(Map<String, dynamic> json){
    day = json['day'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
  }

  Map toJson() => {
    'day': day,
    'openTime': openTime,
    'closeTime': closeTime,
  };
}

class SwimmingPool {
  int schwimmbadID;
  String name;
  String adresse;
  String telefonnummer;
  late List<OpenTime> oeffnungszeiten;

  SwimmingPool(
      {
        this.schwimmbadID = 0,
        this.name = '',
        this.adresse = '',
        this.telefonnummer = '',
        required this.oeffnungszeiten
      }
  );
}