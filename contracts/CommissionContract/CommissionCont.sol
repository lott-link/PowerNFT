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
import "./ICommissionCont.sol";

contract CommissionContract is ICommissionCont, Ownable {

    function version() public pure returns(string memory) {
        return "1";
    }

    constructor() {
        setPercent(35, 45);
    }

    uint256 dappPercent;
    uint256 refferalPercent;
    function setPercent(uint256 _dappPercent, uint256 _refferalPercent) public onlyOwner {
        require(_dappPercent + _refferalPercent <= 100, "percentage overload");
        dappPercent = _dappPercent;
        _refferalPercent = _refferalPercent;
    }

    mapping(uint256 => address payable) dappIdToAddr;
    function setDapp(uint256 _dappId, address _dappAddr) public onlyOwner {
        dappIdToAddr[_dappId] = payable(_dappAddr);
    }

    function payCommission(address refferal, uint256 dappId) public payable {
        payable(refferal).transfer(msg.value * refferalPercent / 100);
        dappIdToAddr[dappId].transfer(msg.value * dappPercent / 100);
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