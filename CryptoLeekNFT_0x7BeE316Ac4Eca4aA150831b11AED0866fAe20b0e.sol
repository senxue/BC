#
#  Panoramix v4 Oct 2019 
#  Decompiled source of poly:0x7BeE316Ac4Eca4aA150831b11AED0866fAe20b0e
# 
#  Let's make the world open source 
# 
#
#  I failed with these: 
#  - tokenURI(uint256 _tokenId)
#  All the rest is below.
#

def storage:
  stor0 is array of struct at storage 0
  stor1 is array of struct at storage 1
  ownerOf is mapping of addr at storage 2
  balanceOf is mapping of uint256 at storage 3
  approved is mapping of addr at storage 4
  stor5 is mapping of uint8 at storage 5
  stor6 is mapping of struct at storage 6
  counter is uint256 at storage 7

def getApproved(uint256 _tokenId) payable: 
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
  return approved[_tokenId]

def counter() payable: 
  return counter

def ownerOf(uint256 _tokenId) payable: 
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  return ownerOf[_tokenId]

def balanceOf(address _owner) payable: 
  require calldata.size - 4 >=′ 32
  require _owner == _owner
  if not _owner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: balance query for the zero address'
  return balanceOf[addr(_owner)]

def isApprovedForAll(address _owner, address _operator) payable: 
  require calldata.size - 4 >=′ 64
  require _owner == _owner
  require _operator == _operator
  return bool(stor5[addr(_owner)][addr(_operator)])

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def supportsInterface(bytes4 _interfaceId) payable: 
  require calldata.size - 4 >=′ 32
  require _interfaceId == Mask(32, 224, _interfaceId)
  if Mask(32, 224, _interfaceId) == 0x80ac58cd00000000000000000000000000000000000000000000000000000000:
      return True
  if Mask(32, 224, _interfaceId) == 0x5b5e139f00000000000000000000000000000000000000000000000000000000:
      return True
  return (Mask(32, 224, _interfaceId) == 0x1ffc9a700000000000000000000000000000000000000000000000000000000)

def setApprovalForAll(address _to, bool _approved) payable: 
  require calldata.size - 4 >=′ 64
  require _to == _to
  require _approved == _approved
  if _to == caller:
      revert with 0, 'ERC721: approve to caller'
  stor5[caller][addr(_to)] = uint8(_approved)
  log ApprovalForAll(
        address owner=_approved,
        address operator=caller,
        bool approved=_to)

def approve(address _spender, uint256 _value) payable: 
  require calldata.size - 4 >=′ 64
  require _spender == _spender
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if _spender == ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approval to current owner'
  if ownerOf[_value] != caller:
      if not stor5[stor2[_value]][caller]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                      'ERC721: approve caller is not owner nor approved for all'
  approved[_value] = _spender
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=_spender,
        uint256 value=_value)

def transferFrom(address _from, address _to, uint256 _value) payable: 
  require calldata.size - 4 >=′ 96
  require _from == _from
  require _to == _to
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != caller:
      if not ownerOf[_value]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
      if approved[_value] != caller:
          if not stor5[stor2[_value]][caller]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer to the zero address'
  approved[_value] = 0
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=0,
        uint256 value=_value)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_value] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_value)

def safeTransferFrom(address _from, address _to, uint256 _tokenId) payable: 
  require calldata.size - 4 >=′ 96
  require _from == _from
  require _to == _to
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != caller:
      if not ownerOf[_tokenId]:
          revert with 0, 'ERC721: approved query for nonexistent token'
      if approved[_tokenId] != caller:
          if not stor5[stor2[_tokenId]][caller]:
              revert with 0, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != _from:
      revert with 0, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0, 'ERC721: transfer to the zero address'
  approved[_tokenId] = 0
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_tokenId],
        address spender=0,
        uint256 value=_tokenId)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_tokenId] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_tokenId)
  if ext_code.size(_to) > 0:
      require ext_code.size(_to)
      call _to.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args 0, uint32(caller), addr(_from), _tokenId, 128, 0
      if not ext_call.success:
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'

def safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data) payable: 
  require calldata.size - 4 >=′ 128
  require _from == _from
  require _to == _to
  require _tokenId == _tokenId
  require _data <= 18446744073709551615
  require _data + 35 <′ calldata.size
  if _data.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_data.length)) + 97 > 18446744073709551615 or ceil32(ceil32(_data.length)) + 97 < 96:
      revert with 'NH{q', 65
  require _data + _data.length + 36 <= calldata.size
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != caller:
      if not ownerOf[_tokenId]:
          revert with 0, 'ERC721: approved query for nonexistent token'
      if approved[_tokenId] != caller:
          if not stor5[stor2[_tokenId]][caller]:
              revert with 0, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != _from:
      revert with 0, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0, 'ERC721: transfer to the zero address'
  approved[_tokenId] = 0
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_tokenId],
        address spender=0,
        uint256 value=_tokenId)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_tokenId] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_tokenId)
  if ext_code.size(_to) > 0:
      require ext_code.size(_to)
      call _to.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args caller, addr(_from), _tokenId, Array(len=_data.length, data=_data[all])
      if not ext_call.success:
          if not return_data.size:
              if not _data.length:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with _data[all]
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'

def unknown7c4bcc14(array _param1) payable: 
  require calldata.size - 4 >=′ 32
  require _param1 <= 18446744073709551615
  require _param1 + 35 <′ calldata.size
  if _param1.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_param1.length)) + 97 > 18446744073709551615 or ceil32(ceil32(_param1.length)) + 97 < 96:
      revert with 'NH{q', 65
  require _param1 + _param1.length + 36 <= calldata.size
  if not caller:
      revert with 0, 'ERC721: mint to the zero address'
  if ownerOf[stor7]:
      revert with 0, 'ERC721: token already minted'
  if balanceOf[caller] > -2:
      revert with 'NH{q', 17
  balanceOf[caller]++
  ownerOf[stor7] = caller
  log Transfer(
        address from=0,
        address to=caller,
        uint256 value=counter)
  if ext_code.size(caller) > 0:
      require ext_code.size(caller)
      call caller.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args caller, 0, counter, 128, 0
      if not ext_call.success:
          if not return_data.size:
              if not _param1.length:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with _param1[all]
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
  if not ownerOf[stor7]:
      revert with 0, 'ERC721URIStorage: URI set of nonexistent token'
  if stor6[stor7].field_0:
      if stor6[stor7].field_0 == stor6[stor7].field_1 < 32:
          revert with 'NH{q', 34
      if _param1.length:
          stor6[stor7][].field_0 = Array(len=_param1.length, data=_param1[all])
      else:
          stor6[stor7].field_0 = 0
          idx = 0
          while stor6[stor7].field_1 + 31 / 32 > idx:
              stor6[stor7][idx].field_0 = 0
              idx = idx + 1
              continue 
  else:
      if stor6[stor7].field_0 == stor6[stor7].field_1 < 32:
          revert with 'NH{q', 34
      if _param1.length:
          stor6[stor7][].field_0 = Array(len=_param1.length, data=_param1[all])
      else:
          stor6[stor7].field_0 = 0
          idx = 0
          while stor6[stor7].field_1 + 31 / 32 > idx:
              stor6[stor7][idx].field_0 = 0
              idx = idx + 1
              continue 
  if counter == -1:
      revert with 'NH{q', 17
  counter++
  return counter

def burn(uint256 _value) payable: 
  require calldata.size - 4 >=′ 32
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != caller:
      if not ownerOf[_value]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
      if approved[_value] != caller:
          if not stor5[stor2[_value]][caller]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'You are not the owner nor approved!'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  approved[_value] = 0
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=0,
        uint256 value=_value)
  if balanceOf[stor2[_value]] < 1:
      revert with 'NH{q', 17
  balanceOf[stor2[_value]]--
  ownerOf[_value] = 0
  log Transfer(
        address from=ownerOf[_value],
        address to=0,
        uint256 value=_value)
  if stor6[_value].field_0:
      if stor6[_value].field_0 == stor6[_value].field_1 < 32:
          revert with 'NH{q', 34
      if stor6[_value].field_1:
          if stor6[_value].field_0:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 
          else:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 
  else:
      if stor6[_value].field_0 == stor6[_value].field_1 < 32:
          revert with 'NH{q', 34
      if stor6[_value].field_1:
          if stor6[_value].field_0:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 
          else:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 

def name() payable: 
  if bool(stor0.length):
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor0.length):
          if bool(stor0.length) == stor0.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor0.length.field_1:
              if 31 < stor0.length.field_1:
                  mem[128] = uint256(stor0.field_0)
                  idx = 128
                  s = 0
                  while stor0.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor0[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)])
              mem[128] = 256 * stor0.length.field_8
      else:
          if bool(stor0.length) == stor0.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor0.length.field_1:
              if 31 < stor0.length.field_1:
                  mem[128] = uint256(stor0.field_0)
                  idx = 128
                  s = 0
                  while stor0.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor0[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)])
              mem[128] = 256 * stor0.length.field_8
      mem[ceil32(stor0.length.field_1) + 192 len ceil32(stor0.length.field_1)] = mem[128 len ceil32(stor0.length.field_1)]
      if ceil32(stor0.length.field_1) > stor0.length.field_1:
          mem[ceil32(stor0.length.field_1) + stor0.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)], mem[(2 * ceil32(stor0.length.field_1)) + 192 len 2 * ceil32(stor0.length.field_1)]), 
  if bool(stor0.length) == stor0.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor0.length):
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor0.length.field_1:
          if 31 < stor0.length.field_1:
              mem[128] = uint256(stor0.field_0)
              idx = 128
              s = 0
              while stor0.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor0[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)])
          mem[128] = 256 * stor0.length.field_8
  else:
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor0.length.field_1:
          if 31 < stor0.length.field_1:
              mem[128] = uint256(stor0.field_0)
              idx = 128
              s = 0
              while stor0.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor0[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)])
          mem[128] = 256 * stor0.length.field_8
  mem[ceil32(stor0.length.field_1) + 192 len ceil32(stor0.length.field_1)] = mem[128 len ceil32(stor0.length.field_1)]
  if ceil32(stor0.length.field_1) > stor0.length.field_1:
      mem[ceil32(stor0.length.field_1) + stor0.length.field_1 + 192] = 0
  return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)], mem[(2 * ceil32(stor0.length.field_1)) + 192 len 2 * ceil32(stor0.length.field_1)]), 

def symbol() payable: 
  if bool(stor1.length):
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor1.length):
          if bool(stor1.length) == stor1.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor1.length.field_1:
              if 31 < stor1.length.field_1:
                  mem[128] = uint256(stor1.field_0)
                  idx = 128
                  s = 0
                  while stor1.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor1[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)])
              mem[128] = 256 * stor1.length.field_8
      else:
          if bool(stor1.length) == stor1.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor1.length.field_1:
              if 31 < stor1.length.field_1:
                  mem[128] = uint256(stor1.field_0)
                  idx = 128
                  s = 0
                  while stor1.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor1[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)])
              mem[128] = 256 * stor1.length.field_8
      mem[ceil32(stor1.length.field_1) + 192 len ceil32(stor1.length.field_1)] = mem[128 len ceil32(stor1.length.field_1)]
      if ceil32(stor1.length.field_1) > stor1.length.field_1:
          mem[ceil32(stor1.length.field_1) + stor1.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)], mem[(2 * ceil32(stor1.length.field_1)) + 192 len 2 * ceil32(stor1.length.field_1)]), 
  if bool(stor1.length) == stor1.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor1.length):
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor1.length.field_1:
          if 31 < stor1.length.field_1:
              mem[128] = uint256(stor1.field_0)
              idx = 128
              s = 0
              while stor1.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor1[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)])
          mem[128] = 256 * stor1.length.field_8
  else:
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor1.length.field_1:
          if 31 < stor1.length.field_1:
              mem[128] = uint256(stor1.field_0)
              idx = 128
              s = 0
              while stor1.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor1[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)])
          mem[128] = 256 * stor1.length.field_8
  mem[ceil32(stor1.length.field_1) + 192 len ceil32(stor1.length.field_1)] = mem[128 len ceil32(stor1.length.field_1)]
  if ceil32(stor1.length.field_1) > stor1.length.field_1:
      mem[ceil32(stor1.length.field_1) + stor1.length.field_1 + 192] = 0
  return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)], mem[(2 * ceil32(stor1.length.field_1)) + 192 len 2 * ceil32(stor1.length.field_1)]), #
#  Panoramix v4 Oct 2019 
#  Decompiled source of poly:0x7BeE316Ac4Eca4aA150831b11AED0866fAe20b0e
# 
#  Let's make the world open source 
# 
#
#  I failed with these: 
#  - tokenURI(uint256 _tokenId)
#  All the rest is below.
#

def storage:
  stor0 is array of struct at storage 0
  stor1 is array of struct at storage 1
  ownerOf is mapping of addr at storage 2
  balanceOf is mapping of uint256 at storage 3
  approved is mapping of addr at storage 4
  stor5 is mapping of uint8 at storage 5
  stor6 is mapping of struct at storage 6
  counter is uint256 at storage 7

def getApproved(uint256 _tokenId) payable: 
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
  return approved[_tokenId]

def counter() payable: 
  return counter

def ownerOf(uint256 _tokenId) payable: 
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  return ownerOf[_tokenId]

def balanceOf(address _owner) payable: 
  require calldata.size - 4 >=′ 32
  require _owner == _owner
  if not _owner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: balance query for the zero address'
  return balanceOf[addr(_owner)]

def isApprovedForAll(address _owner, address _operator) payable: 
  require calldata.size - 4 >=′ 64
  require _owner == _owner
  require _operator == _operator
  return bool(stor5[addr(_owner)][addr(_operator)])

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def supportsInterface(bytes4 _interfaceId) payable: 
  require calldata.size - 4 >=′ 32
  require _interfaceId == Mask(32, 224, _interfaceId)
  if Mask(32, 224, _interfaceId) == 0x80ac58cd00000000000000000000000000000000000000000000000000000000:
      return True
  if Mask(32, 224, _interfaceId) == 0x5b5e139f00000000000000000000000000000000000000000000000000000000:
      return True
  return (Mask(32, 224, _interfaceId) == 0x1ffc9a700000000000000000000000000000000000000000000000000000000)

def setApprovalForAll(address _to, bool _approved) payable: 
  require calldata.size - 4 >=′ 64
  require _to == _to
  require _approved == _approved
  if _to == caller:
      revert with 0, 'ERC721: approve to caller'
  stor5[caller][addr(_to)] = uint8(_approved)
  log ApprovalForAll(
        address owner=_approved,
        address operator=caller,
        bool approved=_to)

def approve(address _spender, uint256 _value) payable: 
  require calldata.size - 4 >=′ 64
  require _spender == _spender
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if _spender == ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approval to current owner'
  if ownerOf[_value] != caller:
      if not stor5[stor2[_value]][caller]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                      'ERC721: approve caller is not owner nor approved for all'
  approved[_value] = _spender
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=_spender,
        uint256 value=_value)

def transferFrom(address _from, address _to, uint256 _value) payable: 
  require calldata.size - 4 >=′ 96
  require _from == _from
  require _to == _to
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != caller:
      if not ownerOf[_value]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
      if approved[_value] != caller:
          if not stor5[stor2[_value]][caller]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer to the zero address'
  approved[_value] = 0
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=0,
        uint256 value=_value)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_value] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_value)

def safeTransferFrom(address _from, address _to, uint256 _tokenId) payable: 
  require calldata.size - 4 >=′ 96
  require _from == _from
  require _to == _to
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != caller:
      if not ownerOf[_tokenId]:
          revert with 0, 'ERC721: approved query for nonexistent token'
      if approved[_tokenId] != caller:
          if not stor5[stor2[_tokenId]][caller]:
              revert with 0, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != _from:
      revert with 0, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0, 'ERC721: transfer to the zero address'
  approved[_tokenId] = 0
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_tokenId],
        address spender=0,
        uint256 value=_tokenId)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_tokenId] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_tokenId)
  if ext_code.size(_to) > 0:
      require ext_code.size(_to)
      call _to.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args 0, uint32(caller), addr(_from), _tokenId, 128, 0
      if not ext_call.success:
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'

def safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data) payable: 
  require calldata.size - 4 >=′ 128
  require _from == _from
  require _to == _to
  require _tokenId == _tokenId
  require _data <= 18446744073709551615
  require _data + 35 <′ calldata.size
  if _data.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_data.length)) + 97 > 18446744073709551615 or ceil32(ceil32(_data.length)) + 97 < 96:
      revert with 'NH{q', 65
  require _data + _data.length + 36 <= calldata.size
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != caller:
      if not ownerOf[_tokenId]:
          revert with 0, 'ERC721: approved query for nonexistent token'
      if approved[_tokenId] != caller:
          if not stor5[stor2[_tokenId]][caller]:
              revert with 0, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != _from:
      revert with 0, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0, 'ERC721: transfer to the zero address'
  approved[_tokenId] = 0
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_tokenId],
        address spender=0,
        uint256 value=_tokenId)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_tokenId] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_tokenId)
  if ext_code.size(_to) > 0:
      require ext_code.size(_to)
      call _to.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args caller, addr(_from), _tokenId, Array(len=_data.length, data=_data[all])
      if not ext_call.success:
          if not return_data.size:
              if not _data.length:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with _data[all]
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'

def unknown7c4bcc14(array _param1) payable: 
  require calldata.size - 4 >=′ 32
  require _param1 <= 18446744073709551615
  require _param1 + 35 <′ calldata.size
  if _param1.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_param1.length)) + 97 > 18446744073709551615 or ceil32(ceil32(_param1.length)) + 97 < 96:
      revert with 'NH{q', 65
  require _param1 + _param1.length + 36 <= calldata.size
  if not caller:
      revert with 0, 'ERC721: mint to the zero address'
  if ownerOf[stor7]:
      revert with 0, 'ERC721: token already minted'
  if balanceOf[caller] > -2:
      revert with 'NH{q', 17
  balanceOf[caller]++
  ownerOf[stor7] = caller
  log Transfer(
        address from=0,
        address to=caller,
        uint256 value=counter)
  if ext_code.size(caller) > 0:
      require ext_code.size(caller)
      call caller.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args caller, 0, counter, 128, 0
      if not ext_call.success:
          if not return_data.size:
              if not _param1.length:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with _param1[all]
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
  if not ownerOf[stor7]:
      revert with 0, 'ERC721URIStorage: URI set of nonexistent token'
  if stor6[stor7].field_0:
      if stor6[stor7].field_0 == stor6[stor7].field_1 < 32:
          revert with 'NH{q', 34
      if _param1.length:
          stor6[stor7][].field_0 = Array(len=_param1.length, data=_param1[all])
      else:
          stor6[stor7].field_0 = 0
          idx = 0
          while stor6[stor7].field_1 + 31 / 32 > idx:
              stor6[stor7][idx].field_0 = 0
              idx = idx + 1
              continue 
  else:
      if stor6[stor7].field_0 == stor6[stor7].field_1 < 32:
          revert with 'NH{q', 34
      if _param1.length:
          stor6[stor7][].field_0 = Array(len=_param1.length, data=_param1[all])
      else:
          stor6[stor7].field_0 = 0
          idx = 0
          while stor6[stor7].field_1 + 31 / 32 > idx:
              stor6[stor7][idx].field_0 = 0
              idx = idx + 1
              continue 
  if counter == -1:
      revert with 'NH{q', 17
  counter++
  return counter

def burn(uint256 _value) payable: 
  require calldata.size - 4 >=′ 32
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != caller:
      if not ownerOf[_value]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
      if approved[_value] != caller:
          if not stor5[stor2[_value]][caller]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'You are not the owner nor approved!'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  approved[_value] = 0
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=0,
        uint256 value=_value)
  if balanceOf[stor2[_value]] < 1:
      revert with 'NH{q', 17
  balanceOf[stor2[_value]]--
  ownerOf[_value] = 0
  log Transfer(
        address from=ownerOf[_value],
        address to=0,
        uint256 value=_value)
  if stor6[_value].field_0:
      if stor6[_value].field_0 == stor6[_value].field_1 < 32:
          revert with 'NH{q', 34
      if stor6[_value].field_1:
          if stor6[_value].field_0:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 
          else:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 
  else:
      if stor6[_value].field_0 == stor6[_value].field_1 < 32:
          revert with 'NH{q', 34
      if stor6[_value].field_1:
          if stor6[_value].field_0:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 
          else:
              if stor6[_value].field_0 == stor6[_value].field_1 < 32:
                  revert with 'NH{q', 34
              stor6[_value].field_0 = 0
              if 31 < stor6[_value].field_1:
                  idx = 0
                  while stor6[_value].field_1 + 31 / 32 > idx:
                      stor6[_value][idx].field_0 = 0
                      idx = idx + 1
                      continue 

def name() payable: 
  if bool(stor0.length):
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor0.length):
          if bool(stor0.length) == stor0.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor0.length.field_1:
              if 31 < stor0.length.field_1:
                  mem[128] = uint256(stor0.field_0)
                  idx = 128
                  s = 0
                  while stor0.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor0[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)])
              mem[128] = 256 * stor0.length.field_8
      else:
          if bool(stor0.length) == stor0.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor0.length.field_1:
              if 31 < stor0.length.field_1:
                  mem[128] = uint256(stor0.field_0)
                  idx = 128
                  s = 0
                  while stor0.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor0[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)])
              mem[128] = 256 * stor0.length.field_8
      mem[ceil32(stor0.length.field_1) + 192 len ceil32(stor0.length.field_1)] = mem[128 len ceil32(stor0.length.field_1)]
      if ceil32(stor0.length.field_1) > stor0.length.field_1:
          mem[ceil32(stor0.length.field_1) + stor0.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)], mem[(2 * ceil32(stor0.length.field_1)) + 192 len 2 * ceil32(stor0.length.field_1)]), 
  if bool(stor0.length) == stor0.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor0.length):
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor0.length.field_1:
          if 31 < stor0.length.field_1:
              mem[128] = uint256(stor0.field_0)
              idx = 128
              s = 0
              while stor0.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor0[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)])
          mem[128] = 256 * stor0.length.field_8
  else:
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor0.length.field_1:
          if 31 < stor0.length.field_1:
              mem[128] = uint256(stor0.field_0)
              idx = 128
              s = 0
              while stor0.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor0[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)])
          mem[128] = 256 * stor0.length.field_8
  mem[ceil32(stor0.length.field_1) + 192 len ceil32(stor0.length.field_1)] = mem[128 len ceil32(stor0.length.field_1)]
  if ceil32(stor0.length.field_1) > stor0.length.field_1:
      mem[ceil32(stor0.length.field_1) + stor0.length.field_1 + 192] = 0
  return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)], mem[(2 * ceil32(stor0.length.field_1)) + 192 len 2 * ceil32(stor0.length.field_1)]), 

def symbol() payable: 
  if bool(stor1.length):
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor1.length):
          if bool(stor1.length) == stor1.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor1.length.field_1:
              if 31 < stor1.length.field_1:
                  mem[128] = uint256(stor1.field_0)
                  idx = 128
                  s = 0
                  while stor1.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor1[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)])
              mem[128] = 256 * stor1.length.field_8
      else:
          if bool(stor1.length) == stor1.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor1.length.field_1:
              if 31 < stor1.length.field_1:
                  mem[128] = uint256(stor1.field_0)
                  idx = 128
                  s = 0
                  while stor1.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor1[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)])
              mem[128] = 256 * stor1.length.field_8
      mem[ceil32(stor1.length.field_1) + 192 len ceil32(stor1.length.field_1)] = mem[128 len ceil32(stor1.length.field_1)]
      if ceil32(stor1.length.field_1) > stor1.length.field_1:
          mem[ceil32(stor1.length.field_1) + stor1.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)], mem[(2 * ceil32(stor1.length.field_1)) + 192 len 2 * ceil32(stor1.length.field_1)]), 
  if bool(stor1.length) == stor1.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor1.length):
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor1.length.field_1:
          if 31 < stor1.length.field_1:
              mem[128] = uint256(stor1.field_0)
              idx = 128
              s = 0
              while stor1.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor1[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)])
          mem[128] = 256 * stor1.length.field_8
  else:
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor1.length.field_1:
          if 31 < stor1.length.field_1:
              mem[128] = uint256(stor1.field_0)
              idx = 128
              s = 0
              while stor1.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor1[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)])
          mem[128] = 256 * stor1.length.field_8
  mem[ceil32(stor1.length.field_1) + 192 len ceil32(stor1.length.field_1)] = mem[128 len ceil32(stor1.length.field_1)]
  if ceil32(stor1.length.field_1) > stor1.length.field_1:
      mem[ceil32(stor1.length.field_1) + stor1.length.field_1 + 192] = 0
  return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)], mem[(2 * ceil32(stor1.length.field_1)) + 192 len 2 * ceil32(stor1.length.field_1)]), 
