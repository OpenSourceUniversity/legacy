pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Academia.sol";
import "../contracts/Authority.sol";

contract TestAuthority {

  function testAuthorizeAcademia() {
    Academia academia = Academia(DeployedAddresses.Academia());
    Authority authority = Authority(DeployedAddresses.Authority());

    Assert.isTrue(authority.authorize(academia.owner()), 'Authorization not successful');
    Assert.equal(
        int(academia.authorizations(0)),
        int(Academia.AuthorizationType.Government),
        'Wrong academia authorization type.');
    Assert.notEqual(
        int(academia.authorizations(0)),
        int(Academia.AuthorizationType.Private),
        'Wrong academia authorization type.');
  }

}
