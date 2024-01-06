// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract MenuManagement {
    address public owner;
    string []public menuItems;
    mapping(string => uint) public itemsQuantity;   // Item name to quantity
    mapping(string => uint) public itemsPrice; // Item name to price
    mapping(string => bool) public itemAvailability; // Item availability status
    event LogMessage(string message);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function addItem(string memory itemName, uint quantity) public onlyOwner {
        menuItems.push(itemName);
        itemsQuantity[itemName] = quantity;
        itemAvailability[itemName] = true;
    }

    function updatePrice(string memory itemName, uint newPrice) public onlyOwner {
        require(itemAvailability[itemName], "Item does not exist");
        itemsPrice[itemName] = newPrice;
    }

    
    function checkPrice(string memory itemName) public view returns (uint){
         return itemsPrice[itemName]; 
    }

    function checkQuantity(string memory itemName) public view returns (uint) {
        return itemsQuantity[itemName];
    }

    function updateQuantity(string memory itemName, uint quantity) public onlyOwner {
        itemsQuantity[itemName]=quantity;
        emit LogMessage("Items quantity has been set successfully");
    }

    function checkAvailability(string memory itemName) public view returns (bool) {
        return itemAvailability[itemName];
    }

    function updateAvailability(string memory itemName, bool status) public onlyOwner {
        if (itemAvailability[itemName]==false && status==false)
            emit LogMessage("Item is already unavailable");
        else if (itemAvailability[itemName]==true && status==true)
            emit LogMessage("Item is already available");
        else if (itemAvailability[itemName]==false && status ==true)
        {
            itemAvailability[itemName]==true;
            emit LogMessage("Item has been made available successfully!");
            itemsQuantity[itemName]=1; //default quantity set for an item made available from unavailable
        }
        else if(itemAvailability[itemName]==true && status ==false)
        {
            itemAvailability[itemName]==false;
            emit LogMessage("Item has been made unavailable successfully!");
            itemsQuantity[itemName]=0;
        }

    }
}
