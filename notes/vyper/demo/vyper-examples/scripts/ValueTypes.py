#!/usr/bin/python3

from brownie import ValueTypes, accounts

def main():
    return ValueTypes.deploy({from:accounts[0]})