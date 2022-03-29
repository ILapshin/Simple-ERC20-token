// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "./ERC20.sol";

/**
 * @title BUNNY token
 *
 * @dev implementation of ERC20 token with a bit of additional functionality.
 * You are welcome to claim and get some BUNNY.
 * 
 * @dev BUNNY for everyone, for free! And may nobody go offended!
 */
contract Bunny is ERC20 {

    mapping (address => bool) claimed;
    uint256 claimedAmmound;

    event Claiming(
        address indexed _claimer, 
        uint256 _value
    );

    constructor() ERC20("BUNNY", "BUN", 18, 1000000 ether) {}

    /**
     * @dev every address can claim a half of remained not distributed amount of tokens
     * claim could be proceed only once for an address
     */
    function claim() public returns(bool success) {
        require(!claimed[msg.sender], "You've already got your BUNNY!");

        uint256 claimingAmmount = (totalSupply() - claimedAmmound) / 2;
        _mint(msg.sender, claimingAmmount);
        claimed[msg.sender] = true;
        claimedAmmound = claimedAmmound + claimingAmmount;
        emit Claiming(msg.sender, claimingAmmount);
        return true;
    }

    /**
     * @return claimable amount of the tokens
     */
    function claimable() public view returns(uint256 claimable) {
        return totalSupply() - claimedAmmound;
    }

    /**
     * @return boolean if the given address has already claimed BUNNY
     */
    function hasClaimed(address claimer) public view returns(bool) {
        return claimed[claimer];
    }
}