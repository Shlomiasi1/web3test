// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract bank {
    uint public Number_Of_Funders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;
    mapping(address => uint) private lastAmoutOfFunder;

    //this function add funder without duplicate
    function Addfund() public payable{
        address funder=msg.sender;
        if(!funders[funder]){
            unit index=Number_Of_Funders++;
            funders[funder]=true;
            lutFunders[index]=funder;
        }
        
    }

    // this function in the constructor of the bank
    constructor(){
        owner = msg.sender;
    }

     //this function get all funders without duplicate   
    function getAllFunders() external view returns(address[] memory){
      address[] memory _Funder = new address[](Number_Of_Funders)  
      for(uint i=0; i<Number_Of_Funders; i++){
        _Funder[i] =lutFunders[i];
      }
    }

    function getLastAmoutForFunders() external view returns(address[] memory){
        address[] memory Last_Sum = new address[](Number_Of_Funders)  
        for(uint i=0; i<Number_Of_Funders; i++){
            Last_Sum[lutFunders[i]] =msg.value;
        }
      }

    //this function help you to withdrw money
    function withdraw(uint withdrawAmout) external{
        require(withdrawAmout < 1000000000000000000 | msg.sender == owner ,"You cant do it");
        payable (msg.sender).transfer(withdrawAmout);
    }

    //this modifier function Initializes the settings of another function
    modifier onlyOwner(){
        require(msg.sender == owner , "only owner can do it");
    }

    //this function allow to Only the owner to transfer ownership
    function transferOwnrship(address newOwner) external onlyOwner{
        owner = newOwner;
    }


}

// const instance = await bank.deployed()
// instance.addFuns({value:"500000000000000000",from: accounts[0] })
// instance.addFuns({value:"500000000000000000",from: accounts[1] })
// const funds = instance.funds()
// instance.sumAccount({value:"500000000000000000",from: accounts[0] })
// instance.sumAccount({value:"500000000000000000",from: accounts[1] })
// const funds = instance.funds()