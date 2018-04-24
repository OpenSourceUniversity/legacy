pragma solidity ^0.4.15;


contract Academia {
    address public owner;
    bytes32 name;
    enum AuthorizationType { Government, Private }
    mapping (address => AuthorizationType) public authorizations;

    function Academia() {
        owner = msg.sender;
    }

    function authorize(
        AuthorizationType authorizationType
    ) returns (bool success) {
        authorizations[msg.sender] = authorizationType;
        return true;
    }
}
