// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import "./MenuManagement.sol";
import "./PromotionsAndDiscounts.sol";

contract OrderProcessing {
    MenuManagement public menu;
    PromotionsAndDiscounts public discount;
    string []public items;
    mapping (string=>uint) quantity;
    uint price;


    constructor(address _menu, address _discount) {
        menu = MenuManagement(_menu);
        discount=PromotionsAndDiscounts(_discount);
    }

    function selectItems(string memory itemName, uint q) external {
        require(menu.checkAvailability(itemName),"Item not available");
        require(menu.checkQuantity(itemName)>q, "Desired quantity is not available");
        items.push(itemName);
        quantity[itemName]=q;
    }

    function placeOrder() external returns (uint) {
        price=0;
        for(uint i=0;i<items.length;i++)
        {
            price+=menu.checkPrice(items[i])*quantity[items[i]];
        }
        price=discount.calculateDiscountedPrice(price);
        return price;
    }
}
 