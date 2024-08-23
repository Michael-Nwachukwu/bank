// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// state var - saved to the blockchain (public)
// local var - variables declared in a function and native to that function
// constant var - code isnt stored in the blockchain rather in the bytecode. you cannot change the constant. Namw conventions fo r constant vars startts with capital letters. Put values you know will never be changed in the contract (fixed)


contract Class {
    // constant vars
    uint constant NUM = 10;

    function storeAge() public pure returns (uint) {
        // local variables
        uint myAge = 8;
        return myAge;
    }

    // Value types
    // booleans
    // integers
    // addresses

    // Value types - can create a copy of a variable, update that copied value and the original variable will retain its original value
    // reference tye - create a copy of a reference vvar that references a slot storage in the memory and when you update the copied var it updates the original value stored in the memory


    // Boolean has a default value of false

    // For all the state variables the default visibility is internal

    // 1 byte = 8 bits
    // 256 bits = 32 bytes

    // Variable packing
    // miniimizing vars example integers in a slot 

    // default value of an address is 00000-> into 20bytes

    // state vars store data in storage and is on blockchain
    // memory is temporary and is available for the lifespan of the function
}

