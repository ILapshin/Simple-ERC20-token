# Simple ERC20 token

Simple implementation of ERC20 token in acordance with https://eips.ethereum.org/EIPS/eip-20.

The project was created and deployed using Brownie framework. 

## BUNNY token
An ERC20 token with additional functionality. 
It has constant total supply, and each address can claim a half of non distributed tokens. 
Claiming can be performed once per address. 
List of addresses that already claimed tokens is realized as a address->boolean mapping. 
If an already claimed address tries it again, transaction will be reverted.

BUNNY is [deployed on the Rinkeby testnet](https://rinkeby.etherscan.io/token/0x6FD863A505F33d501Af5D430Bc7C8D405F42eCFd#readContract). 
You are free to recieve a half of remaining BUNNY.
