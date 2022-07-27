// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
// import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
// import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract SimpleContract is Ownable {
    uint private immutable UniqueNumber;
    uint private AccountNumber;
    uint private AvailableAmount;

    mapping(address => mapping(DataType => bool)) public UserPermission;
    enum DataType {
        UniqueNumber,
        AccountNumber,
        AvailableAmount
    }

    event ValueChanged(uint va1, uint val2);

    constructor() {
        UniqueNumber = uint256(
            keccak256(
                abi.encode(block.difficulty, block.timestamp)
            )
        );
    }

    /**
     * @notice Set accountNuber and availableNumber, only owner can call
     * @param _accountNum  Account Number
     * @param _availableNum  Available number
     */
    function setInfo(uint _accountNum, uint _availableNum) external onlyOwner {
        require(_accountNum != AccountNumber, "Err msg");

        AccountNumber = _accountNum;
        AvailableAmount= _availableNum;

        emit ValueChanged(AccountNumber, AvailableAmount);
    }

    /**
     * @notice Set permit to address, only owner can call
     * @param _user  User address
     * @param _type  data type
     * @param _flag  show or not
     */
    function setPermit(address _user, DataType _type, bool _flag) external onlyOwner {
        UserPermission[_user][_type] = _flag;
    }

    /**
     * @notice read data
     * @param _type  data type
     */
    function getInfo(DataType _type) view external returns(uint _value) {
        require(UserPermission[msg.sender][_type], "Not allowed");

        _value = _type == DataType.UniqueNumber ? UniqueNumber :
                _type == DataType.AccountNumber ? AccountNumber : AvailableAmount;
    }
}