
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
  final int courseID;
  final String courseName;
  final String coursePrice;
  final String courseDescription;
  final int courseHasFixedDates;
  final String courseRange;
  final String courseDuration;

  Course(
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