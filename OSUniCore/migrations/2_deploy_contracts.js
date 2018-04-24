var Academia = artifacts.require("./Academia.sol");
var Authority = artifacts.require("./Authority.sol");

module.exports = function(deployer) {
    deployer.deploy(Academia);
    deployer.deploy(Authority);
};
