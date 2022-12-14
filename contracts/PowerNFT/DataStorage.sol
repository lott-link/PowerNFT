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



abstract contract DataStorage {

    address commissionAddr;
    function _setcommissionCont(address comAddr) internal {
        commissionAddr = comAddr;
    }

///////// set by the owner ////////

    uint256 roundTime;
    function _setRoundTime(uint256 _roundTime) internal {
        roundTime = _roundTime;
    }

    uint256 chancePercent;
    function _setChancePercent(uint256 _chancePercent) internal {
        chancePercent = _chancePercent;
    }

    uint256 power;
    function _setPower(uint256 _power) internal {
        power = _power;
    }

    uint256 commissionPercent;
    function _setCommissionPercent(uint256 _commissionPercent) internal {
        commissionPercent = _commissionPercent;
    }



///////// set in the game //////////

    uint256 counter;
    function _increment() internal {
        counter++;
    }
    function _decrement() internal {
        counter--;
    }

    uint256 randomness;
    function _setRandomness(uint256 _randomness) internal {
        randomness = _randomness;
    }

    uint256 selectedToken;
    function _selectToken(uint256 _tokenId) internal {
        selectedToken = _tokenId;
    }

    uint256 deadLine;
    function _setdeadLine(uint256 _deadLine) internal {
        deadLine = _deadLine;
    }

    uint256 freeTokenId;
    function _setFreeTokenId(uint256 _freeTokenId) internal {
        freeTokenId = _freeTokenId;
    }

    uint256 totalValueLocked_;
    function _lockValue(uint256 _value) internal {
        totalValueLocked_ += _value;
    }
    

    mapping(uint256 => uint256) tokenValue;
    function _setTokenValue(uint256 _tokenId, uint256 _tokenValue) internal {
        tokenValue[_tokenId] = _tokenValue;
    }

    mapping(uint256 => uint256) tokenBalance;
    function _setTokenBalance(uint256 _tokenId, uint256 _tokenBalance) internal {
        tokenBalance[_tokenId] = _tokenBalance;
    }
}