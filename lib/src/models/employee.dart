import 'position.dart';
import '../widgets/brewery/brewery_scrollablelist_with_header.dart';

class Employee extends ListItemData {
  final String id;
  final String firstName;
  final String lastName;
  final String primaryNumber;
  final String primaryEmail;
  final String imageUrl;
  final Position position;

  Employee(String id, String firstName, String lastName, String primaryNumber,
      String primaryEmail, Position position,
      {String imageUrl})
      : this.id = id,
        this.firstName = firstName,
        this.lastName = lastName,
        this.primaryNumber = primaryNumber,
        this.primaryEmail = primaryEmail,
        this.position = position,
        this.imageUrl = imageUrl,
        super('$firstName $lastName', imageUrl);

  Employee.fromJson(Map<String, dynamic> data)
      : this.id = data['node']['objectId'],
        this.firstName = data['node']['firstName'],
        this.lastName = data['node']['lastName'],
        this.primaryNumber = data['node']['primaryMobile'],
        this.primaryEmail = data['node']['primaryEmail'],
        this.position = Position.fromJson(data['node']['position']),
        this.imageUrl = data['node']['imageUrl'],
        super('${data['node']['firstName']} ${data['node']['lastName']}',
            data['node']['imageUrl']);

  Employee.fromInfoJSON(Map<String, dynamic> data)
      : this.id = data['objectId'],
        this.firstName = data['firstName'],
        this.lastName = data['lastName'],
        this.primaryNumber = data['primaryMobile'],
        this.primaryEmail = data['primaryEmail'],
        this.position = Position.fromJson(data['position']),
        this.imageUrl = data['imageUrl'],
        super('${data['firstName']} ${data['lastName']}', data['imageUrl']);
}
