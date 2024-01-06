var c5=artifacts.require("FastCoin");
var c3=artifacts.require("RewardsAndLoyalty");

module.exports= function (deployer) {
    let tokens=BigInt(100000)
    return deployer.deploy(c3).then(()=>{
        return deployer.deploy(c5,tokens,c3.address);
    });
}