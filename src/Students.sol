// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Students {

    struct StudentsStruct {
        uint256 id;
        string name;
        uint256 age;
    }

    mapping(uint256 => StudentsStruct) public students;
    
    constructor(uint256 _id, StudentsStruct memory _students) {
        // students.push(_students);
       students[_id] = _students;
    }

    function getStudent(uint256 _id) public view returns (StudentsStruct memory) {
        return students[_id];
    }

    function setStudent(uint256 _id, StudentsStruct memory _student) public {
        students[_id] = _student;

    }

}