// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Escrow{

    address payer;
    address payable payee;
    address lawyer;
    uint amount;

    bool paused;
    bool workdone;

    constructor(address _payer, address payable _payee, uint _amount){
        payer = _payer;
        payee = _payee;
        amount = _amount;
        lawyer = msg.sender;
        workdone = false;
    }

    // after checking if work is done
    function appeal() public {
        paused = true;
    }

    function deposit() external payable{
        require(msg.sender == payer, "Only Payer can pay");
        require(address(this).balance == amount, "Amount should be equal to escrow amount");
    }

    function workDone() public {
        require(msg.sender == payee, "Only payee can mark the job completed");
        workdone = true;
    }

    function releaseFund() public payable{
        require(msg.sender == lawyer, "Only Lawyer can release Fund");
        require(workdone == true, "Job is not done");
        require(paused == false, "Cntract is on halt");
        require(address(this).balance == amount, "Insufficient Balance");
        payee.transfer(amount);
    }

    function balanceOf() view public returns(uint){
        return address(this).balance;
    }
}