// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Pour remix il faut importer une url depuis un repository github
// Depuis un project Hardhat ou Truffle on utiliserait: import "@openzeppelin/ccontracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.1.0/contracts/token/ERC20/ERC20.sol";
import "./Ownable.sol";


contract King {
     // library usage
    using Address for address payable;
    
    mapping (address => uint256) private _allowances;
    mapping (address => uint256) _balancesPot;
    address private _players;
    address private _owner;
    uint256 private _initialPot;
    uint256 private _deposit;
    uint256 private _percentage;
    
    
    event Deposited(address indexed sender, uint256 amount);
    
    constructor(address owner_, uint256 initialPot_) {
        _owner = owner_;
        _initialPot = initialPot_;
    }
    
        // Function declarations below
    receive() external payable {
        deposit(msg.sender, msg.value);
    }

    
    
    function deposit() external payable {
       deposit(msg.sender, msg.value);
       
    
    }
    
     function deposit(address sender, uint256 amount) private {
        _balancesPot[sender] += amount;
        emit Deposited(sender, amount);
    }
    
    function withdraw(uint256 ) public {
        require(_balancesPot[msg.sender] > 0, "SmartWallet: can not withdraw 0 ether");
        uint256 amount = _balancesPot[msg.sender];
        _balancesPot[msg.sender] = 0;
        _balancesPot[_owner] += amount;
        payable(msg.sender).transfer(amount - amount);
    }
    
    function total() public view returns (uint256) {
        return address(this).balance;
    }
}