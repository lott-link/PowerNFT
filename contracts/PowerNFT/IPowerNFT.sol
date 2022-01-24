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



interface IPowerNFT {
    
    function totalValueLocked() external view returns(uint256);

    function totalSupply() external view returns(uint256);

    function lastRandom() external view returns(uint256);

    function NFTValue(uint256 tokenId) external view returns(uint256);

    function NFTBalance(uint256 tokenId) external view returns(uint256);

    function setRoundTime(uint256 _roundTime) external;

    function setChancePercent(uint256 _chancePercent) external;

    function setPower(uint256 _power) external;

    function setCommissionPercent(uint256 _commissionPercent) external;

    function buyCard(string memory uri, address refferal, uint256 dappId) external payable;

    function burnAndWithdraw(uint256 tokenId) external;
}