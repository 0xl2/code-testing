// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Election {
    // Model of Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Provide a key-value relationship between an unsigned int to “Candidate”
    mapping(uint => Candidate) public candidates;
}
