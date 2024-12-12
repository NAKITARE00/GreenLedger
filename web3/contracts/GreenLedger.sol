// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract GreenLedger {

    struct Seller{
        address sellerAddress;
        uint256 id;
        string name;
        string email;
        uint256 rating;
    }

    mapping (address => Seller) public sellers;
    uint256 sellerCount;

    struct DataItem {
        address sellerAddress;
        uint256 id;
        string name;
        string description;
        string fileHash;
        uint256 price;
    }

    mapping (uint256 => DataItem) public dataItems;
    uint256 dataItemCount;
    //Create Seller
    
    function createSeller (string memory _name, string memory _email) public {
        require(sellers[msg.sender].sellerAddress == address(0), "Seller Exists");
        sellerCount++;

        Seller storage seller = sellers[msg.sender];
        seller.sellerAddress = msg.sender;
        seller.id = sellerCount;
        seller.name = _name;
        seller.email = _email;
        seller.rating = 0;      
    }

    function createDataItem(string memory _name, string memory _description, string memory _fileHash, uint256 _price) public {
       require(sellers[msg.sender].sellerAddress != address(0), "Seller Does Not Exist");
       dataItemCount++;

       DataItem storage dataItem = dataItems[dataItemCount];
       dataItem.sellerAddress = msg.sender;
       dataItem.id = dataItemCount;
       dataItem.name = _name;
       dataItem.description = _description; 
       dataItem.fileHash = _fileHash;
       dataItem.price = _price;
    }

    function getDataItems() public view returns (DataItem[] memory) {
        DataItem[] memory allDataItems = new DataItem[](dataItemCount);
        for (uint256 i = 0; i < dataItemCount; i++) {
            allDataItems[i] = dataItems [i + 1];
        }
        return allDataItems;
    }

}