// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract PromotionsAndDiscounts{
    uint discount10;
    uint discount20;
    uint discount30;

    constructor(){
        discount10=500;
        discount20=1000;
        discount30=1500;
    }

    function calculateDiscountedPrice(uint price) external view returns (uint){
        if(price>=discount10)
        {
            price-=(price*10)/100;
        }
        if(price>=discount20)
        {
            price-=(price*20)/100;
        }
        if(price>=discount30)
        {
            price-=(price*30)/100;
        }

        return price;

    } 
}