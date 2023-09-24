
class Parent {
  int parentID;
  List<int> studentID;
  String parentStatus;
  String parentFirstname;
  String parentLastname;
  String parentPhoneNumber;
  String parentWhatsapp;
  String parentEmail;
  String parentBalance;

  Parent(
      this.parentID,
      this.studentID,
      this.parentStatus,
      this.parentFirstname,
      this.parentLastname,
      this.parentPhoneNumber,
      this.parentWhatsapp,
      this.parentEmail,
      this.parentBalance
      );

  Map<String, dynamic> toJson() {
    return {
      'parentID': parentID,
      'studentID': studentID,
      'parentStatus': parentStatus,
      'parentFirstname': parentFirstname,
      'parentLastname': parentLastname,
      'parentPhoneNumber': parentPhoneNumber,
      'parentWhatsapp': parentWhatsapp,
      'parentEmail': parentEmail,
      'parentBalance': parentBalance,
    };
  }
}
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

class SwimCourse {
  final int courseID;
  final String courseName;
  final String coursePrice;
  final String? courseDescription;
  final int courseHasFixedDates;
  final String courseRange;
  final String courseDuration;
  bool isCourseVisible = false;

  SwimCourse(
      this.courseID,
      this.courseName,
      this.coursePrice,
      this.courseDescription,
      this.courseHasFixedDates,
      this.courseRange,
      this.courseDuration,
  );

  Map<String, dynamic> toJson() {
    return {
      'CourseID': courseID,
      'courseName': courseName,
      'coursePrice': coursePrice,
      'courseDescription' : courseDescription,
      'courseHasFixedDates': courseHasFixedDates,
      'courseRange': courseRange,
      'courseDuration': courseDuration,
      'isCourseVisible': isCourseVisible
    };
  }
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

class SwimPool {
  final int schwimmbadID;
  final String name;
  final String address;
  final String phoneNumber;
  final String openingTime;

  SwimPool(this.schwimmbadID, this.name, this.address, this.phoneNumber, this.openingTime);

  Map<String, dynamic> toJson() {
    return {
      'schwimmbadID': schwimmbadID,
      'name': name,
      'address': address,
      'phoneNumber' : phoneNumber,
      'openingTime': openingTime,
    };
  }
}

class SwimPools {
  final int schwimmbadID;
  final String name;
  final String address;
  final String phoneNumber;
  final List<OpenTime> openingTime;
  bool isSelected = false;

  SwimPools(this.schwimmbadID, this.name, this.address, this.phoneNumber, this.openingTime);

  Map<String, dynamic> toJson() {
    return {
      'schwimmbadID': schwimmbadID,
      'name': name,
      'address': address,
      'phoneNumber' : phoneNumber,
      'openingTime': openingTime,
      'isSelected': isSelected,
    };
  }
}

class Summary {
  String firstName = '';
  String lastName = '';
  String birthday = '';
  String saisonDropdownValue = '';
  String courseSelectedItem = '';
  List<String> swimPools = [];
  String titleValue = '';
  String firstNameParents = '';
  String lastNameParents = '';
  String address = '';
  String email = '';
  String phoneNumber = '';
// Fügen Sie hier weitere Felder hinzu, um die Zusammenfassung zu vervollständigen.
}