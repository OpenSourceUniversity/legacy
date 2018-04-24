pragma solidity ^0.4.15;
import './Academia.sol';


contract Authority {
    bytes32 name;
    address public owner;

    function Authority() {
        owner = msg.sender;
    }

    function authorize(address academiaAddress) returns (bool) {
      return true;
        /*Academia academia = Academia(academiaAddress);
        return academia.authorize(Academia.AuthorizationType.Government);*/
    }
}
