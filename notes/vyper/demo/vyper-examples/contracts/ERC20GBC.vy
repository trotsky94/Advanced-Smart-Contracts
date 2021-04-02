# @version ^0.2.0

"""
@title GBC TOken
@author Dhruvin
@license MIT
@notice ERC20 GBC Token
@dev Based onn ERC-20 standard as defined in EIP-20
"""

from vyper.interfaces import ERC20

implements: ERC20

event Transfer:
    _from: indexed(address)
    _to: indexed(address)
    _value: uint256

event Approval:
    _owner: indexed(address)
    _spender: indexed(address)
    _value: uint256

event SetAdmin:
    _admin: indexed(address)

event SetMinter:
    _minter: indexed(address)

name: public(String[64])
symbol: public(String[32])
decimals: public(uint256)

balanceOf: public(HashMap[address, uint256])
allowances: HashMap[address, HashMap[address,uint256]]
total_supply: uint256

admin:public(address)
minter:public(address)

@external
def __init__(_name: String[64], _symbol: String[32], _decimals: uint256, _total_supply:uint256):
    """
    @notice Contract constructor
    @param _name Token full name
    @param _symbol Token symbol
    @param _decimals Number of decimals for token
    @param _total_supply Total supply of tokens
    """
    self.name = _name
    self.symbol = _symbol
    self.decimals = _decimals
    self.total_supply = _total_supply
    self.balanceOf[msg.sender] = _total_supply
    self.admin = msg.sender
    log Transfer(ZERO_ADDRESS, msg.sender, _total_supply)

@external
@view
def totalSupply() -> uint256:
    """
    @notice Total number of tokens in existence
    """
    return self.total_supply


@external
@view
def allowance(_owner:address, _spender:address) -> uint256:
    """
    @notice Check the amount of tokens that an owner allowed to a spender
    @param _owner The address which owns the funds
    @param _spender The address which will spend the funds
    @return uint256 specifying the amount of tokens still available for the spender
    """
    return self.allowances[_owner][_spender]

@external
def transfer(_to: address, _value: uint256) -> bool:
    """
    @notice Transfer `_value` tokens from `msg.sender` to `_to`
    @dev Vyper does not allow underflow, so the subtraction in
        this function will revert on an insufficient balance
    @param _to The address to transfer to
    @param _value The amount to be transferred
    @return bool success
    """
    assert _to != ZERO_ADDRESS # dev: transfers to 0x0 are not allowed
    self.balanceOf[msg.sender] -= _value
    self.balanceOf[_to] += _value
    log Transfer(msg.sender, _to, _value)
    return True

@external
def approve(_spender: address, _value: uint256) -> bool:
    """
    @notice Approve `_spender` to transfer `_value` tokens on behalf of `msg.sender`
    @dev   Approval may only be from zero -> nonzero or from nonzero->zero in order to
            mitigate the potential race condition
    @param _spender The address which will spend the funds
    @param _value The amount of tokens to be spent
    @return bool success
    """
    assert _value == 0 or self.allowances[msg.sender][_spender] == 0
    self.allowances[msg.sender][_spender] = _value
    log Approval(msg.sender, _spender, _value)
    return True

@external
def transferFrom(_from: address,_to: address, _value: uint256) -> bool:
    """
    @notice Transfer `_value` tokens from `_from` to `_to`
    @param _from address The address which you want to send tokens from
    @param _to address The address which you want to transfer to
    @param _value uint256 The amount of tokens to be transferred
    @return bool success
    """
    assert _to != ZERO_ADDRESS # dev: transfers to 0x0 are not allowed
    # Note: Vyper does not allow underflows
    #       so the following subtraction would revert on insufficient balance 
    self.balanceOf[_from] -= _value
    self.balanceOf[_to] += _value
    self.allowances[_from][msg.sender] -= _value
    log Transfer(_from,_to,_value)
    return True

@external
def set_admin(_admin: address):
    """
    @notice Set the new admin
    @dev After all is set up, admin can only replace with another admin
    @param _admin New admin address
    """
    assert msg.sender == self.admin # dev: admin only
    self.admin = _admin
    log SetAdmin(_admin)

@external
def set_minter(_minter: address):
    """
    @notice Set the minter address
    @dev Only callable once, when minter has not yet been set
    @param _minter Address of minter
    """
    assert msg.sender == self.admin # dev: admin only
    assert self.minter == ZERO_ADDRESS # dev: can set the minter only once, at creation
    self.minter = _minter
    log SetMinter(_minter)

@external
def mint(_to: address, _value: uint256) -> bool:
    """
    @notice Mint `_value` tokens and assign them to `to`
    @dev Emits a Transfer Event originating from 0x00
    @param _to The account that will receive created tokens
    @param _value The amount that will be created
    @return bool success
    """
    assert msg.sender == self.minter # dev : minter only
    assert _to != ZERO_ADDRESS # dev : zero address
    self.total_supply += _value
    self.balanceOf[_to] += _value
    log Transfer(ZERO_ADDRESS, _to, _value)
    return True

@external
def burn(_value: uint256) -> bool:
    """
    @notice Burn `_value` tokens belonging to `msg.sender`
    @dev Emits a Transfer Event with a destination as 0x00
    @param _value The amount that will be burned
    @return bool success
    """
    self.total_supply -= _value
    self.balanceOf[msg.sender] -= _value
    log Transfer(msg.sender,ZERO_ADDRESS, _value)
    return True
