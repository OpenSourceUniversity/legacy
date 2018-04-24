
pragma solidity ^0.4.15;

/*import './StringUtils.sol';*/


contract OSUniCoreContract {

    // Functionality
    // 1. Courses
    //    - createCourse
    //    - certify
    //    - getAllSubjectsByAcademy
    //    - getAllCoursesByAcademy
    //    - getAllParticipants
    // 2. Learner
    //    - createLearner
    //    - getLearner
    //    - certifyLearner
    //    - addCourse
    //    - getCourses
    // 3. Business
    //    - createBusiness
    //    - getBusiness
    //    - listBusinesses
    //    - getLearnersBySkills
    // 4. Academia
    //    - createAcademia
    //    - getOwnCourses


    address public owner;

    struct Learner {
        address _address;
        bytes32 firstName;
        bytes32 lastName;
        bytes32[] skills;
    }

    struct Academy {
        address _address;
        bytes32 name;
    }

    struct Business {
        address _address;
        bytes32 name;
    }

    struct Course {
        Academy academy;
        bytes32 subject;
        bytes32 name;
        bytes32[] skills;
    }

    struct Certificate {
        Learner learner;
        Course course;
    }

    struct LClink {
      address _address;
      Course course;
    }

    Course[] courses;
    Academy[] academies;
    Business[] business;
    Learner[] learners;
    Certificate[] certificates;
    LClink[] LClinks;

    // HASH TABLES
    // Address of learner as a key
    mapping(address => Course[]) private LAB_courses;   // Fill in create courses
    mapping(address => Certificate[]) private learner_certificate;
    mapping(bytes32 => Learner[]) private skill_learners;  // Fill in



    /*mapping(Learner => Course[]) public learnerCourses;
    mapping(Course => Learner[]) public courseLearners;
    mapping(Academy => Course[]) public academyCourses;*/

    // MODIFIERS
    modifier isOwner() {
        if(owner != msg.sender) revert();
        _;
    }

    // CONSTRUCTOR
    function OSUniCoreContract() {
        owner = msg.sender;                                             // Owner of the contract
    }

    // COURSE
    function createCourse(
      address addressAcademy,
      bytes32 _subject,
      bytes32 _name,
      bytes32[] _skills
    ) returns (bool) {
      uint length = academies.length;
      for (uint i = 0; i < length; i++) {
          if(academies[i]._address == addressAcademy) {
              Academy memory _academy;
              courses.push(Course({ academy: _academy, subject: _subject, name: _name, skills: _skills }));
              LAB_courses[_academy._address].push(Course({
                  academy: _academy,
                  subject: _subject,
                  name: _name,
                  skills: _skills
              }));
              return true;
          }
      }
      return false;
    }

    // Cartification of learners
    function certify(Learner storage learner, Course storage course) internal returns (bool) {
        learner_certificate[learner._address].push(Certificate({
            learner: learner,
            course: course
          }));
        certificates.push(Certificate({
            learner: learner,
            course: course
        }));
        uint len = course.skills.length;
        for(uint i=0; i< len; i++) {
          learner.skills.push(course.skills[i]);
          skill_learners[course.skills[i]].push(learner);
        }
        return true;
    }

    // All Academies, Businesses and Learners can retreave subject titles
    // @_address - address of the academy
    function getAllSubjectsByAcademy(address _address) public returns (bytes32[]) {
        uint length = courses.length;
        bytes32[] memory result;
        uint j=0;
        for(uint i=0; i < length; i++) {
            if(courses[i].academy._address == _address) {
                result[j] = courses[i].subject;
                j++;
            }
        }
        return result;
    }

    // Retreave all course titles related to specific verified address
    // @_address - address of the academy
    function getAllCoursesByAcademy(address _address) public returns (bytes32[]) {
        uint length = courses.length;
        bytes32[] memory result;
        uint j=0;
        for(uint i=0; i < length; i++) {
            if(courses[i].academy._address == _address) {
                result[j] = courses[i].name;
                j++;
            }
        }
        return result;
    }

    // Get all participants to a particular course
    // @_address - address of the academy
    // @_subject - subject of a course
    // @_name - name of the course
    function getAllParticipants(address _address, bytes32 _subject, bytes32 _name) public returns (address[], bytes32[], bytes32[]) {
        uint length = certificates.length;
        address[] memory resultAddress;
        bytes32[] memory resultFirstName;
        bytes32[] memory resultLastName;
        uint j=0;
        for(uint i=0; i < length; i++) {
            if(certificates[i].course.academy._address == _address && certificates[i].course.subject == _subject && certificates[i].course.name == _name) {
                resultAddress[j] = certificates[i].learner._address;
                resultFirstName[j] = certificates[i].learner.firstName;
                resultLastName[j] = certificates[i].learner.lastName;
                j++;
            }
        }
        return (resultAddress, resultFirstName, resultLastName);
    }

    // Get course
    // @_address - address of the academy
    // @_subject - subject of a course
    // @_name - name of the course
    /*function getCourse(
      address _address,
      bytes32 _subject,
      bytes32 _name
    ) internal returns (Course) {
        uint length = courses.length;
        for (uint i = 0; i < length; i++) {
            if(courses[i]._address == addressLearner) {
                exist=true;
                break;
            }
        }
    }*/

    // LEARNER

    // Create learner
    // @_address - address of the learner
    // @firstName - first name
    // @lastName - last name
    function createLearner(
      address addressLearner,
      bytes32 _firstName,
      bytes32 _lastName
    ) public returns (bool) {
      uint length = learners.length;
      bool exist = false;
      for (uint i = 0; i < length; i++) {
          if(learners[i]._address == addressLearner) {
              exist=true;
              break;
          }
      }
      if(!exist) {
          bytes32[] storage _skills;
          learners.push(Learner({
              _address: addressLearner,
              firstName: _firstName,
              lastName: _lastName,
              skills: _skills
          }));
          return true;
      }
      return false;
    }

    // Get learner
    // @_address - address of the learner
    function getLearner(
      address addressLearner
    ) public returns (address, bytes32, bytes32, bytes32[]) {
        uint length = learners.length;

        bytes32 newfirstName;
        bytes32 newlastName;
        bytes32[] storage newSkills;

        for(uint i=0; i < length; i++) {
            if(learners[i]._address == addressLearner) {
                newfirstName = learners[i].firstName;
                newlastName = learners[i].lastName;
                return (addressLearner, newfirstName, newlastName, learners[i].skills);
            }
        }
        return (addressLearner, newfirstName, newlastName, newSkills);
    }

    // Certify learner
    // @addressLearner - address of the learner
    // @addressAcademy - address of the academy
    // @subjectCourse - title of the course subject
    // @nameCourse - name of the course
    function certifyLearner(
      address addressLearner,
      address addressAcademy,
      bytes32 subjectCourse,
      bytes32 nameCourse
    ) public returns (bool) {
        bool exists;
        uint length = certificates.length;
        for(uint k=0; k < length; k++) {
            if(certificates[k].course.academy._address == addressAcademy &&
              certificates[k].course.subject == subjectCourse &&
              certificates[k].course.name == nameCourse &&
              certificates[k].learner._address == addressLearner) {
                exists = true;
                break;
            }
        }
        if(!exists) {
            uint learnerCount = learners.length;
            uint coursesCount = courses.length;
            for(uint i=0; i < learnerCount; i++) {
                if(learners[i]._address == addressLearner) {
                    for(uint j=0; j < coursesCount; j++) {
                        if(courses[j].academy._address == addressAcademy && courses[j].subject == subjectCourse && courses[j].name == nameCourse) {
                            certificates.push(Certificate({
                                learner: learners[i],
                                course: courses[j]
                              }));
                              return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    // Add Course
    // @addressLearner - address of the learner
    // @addressAcademy - address of the academy
    // @subjectCourse - subject of the course
    // @nameCourse - name of the course
    function addCourse(
      address addressLearner,
      address addressAcademy,
      bytes32 subjectCourse,
      bytes32 nameCourse
    ) public returns (bool) {
        bool exists=false;
        uint length = LClinks.length;
        uint coursesCount = courses.length;
      for (uint i = 0; i < length; i++) {
          if(LClinks[i]._address == addressLearner
            && LClinks[i].course.subject == subjectCourse
            && LClinks[i].course.name == nameCourse
            && LClinks[i].course.academy._address == addressAcademy) {
            exists = true;
            break;
          }
      }
      if(!exists) {
          bytes32[] storage _skills;
          for (uint j = 0; j < coursesCount; j++) {
              if(courses[j].academy._address == addressAcademy
                && courses[j].subject == subjectCourse
                && courses[j].name == nameCourse) {
                    LClinks.push(LClink({
                        _address: addressLearner,
                        course: courses[j]
                    }));
                    return true;
              }
          }
      }
      return false;
    }


    // Get Courses of specific learner
    // @addressLearner - address of the learner
    function getCourses(
      address addressLearner
    ) public returns (address[], bytes32[], bytes32[], bytes32[]) {
        uint length = LClinks.length;
        address[] newAddress;
        bytes32[] newSubject;
        bytes32[] newName;
        bytes32[] newSkills;

        uint j=0;
        for(uint i=0; i < length; i++) {
            if(LClinks[i]._address == addressLearner) {
                newAddress[j] = LClinks[i].course.academy._address;
                newSubject[j] = LClinks[i].course.subject;
                newName[j] = LClinks[i].course.name;
                newSkills[j] = LClinks[i].course.skills[0];
                j++;
            }
        }

        return (newAddress, newSubject, newName, newSkills);
    }



    // BUSINESSES

    // Create business
    // @address - address of the business
    // @bytes32 - name of the business
    function createBusiness(
        address addressBusiness,
        bytes32 _name
    ) public returns (bool) {
        uint length = business.length;
        bool exist = false;
        for (uint i = 0; i < length; i++) {
            if(business[i]._address == addressBusiness) {
                exist=true;
                break;
            }
        }
        if(!exist) {
            business.push(Business({
                _address: addressBusiness,
                name: _name
            }));
            return true;
        }
      return false;
    }

    // Get business
    // @address - address of the business
    function getBusiness(
        address addressBusiness
    ) public returns (bytes32) {
        uint length = business.length;
        for (uint i = 0; i < length; i++) {
            if(business[i]._address == addressBusiness) {
                return business[i].name;
            }
        }
      return "";
    }

    // List businesses
    function listBusinesses() public returns (address[], bytes32[]) {
        uint length = business.length;
        address[] businessAddresses;
        bytes32[] businessName;
        uint iBusiness=0;
        for (uint i = 0; i < length; i++) {
            businessAddresses[iBusiness] = business[i]._address;
            businessName[iBusiness] = business[i].name;
            iBusiness++;
        }
      return (businessAddresses, businessName);
    }

    // Get learners by skills
    // @bytes32[] - filter of skills needed by a specific company
    // return:
    // @address[] - list with learner addresses with XXXXXX XXXXX for their names in regard of the privacy
    function getLearnersBySkills(bytes32[] _labels) public returns (address[]) {
        uint length = _labels.length;

        bytes32 courseSkills;
        address[] learnersAddresses;
        uint iLearn=0;
        for (uint i=0; i < length; i++) {
            courseSkills = _labels[i];
            uint LCcounter = LClinks.length;
            for (uint j=0; j < LCcounter; j++) {
                for (uint k=0; k < LClinks[j].course.skills.length; k++) {
                    if (_labels[i] == LClinks[j].course.skills[k]) {
                        learnersAddresses[iLearn] = LClinks[j]._address;
                        iLearn++;
                    }
                }
            }
        }
        return learnersAddresses;
    }

    // ACADEMY

    // Create academy
    // @address - address of a specific academia
    function createAcademy(address addressAcademy, bytes32 nameAcademy) public returns (bool) {
        uint length = academies.length;
        bool exists=false;
        for (uint i=0; i < length; i++) {
            if (academies[i]._address == addressAcademy) { exists=true; break; }
        }
        if(!exists) {
            academies.push(Academy({
                _address: addressAcademy,
                name: nameAcademy
            }));
            return true;
        }
        return false;
    }


    // Get own courses
    // @address - address of a specific academia
    function getOwnCourses(address addressAcademy) public returns (bytes32[], bytes32[]) {
        uint length = courses.length;
        bytes32[] newSubjectCourse;
        bytes32[] newNameCourse;
        uint j=0;
        for (uint i=0; i < length; i++) {
            if (courses[i].academy._address == addressAcademy) {
                newSubjectCourse[j] = courses[i].subject;
                newNameCourse[j] = courses[i].name;
                j++;
            }
        }
        return (newSubjectCourse, newNameCourse);
    }




}
