# Co-creator and shareholder marketplace

***
## 【Introduction of Co-creator and shareholder marketplace】
- Co-creator marketplace is a smart contract for increating engagement of game players and incentivize them in game dApps.
  - This smart contract provides `"profit share system"` in game dApps through buy/sell items which is created by players.

<br>


- Players can work with another players as `"Co-creater"` and can get shared profit from items which is created by themself as `"shareholders"` .
  - Game players can propose idea of items they want to realize in game dApp they play.
    - Items are things which is used in the game. (e.g. Weapon) 
    - Proposed idea of item is published as Non-Fungible token.
  
  - Published items is listed and any players can buy/sell on marketplace. 
    - If someone buy item, profits from bought amount are distributed into players which joined creating process of that item. (by smart contract)
   （Profits are shared between every shareholders）

<br>


## 【Work Frow】
1. Game players proposes ideas of item (e.g. Weapon) 
2. Proposed idea is listed on marketplace.
   - If players proposes idea of item, they need to register from `"Item Registry"` (Put several information by following form and push submit button) 
3. Another players choose idea which they want to realize and create together in that list and join creating process of item.
   - Players who joined creating process of item are called `"Shareholders"` . 
   - If Another players want to join creating process, they need to register from `"shareholder registry"` (Just put Item ID and push submit button) 
4. Some players get together and create that item and listed on specific marketplace for buying/selling item created by players.    
5. If someone buy items in this specific marketplace, profits from bought amount are distributed into players which joined creating process of that item. (by smart contract)
   - If someone buy listed item, they need to push `"Buy Item"` button at item ID which correspond to item they want to buy.
   - Pay with `DAI` .

<br>

## 【Advantage for game players and game developers】
- For game players
  - Players can propose ideas which are used in the game freely.
     - So that players are not only just play game, but also enjoy creating process of item and get rights for getting income from item which created by them.
  - Players who joined creating process of item can get shared profit if that item was bought. 
  （※ Players who joined creating process of item are called `"Shareholders"` ）

<br>

- For game developers
  - Developers can reuse this structure and integrate their games by utilizing interface file.
  （I have been in progress to prepare interface file for reusing codes of smart contract yet...）

<br>

## 【Remaining tasks】
- Prepare interface file for integrating this smart contract with game dApps.
- Integrate `idleDAI` into payment process.  
https://idle.finance/

***

## 【Setup sample dApp】
### Setup wallet by using Metamask
1. Add MetaMask to browser (Chrome or FireFox or Opera or Brave)    
https://metamask.io/  


2. Adjust appropriate newwork below 
```
Ropsten Test Network
```

&nbsp;


### Setup backend
1. Transfer `DAI (on ropsten)` from your wallet address to `deployer's address` on ropsten network. 
  - If you want to get DAI( `"0xaD6D458402F60fD3Bd25163575031ACDce07538D"` ) on ropsten, you can get it by swapping in `KyberSwap on Ropsten` below.  
    https://ropsten.kyber.network/swap/eth-dai


2. Deploy contracts to Ropsten Test Network
```
(root directory)

$ npm run migrate:ropsten
```

&nbsp;


### Setup frontend
1. Execute command below in root directory.
```
$ npm run client
```

2. Access to browser by using link 
```
http://127.0.0.1:3000/co-creator-and-shareholder-marketplace
```

&nbsp;



***

## 【References】
- [Funding The Future / Gitcoin Hackathon]
  - [OPGames Challenge 2] Use DeFi To Create New Innovative Crypto Payout Mechanisms For Non-Blockchain Games  
  https://gitcoin.co/issue/alto-io/funding-the-future/2/4126

  - Repos of funding-the-future  
    https://github.com/alto-io/funding-the-future  

  - Reference articles  
    - Decentralizing Video Games - An Introduction  
      https://medium.com/@w_brealey/5-ethereum-defi-apps-revolutionizing-saving-9f717fe2e595

    - 5 Ethereum DeFi Apps Revolutionizing Saving  
      https://medium.com/@w_brealey/5-ethereum-defi-apps-revolutionizing-saving-9f717fe2e595



<br>

- Outplay Games Links:  
  - Repos  
    https://github.com/alto-io 

  - Website    
    https://outplay.games

  - Discord  
    https://discordapp.com/invite/nvqqmrP

  - Medium   
    https://medium.com/alto-io

  - Twitter  
    https://twitter.com/Outplay_Games

<br>

- KyberSwap on Ropsten  
  - If you want to get DAI( `"0xaD6D458402F60fD3Bd25163575031ACDce07538D"` ) on ropsten, you can get it from here.  
    https://ropsten.kyber.network/swap/eth-dai
