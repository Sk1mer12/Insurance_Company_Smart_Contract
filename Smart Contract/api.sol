//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract GetAPI is ChainlinkClient {
    using Chainlink for Chainlink.Request;
  
    uint256 public af;
    uint256 public bf;
    uint256 public cf;
    uint256 public df;
    uint256 public ef;
    uint256 public ff;
    uint256 public gf;
    
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
        jobId = "29fa9aa13bf1468788b7cc4a500a45b8";
        fee = 0.1 * 10 ** 18; // (Varies by network and job)
    }
    
    function requestVolumeData() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        
        request.add("get", "https://reqres.in/api/products/3");
      
        request.add("path", "data.id");
        
        int timesAmount = 1;
        request.addInt("times", timesAmount);
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    

    function fulfill(bytes32 _requestId, uint256 _af, uint256 _bf, uint256 _cf, uint256 _df, uint256 _ef, uint256 _ff, uint256 _gf) public recordChainlinkFulfillment(_requestId)
    {
        af = _af;
        bf = _bf;
        cf = _cf;
        df = _df;
        ef = _ef;
        ff = _ff;
        gf = _gf;
    }
 
}