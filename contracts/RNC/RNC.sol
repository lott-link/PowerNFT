// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// ============================ VERSION_1.1.0 ==============================
//   ██       ██████  ████████ ████████    ██      ██ ███    ██ ██   ██
//   ██      ██    ██    ██       ██       ██      ██ ████   ██ ██  ██
//   ██      ██    ██    ██       ██       ██      ██ ██ ██  ██ █████
//   ██      ██    ██    ██       ██       ██      ██ ██  ██ ██ ██  ██
//   ███████  ██████     ██       ██    ██ ███████ ██ ██   ████ ██   ██    
// ======================================================================
//  ================ Open source smart contract on EVM =================
//   ============== Verify Random Function by ChainLink ===============

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./utils/VRFConsumer.sol";
import "./utils/PriceConsumer.sol";
import "./utils/Swapper.sol";

contract RNC is VRFConsumer, PriceConsumer, Swapper, Ownable {

    mapping(bytes32 => uint256) randomResults;

    /**
     * @dev See {IRNC-applicantFee}.
     */
    function applicantFee() public view returns(uint256 fee) {
        return uint256(linkPrice() / 1000);
    }


    /**
     * @dev See {IRNC-getRandomNumber}.
     */
    function getRandomNumber() internal returns(bytes32 requestId){
        require(LINK.balanceOf(address(this)) >= linkFee, "Not enough LINK");
        requestId = requestRandomness(keyHash, linkFee);
        return requestId;
    }

    /**
     * @dev Callback function used by VRF Coordinator
     *
     * fulfill applicant last info (randomness)
     * select to the applicant request
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResults[requestId] = randomness;
        _select(randomness);
    }

    /**
     * @dev select function to the applicant contract.
     *
     * Requirements:
     *
     * - call back should be successful.
     * 
     * Emits a {select} event.
     */
    function _select(uint256 randomResult) internal virtual{}
    
    
    /**
     * @dev Returns LINK supply of the contract
     */
    function linkSupply() public view returns(uint256){
        return LINK.balanceOf(address(this));
    }
    /**
     * @dev Withdraw LINK function to avoid locking LINK in the contract
     * (not needed in release version)
     */
    function withdrawLink(uint256 amount) external onlyOwner {
        address reciever = owner();
        LINK.transfer(reciever, amount);
    }
    


    /**
     * @dev Returns MATIC supply of the contract
     */
    function maticSupply() public view returns(uint256){
        return address(this).balance;
    }
    /**
     * @dev Withdraw MATIC paid by applicants
     *
     * Requirements:
     *
     * - only owner can call this function.
     */
    function withdrawMatic() external onlyOwner {
        address payable reciever = payable(owner());
        reciever.transfer(maticSupply());
    }
}