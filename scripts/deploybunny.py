from brownie import accounts, Bunny, network
from web3 import Web3

def deploy_bunny():    
    # Deploying BUNNY token on the real network

    account = accounts.load('metamask-dev')  
    bunny = Bunny.deploy({'from': account}, publish_source=True)
    print(bunny)

def deploy_bunny_locally():
    # Some testing of BUNNY functionality on a local Ganache

    account = accounts[0]
    bunny = Bunny.deploy({'from': account})
    balance = bunny.balanceOf(account)
    print(balance)
    
    tx = bunny.claim({'from': account})
    tx.wait(1)

    account_1 = accounts[1]
    tx_1 = bunny.claim({'from': account_1})
    tx_1.wait(1)
    print('Total supply: {}'.format(bunny.totalSupply()), '{}: {}'.format(account, bunny.balanceOf(account)), '{}: {}'.format(account_1, bunny.balanceOf(account_1)))

    tx_transfer = bunny.transfer(account_1, Web3.toWei(5, 'ether'), {'from': account})
    tx_transfer.wait(1)
    print('Total supply: {}'.format(bunny.totalSupply()), '{}: {}'.format(account, bunny.balanceOf(account)), '{}: {}'.format(account_1, bunny.balanceOf(account_1)))

    print(bunny.hasClaimed(account_1))
    accounts_2 = accounts[2]
    print(bunny.hasClaimed(accounts_2))

    print(bunny.claimable())

def main():
    if network.show_active() == 'development':
        deploy_bunny_locally()
    else:
        deploy_bunny()