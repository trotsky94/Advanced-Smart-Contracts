# @version ^0.2.0

b: public(bool) # True or False
i: public(int128) # -2^127 to (2^127 - 1)
u: public(uint256) # 0 to (2^256-1)
d: public(decimal) # -2^127 to (2^127 - 1), 10 decimal places of precision
addr: public(address) # 20 bytes or 160 bits
b32: public(bytes32) # 32-bit-wide array
bs: public(Bytes[100]) # maxLen is lenght of the array
s: public(String[100]) #

@external
def __init__():
    # assignments using `self`
    self.b = True
    self.i = -1
    self.u = 123
    self.d = 3.14 
    self.addr = 0xDa1d30af457b8386083C66c9Df7A86269bEbFDF8
    self.b32 = 0xDa1d30af457b8386083C66c9Df7A86269bEbFDF8aabbccddeeff112233445566
    self.bs = b"\x01"
    self.s = "Hello world!"