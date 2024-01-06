// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "../interfaces/IERC20.sol";
import "./RewardsAndLoyalty.sol";

contract FastCoin is iERC20{
    
    uint numTokens;
    mapping(address=>uint) balance;
    mapping (address=>mapping(address=>uint)) approvalLimit;
    address public ownerToken;
    RewardsAndLoyalty loyalty;

    constructor(uint _numTokens,address _loyalty) {
        ownerToken=msg.sender;
        numTokens=_numTokens;
        balance[msg.sender]=numTokens;
        loyalty= RewardsAndLoyalty(_loyalty);

    }

    modifier onlyOwner(){
        require(msg.sender==ownerToken);
        _;
    }

    function totalSupply() external view returns (uint256){
        return numTokens;
    }

    function balanceOf(address account) external view returns (uint256){
        return balance[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool){
        require (balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return approvalLimit[owner][spender];
    }

    function approve(address spender, uint256 value) external returns (bool){
        require(balance[msg.sender]>=value);
        approvalLimit[msg.sender][spender]=value;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        require(amount<balance[sender]);
        require(amount<approvalLimit[sender][msg.sender]);
        balance[sender]-=amount;
        balance[recipient]+=amount;
        approvalLimit[sender][msg.sender]-=amount;
        return true;
    }

    function getTokens(uint amount) external payable {
        require(msg.value>(amount)*1 ether);
        numTokens-=amount*10;
        balance[msg.sender]+=amount*10;
    }

    function processPayment(uint price,address buyer)internal onlyOwner returns (bool){
        uint reward=0;
        require(balance[buyer]>=price);
        balance[buyer]-=price;
        reward=loyalty.getReward(price);
        numTokens+=reward;
        this.transfer(buyer,reward);
        return true;
    }
    
}