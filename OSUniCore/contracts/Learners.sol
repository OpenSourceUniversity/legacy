pragma solidity ^0.4.15;

// Learners

contract Learners {

    Learner[] learner;

    struct Learner {
        bytes32 firstName;
        bytes32 lastName;
        uint age;
        Academia academia;
        /*mapping ( bytes256 => bytes32[]) academicTraction;*/
    }

    struct Academia {
        bytes32 name;
        uint8 rate;
        Courses courses;
    }

    struct Courses {
        bytes32 name;
        uint8 rate;
        uint256 progress_in_percents;
    }


    function addLearner(
         bytes32 _firstName,
         bytes32 _lastName,
         uint _age) returns (bool success) {
        Learner memory newLearner;
        newLearner.firstName = _firstName;
        newLearner.lastName = _lastName;
        newLearner.age = _age;

        learner.push(newLearner);
        return true;
    }

    function getLearner() constant returns (bytes32[],bytes32[],uint[]) {
        uint length = learner.length;

        bytes32[] memory firstNames = new bytes32[](length);
        bytes32[] memory lastNames = new bytes32[](length);
        uint[] memory ages = new uint[](length);

        for (uint i = 0; i < learner.length; i++) {
            Learner memory currentLearner;
            currentLearner = learner[i];

            firstNames[i] = currentLearner.firstName;
            lastNames[i] = currentLearner.lastName;
            ages[i] = currentLearner.age;
        }

        return (firstNames,lastNames,ages);
    }


    /*function updateCourseStatus() public returns (bytes32[],bytes32[],uint[]) {


        return (firstNames,lastNames,ages);
    }*/

}
