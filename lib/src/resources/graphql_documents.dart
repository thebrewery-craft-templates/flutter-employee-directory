const loginDocument = '''
  mutation loginUser(\$username : String!, \$password : String!) {
  
    logIn(input: {
      username: \$username,
      password: \$password
  }) {
    viewer {
      sessionToken
    }
  }
  
}
  ''';

const logoutDocument = '''mutation logOutUser {
  logOut(input: { clientMutationId: "logOut" }) {
    clientMutationId
    viewer {
      user {
        username
        email
      }
      sessionToken
    }
  }
}
  ''';

const signupDocument =
    """ mutation createUser(\$username : String!, \$password : String!, \$employee : EmployeePointerInput!) {
   
    createUser(input :{
      fields: {
      username: \$username
      password: \$password
      email: \$username
      employee: \$employee
      }}){
        
        user {
          objectId
        }
        
      }
    
  }""";

const checkEmployeeDocument = '''
  query getEmployeeInfo(\$username: String!) {
  employees(where: { primaryEmail: { equalTo: \$username } }) {
    count
    edges {
      cursor
      node {
        objectId
      }
    }
  }
}
''';

const updateEmloyeeInfo = '''
  mutation updateEmployeeInfo(\$employeeId : ID!, 
  \$firstname : String!, \$lastname : String!) {
       
        updateEmployee(input :{
          id: \$employeeId
          fields: {
              firstName: \$firstname
              lastName: \$lastname
            }
        }){
          employee {
            updatedAt
          }
        }
      
  }
''';

const getAllEmployeeDocument = '''query getEmployee {
    employees {
      edges {
        node {
          objectId
          firstName
          lastName
          primaryEmail
          primaryMobile
          imageUrl
          position {
            title
          }
        }
      }
    }
  }''';

const getMyInfoDocument = '''
query Me {
  viewer {
    user{
      username
      employee {
          objectId
          firstName
          lastName
          primaryEmail
          primaryMobile
          imageUrl
          position {
            title
          }
          
        }
      }
    }
  }''';

const createEmployee = '''
  mutation insertEmployee(\$firstname : String!, 
    \$lastname : String!, \$primaryMobile : String!, \$primaryEmail : String!,
    \$imageUrl : String!, \$position : PositionPointer!) {
    objects {
      createEmployee(
        fields:{
          firstName: \$firstname
          lastName: \$lastname
          primaryMobile:\$primaryMobile
          primaryEmail:\$primaryEmail
          imageUrl:\$imageUrl
          position: \$position
        }){
        createdAt
      }
    }
  }
''';
