var c4 =artifacts.require("OrderProcessing");
var c1=artifacts.require("MenuManagement");
var c2=artifacts.require("PromotionsAndDiscounts");

module.exports= function (deployer) {
    return deployer.deploy(c1).then(()=>{
        return deployer.deploy(c2).then(()=>{
            return deployer.deploy(c4,c1.address, c2.address);
        });
    });
}