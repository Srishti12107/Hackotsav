// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EducationCredentials {
    struct Certificate {
        string studentName;
        string courseName;
        uint256 issueDate;
    }

    mapping(address => Certificate) public certificates;

    function issueCertificate(address student, string memory _studentName, string memory _courseName) public {
        certificates[student] = Certificate(_studentName, _courseName, block.timestamp);
    }

    function getCertificate(address student) public view returns (string memory, string memory, uint256) {
        Certificate memory cert = certificates[student];
        return (cert.studentName, cert.courseName, cert.issueDate);
    }
}