# @version ^0.2.0

stored_data: uint256

@external
def __init__(_stored_data:uint256):
    self.stored_data = _stored_data

@external
def set_var(_stored_data:uint256):
    self.stored_data = _stored_data

@external
@view
def get_var() -> uint256:
    return self.stored_data