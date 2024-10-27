// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "../src/ChallengeTwo.sol";
import {Test, console2} from "forge-std/Test.sol";

// SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/AXZTpQuCryhmuSxFjmGQ5QNpExmCcLhq

contract ChallengeTwoTest is Test {
    ChallengeTwo chal;
    address owner = makeAddr('owner');
    address user = makeAddr('user');
    function setUp() public {
        vm.createSelectFork("https://eth-sepolia.g.alchemy.com/v2/AXZTpQuCryhmuSxFjmGQ5QNpExmCcLhq");
        vm.startPrank(owner);
        chal =  new ChallengeTwo();
        vm.stopPrank();
    }
    function test_passKey_and_getInvalidKey() public {
        vm.prank(owner);
        vm.expectRevert();
        chal.passKey(1);  
              
    }

    function test_passKey_with_validKey() public {

        chal.passKey(2524);        
        bool solved = chal.hasSolved1(tx.origin);
        assertTrue(solved);

    }

    function test_getEnoughPoint_requireHasSolved1() public {
        vm.prank(owner);
        // chal.passKey(2524);
        vm.expectRevert("go back and complete level 1");
        chal.getENoughPoint("favour");
    }

    function test_getEnoughPoint() public {
        chal.passKey(2524);
        chal.getENoughPoint("favour");
        
        console2.log("chal.userPoint(tx.origin)", chal.userPoint(tx.origin));
        assertEq(chal.userPoint(tx.origin), 4);
    }

    function test_getEnoughPoint_hasSolved2() public {
        chal.passKey(2524);
        chal.getENoughPoint("favour");
        vm.expectRevert("already solved");
        chal.getENoughPoint("favour");
    }

    function test_getEnoughPoint_addYourName() public {
        chal.passKey(2524);
        chal.getENoughPoint("favour");
        assertEq(chal.Names(tx.origin), "favour");
    }

    function test_addYourName() public {
        chal.passKey(2524);
        chal.getENoughPoint("favour");
        chal.addYourName();
        string[] memory winners = chal.getAllwiners();
        assertEq(winners.length, 1);
        assertEq(winners[0], "favour");
    }

    function test_addYourName_required() public {
        chal.passKey(2524);
        chal.getENoughPoint("favour");
        chal.addYourName();

        vm.expectRevert("you have completed already");
        chal.addYourName();
    }




fallback() external {
        if(address(chal).balance >= 0) {
            // Re-enter until we get enough points
            try chal.getENoughPoint("favour") {} catch {}
        }
    }





    // function test_pause_only_owner_can_pause() public {
    //     vm.prank(owner);
    //     chal.pause(true);
    //     assertTrue(chal.isPause());

    //     vm.prank(user);
    //     vm.expectRevert();
    //     chal.pause(false);
    // }
    // function test_exploitMe_when_Paused_reverts() public {
    //     test_pause_only_owner_can_pause();
    //     vm.prank(user);
    //     vm.expectRevert();
    //     chal.exploit_me("user");
    // }

    // function testFail_exploitMe_when_Paused() public {
    //     test_pause_only_owner_can_pause();
    //     vm.prank(user);
    //     chal.exploit_me("user");
    // }

    // function test_user_cant_exploit_when_not_locked() public {
    //     vm.prank(user);
    //     vm.expectRevert();
    //     chal.exploit_me("user");
    // }

    // function test_can_reenter_and_set_lock() public {
    //     // vm.expectRevert();
    //     chal.exploit_me("user");
    //     assertEq(chal.HasInteracted(address(this)), true);
    //     assertEq(chal.winners(0), msg.sender);
    //     assertEq(chal.Names(msg.sender), "user");
    // }

    // function test_can_not_interact_twice() public {
    //     test_can_reenter_and_set_lock();
    //     vm.expectRevert("This address has interacted before");
    //     chal.exploit_me("user");
    // }

    // function test_getAllWinners() public{
    //    test_can_reenter_and_set_lock();
    //    string[] memory _names2 = chal.getAllwiners();
    //    assertEq(_names2[0], "user");
    // }

    // function test_getAllWinners_onChain() public view{
    //    string[] memory _names = chal.getAllwiners();
    //    for(uint i; i < _names.length; i++){
    //        console2.log("winner", i + 1, _names[i]);
    //    }
        
    // }




    // uint count;
    // receive() external payable {
       
    //          chal.lock_me();
    //         console2.log("locked");

    // }


}