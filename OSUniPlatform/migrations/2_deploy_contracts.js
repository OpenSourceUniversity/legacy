// var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var OSUniCoreContract = artifacts.require("./OSUniCoreContract.sol");

module.exports = function(deployer) {
  deployer.deploy(OSUniCoreContract);
};
