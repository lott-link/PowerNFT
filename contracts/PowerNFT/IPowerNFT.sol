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

    function setChance(uint256 _chance) external;

    function setPower(uint256 _power) external;

    function setCommission(address addr, uint256 value) external;

    function buyCard(string memory uri, string memory refferal, uint256 dappId) external payable;

    function burnAndWithdraw(uint256 tokenId) external;
}