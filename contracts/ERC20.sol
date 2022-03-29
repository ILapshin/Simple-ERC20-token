// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/IERC20.sol";

/**
 * @title Simple ERC20 token
 *
 * @dev in accordance with https://eips.ethereum.org/EIPS/eip-20
 * SafeMath isn't used due to the compiler version
 */
contract ERC20 is IERC20 {

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowed;

    constructor(
        string memory tokenName, 
        string memory tokenSymbol, 
        uint8 tokenDecimals,
        uint256 tokenTotalSupply
    ) 
    {
        _name = tokenName;
        _symbol = tokenSymbol;
        _decimals = tokenDecimals;
        _totalSupply = tokenTotalSupply;        
    } 

    /**
     * @return the name of the token
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @return the symbol of the token
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @return the decimals of the token
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    /**
     * @return total supply of the token
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @return balance of the given address
     */
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    /**
     * @dev transfers token to a given address
     */
    function transfer(
        address _to, 
        uint256 _value
    ) 
        public 
        returns (bool success) 
    {
        require(_value <= balances[msg.sender], "Insufficient balance.");

        balances[msg.sender] =  balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * @dev transfers token to a given address 
     * from a behalf of another given address
     */
    function transferFrom(
        address _from, 
        address _to, 
        uint256 _value
    ) 
        public 
        returns (bool success) 
    {
        require(_value <= allowed[_from][msg.sender], "Not allowed.");
        require(_value <= balances[_from], "Insufficient balance.");

        balances[_from] =  balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
     * @dev approves the given address to transfer given ammount of the tokens 
     * from a behalf of sender's address
     */
    function approve(
        address _spender, 
        uint256 _value
    ) 
        public 
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @return remaining amount of the tokens that the given address
     * is allowed to transfer from a behalf of a sender
     */
    function allowance(
        address _owner, 
        address _spender
    ) 
        public view 
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }

    /**
     * @dev mints new tokens to a given address
     * and fires a Transfer from the token contract event
     */
    function _mint(
        address _to,
        uint256 _value
    )
        internal
    {
        balances[_to] = balances[_to] + _value;
        emit Transfer(address(this), _to, _value);
    }
}





