//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./nft.sol";
import "./premium.sol";

contract carPolicy{

    address payable owner;
    uint256 number_of_kyc;
    uint256 number_policyholders;
    uint256 policy_number;

    address[] public policyholders; 
    mapping(address => car[]) public holder_policies;
    struct car {
        string vehicle;
        string model;
        string brand;
        string plate;
        uint256 year;
        uint256 policy_number;
        uint256 buy_date;
        uint256 expire_date;
    }

    address[] public kycholders;
    mapping(address => kyc) public holder_kyc;
    struct kyc {
        string name;
        string gender;
        string work;
        string civil_state;
        uint256 age;
        uint256 number_kids;
        uint256 nif;
        uint256 vat;
        uint256 social_security;
        uint256 healt_user_number;
    }

    address[] public claimholders;
    mapping(address => policy[]) public holder_claims;
    struct policy {
        uint256 _policy_number;
        uint256 amount;
    }

    mapping(address => score) public final_score;
    struct score {
        uint256 driver_score;
        uint256 price;
    }

    constructor() {
        owner = payable(msg.sender);
        number_of_kyc=0;
        number_policyholders=0;
        policy_number=0;
    }

    function do_Kyc(string memory _name, uint256 _age, string memory _gender,string memory _work, string memory _civil_state, uint256 _number_kids,uint256 _nif, uint256 _vat, uint256 _social_security, uint256 _healt_user_number) public {
        require(_age>=18, "You don't have the legal age to the an insurance");
        holder_kyc[msg.sender] = kyc(_name, _gender, _work, _civil_state,_age, _number_kids, _nif, _vat, _social_security, _healt_user_number);
        kycholders.push(msg.sender);
        number_of_kyc++;
    }

    function buyPolicy(string memory _vehicle,string memory  _model, string memory _brand, string memory _plate, uint256 _year) public payable{
        require(final_score[msg.sender].price!=0, "Your policie price must be greater than 0");

        uint256 j=0;

        for(uint256 i=0; i<number_of_kyc; i++){
            if(kycholders[i]==msg.sender){
               j++;
            }
        }

        require(j==1, "You don't have a valid KYC");

        require(msg.value == final_score[msg.sender].price , "Wrong premium value");

        policy_number++;
        holder_policies[msg.sender].push(car(_vehicle,_model,_brand, _plate, _year, policy_number, block.timestamp, block.timestamp + 365 days));
        policyholders.push(msg.sender);
        new Insurance().safeMint(msg.sender, policy_number+1, "https://ipfs:QmWZJ4Gh5sJeRGVWMLC5JtVtMopiVKNBxP7xeUCUgXMsRf");
        number_policyholders++;     
    }

    function fileClaim(uint256 _policy_number, uint256 _amount) public {
        uint256 j=0;

        for(uint256 i=0; i<number_of_kyc; i++){
            if(holder_policies[msg.sender][i].policy_number==_policy_number){
               j++;
            }
        }

        require(j==1, "You don't have a valid policy with this number");

        require(_amount > 0, "Claim amount must be greater than 0");

        _amount = _amount*1000000000000000000;
        
        holder_claims[msg.sender].push(policy(policy_number, _amount ));
        claimholders.push(msg.sender);
    }

    function searchClaim(address claimer, uint256 _policy_number) public view returns (uint256){
        require(msg.sender==owner, "Only the owner can see the existent claims");

        uint256 j=0;

        for(uint256 i=0; i<holder_policies[claimer].length; i++){
            if(holder_policies[claimer][i].policy_number==_policy_number){
                j=i;
            }
        }
        
        return j;
    }

    function approveClaim(address _policyholders, uint256 _policy_number) public payable{
        require(msg.sender == owner, "Only the  Insurance Company can Aprove or Deny a claim");
        
        uint256 j=0;
        uint256 z=0;
        uint256 g=0;

        for(uint256 i=0; i<number_of_kyc; i++){
            if(claimholders[i]==_policyholders){
               j++;
            }
        }

        require(j==1, "This address don't have a filed any claim");

        for(uint256 k=0; k<policy_number; k++){
            if(holder_policies[_policyholders][k].policy_number==_policy_number){
                z++;
                g=k;
            }
        }

        require(z==1, "This address don't have a policy with this number");


        payable(_policyholders).transfer(holder_claims[_policyholders][g].amount);

        delete(holder_claims[_policyholders][g]);
    }

    function rejectClaim(address _policyholders, string memory reason, uint256 _policy_number) public {
        require(msg.sender == owner, "Only the  Insurance Company can Aprove or Deny a claim");
        
        uint256 j=0;
        uint256 z=0;
        uint256 g=0;

        for(uint256 i=0; i<number_of_kyc; i++){
            if(claimholders[i]==_policyholders){
               j++;
            }
        }

        require(j==1, "This addres don't have a valid claim");

        for(uint256 k=0; k<policy_number; k++){
            if(holder_policies[_policyholders][k].policy_number==_policy_number){
                z++;
                g=k;
            }
        }

        require(z==1, "This address don't have a policy with this number");
        
        delete(holder_claims[_policyholders][g]);
        console.log(reason);
    }

    function withdraw() public payable {
        require(msg.sender==owner, "Only the owner can withdraw money from the contract");
        require(address(this).balance > 0, "Balance is 0");
        payable(owner).transfer(address(this).balance);
    }

    function premium_Price (uint256 speed_traffic_highway, uint256 speed_traffic_village, uint256 headways_between_vehicles, uint256 acceleration, uint256 deceleration, uint256 overtaking_lane_changing , uint256 traffic_regulations) public {
        (uint256 x, uint256 y) = new Premium().premium_Price(speed_traffic_highway, speed_traffic_village, headways_between_vehicles, acceleration, deceleration, overtaking_lane_changing , traffic_regulations);
        final_score[msg.sender].price = x;
        final_score[msg.sender].driver_score = y;
    }  

}