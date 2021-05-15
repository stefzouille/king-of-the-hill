// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";
import "./Ownable.sol";

contract kingOfTheHill {
    
     // library usage
    using Address for address payable;
    
    mapping (address => uint256) private _balances;        //solde du S.M.
    uint256 private _pot;                                  //solde du pot
    uint256 private _seed;                                 //seed reversé
    address private _owner;                                //owner du S.M.
    address private _ownerKing;                            //vainqueur du pot
    address private _player;                               //joueur qui rentre   
    uint256 private _numberBloc;
    uint256 private _offer;                                //mise du joueur
    uint256 private _counter;                              //compteur du bloc
    uint256 private _profit;
    
    // Events
    event Deposited(address indexed sender, uint256 amount);
    
    //function modifier
    modifier ownerKing() {
        require(msg.value == _pot * 2, "kingOfTheHill: the offer must be greater or equal than twice the pot");
        _;
    }
    
    constructor(address owner_, uint256 numberBloc_) payable {    //initialisation address du owner et nb de bloc au deploy
        _owner = owner_;
        _numberBloc = numberBloc_;
        
    }
        
    
    // Function declarations below
    receive() external payable {
        _deposit(msg.sender, msg.value);
    }

    function deposit(address send) external payable {
      
        _ownerKing <= send;
        _deposit(msg.sender, msg.value);
    }
    
    function whoIsKing() public view returns (address) {
        return _ownerKing;
    }
    
    function total() public view returns (uint256) {
        return address(this).balance;
    }

 
    
    function _deposit(address sender, uint256 amount) private {
        _balances[sender] += amount;
        emit Deposited(sender, amount);
        _ownerKing = sender;
        
    }
    
    
}