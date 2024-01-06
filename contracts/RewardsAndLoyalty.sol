// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract RewardsAndLoyalty{
    uint rewards;
    
    constructor(){
        rewards=0;
    }

    function getReward(uint price)public returns (uint x){
        if(price>=500)
        {
            rewards+=1;
            return x=10;
        }
        else if(price>=1000)
        {
            rewards+=1;
            return x=20;
        }
        else if(price>=1500)
        {
            rewards+=1;
            return x=30;      
        }
    }

    function getRewardsGiven() external view returns (uint){
        return rewards;
    }
}