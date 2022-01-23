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
import "./IRNC.sol";
import "./ChainLinkVRFConsumer/MumbaiVRFConsumer.sol";
import "./ChainLinkPriceConsumer/MumbaiPriceConsumer.sol";

contract RNC is IRNC, MumbaiVRFConsumer, MumbaiPriceConsumer, Ownable {
    
    function version() public pure returns(string memory) {
        return "1";
    }
    
    mapping (bytes32 => Applicant) public applicants;

    struct Applicant{
        address contractAddress;
        bytes4 callBackSelector;
        uint256 randomResult;
    }

    /**
     * @dev See {IRNC-applicantFee}.
     */
    function applicantFee() public view returns(uint256 fee) {
        return uint256(linkPrice() / 1000);
    }


    /**
     * @dev See {IRNC-getRandomNumber}.
     */
    function getRandomNumber(bytes4 _callBackSelector) public payable returns(bytes32 requestId){
        require(LINK.balanceOf(address(this)) >= linkFee, "Not enough LINK");
        require(msg.value >= applicantFee() / 2, "Not enough MATIC");
        requestId = requestRandomness(keyHash, linkFee);
        applicants[requestId] = Applicant(msg.sender, _callBackSelector, 0);
        emit Request(requestId);
        return requestId;
    }

    /**
     * @dev Callback function used by VRF Coordinator
     *
     * fulfill applicant last info (randomness)
     * response to the applicant request
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        applicants[requestId].randomResult = randomness;
        Applicant memory app = applicants[requestId];
        _response(
            app.contractAddress,
            app.callBackSelector,
            app.randomResult
        );
    }

    /**
     * @dev Response function to the applicant contract.
     *
     * Requirements:
     *
     * - call back should be successful.
     * 
     * Emits a {Response} event.
     */
    function _response(address contractAddress, bytes4 selector, uint256 randomResult) private {
        (bool success, bytes memory data) = contractAddress.call(abi.encodeWithSelector(selector, randomResult));
        require(success, "Could Not Response Randomness");
        emit Response(data);
    }
    
    
    

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