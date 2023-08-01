//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol"; 

contract Premium {

    mapping(address => score) public final_score;
    struct score {
        uint256 driver_score;
        uint256 price;
    }

    function premium_Price (uint256 speed_traffic_highway, uint256 speed_traffic_village, uint256 headways_between_vehicles, uint256 acceleration, uint256 deceleration, uint256 overtaking_lane_changing , uint256 traffic_regulations) public returns (uint256, uint256){
        
        if(final_score[msg.sender].driver_score==0){
            final_score[msg.sender].driver_score=50;
        }

        if(final_score[msg.sender].driver_score>=1){
            if(60<=speed_traffic_highway || speed_traffic_highway>=120){
                final_score[msg.sender].driver_score--;
            }

            if(20<=speed_traffic_village || speed_traffic_village>=40){
                final_score[msg.sender].driver_score--;
            }

            if(headways_between_vehicles<3){
                final_score[msg.sender].driver_score--;
            }

            if(acceleration>6){
                final_score[msg.sender].driver_score--;
            }

            if(deceleration<5){
                final_score[msg.sender].driver_score--;
            }

            if(overtaking_lane_changing>10){
                final_score[msg.sender].driver_score--;
            }

            if(traffic_regulations!=0){
                final_score[msg.sender].driver_score = final_score[msg.sender].driver_score - traffic_regulations;
            }
        }

        if(final_score[msg.sender].driver_score<=100){
            if(60>=speed_traffic_highway || speed_traffic_highway<=120){
                final_score[msg.sender].driver_score++;
            }

            if(20>=speed_traffic_village || speed_traffic_village<=40){
                final_score[msg.sender].driver_score++;
            }

            if(headways_between_vehicles>=3){
                final_score[msg.sender].driver_score++;
            }

            if(acceleration>=6){
                final_score[msg.sender].driver_score++;
            }

            if(deceleration>=5){
                final_score[msg.sender].driver_score++;
            }

            if(overtaking_lane_changing<=10){
                final_score[msg.sender].driver_score++;
            }

            if(traffic_regulations==0){
                final_score[msg.sender].driver_score++;
            }
        }

        if(final_score[msg.sender].driver_score>0 && final_score[msg.sender].driver_score<=30){
            final_score[msg.sender].price = 4 ether;
        }

        if(final_score[msg.sender].driver_score>30 && final_score[msg.sender].driver_score<=50){
            final_score[msg.sender].price = 3 ether;
        }
        
        if(final_score[msg.sender].driver_score>50 && final_score[msg.sender].driver_score<70){
            final_score[msg.sender].price = 2 ether;
        }

        if(final_score[msg.sender].driver_score>70 && final_score[msg.sender].driver_score<=100){
            final_score[msg.sender].price = 1 ether;
        }

        console.log(final_score[msg.sender].price/1000000000000000000);
        console.log(final_score[msg.sender].driver_score);

        return (final_score[msg.sender].price, final_score[msg.sender].driver_score);
    }   
}
 
 