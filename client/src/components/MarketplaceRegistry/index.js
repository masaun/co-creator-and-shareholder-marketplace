import React, { Component } from "react";
import getWeb3, { getGanacheWeb3, Web3 } from "../../utils/getWeb3";

import App from "../../App.js";

import { Typography, Grid, TextField } from '@material-ui/core';
import { ThemeProvider } from '@material-ui/styles';
import { theme } from '../../utils/theme';
import { Loader, Button, Card, Input, Heading, Table, Form, Flex, Box, Image, EthAddress } from 'rimble-ui';
import { zeppelinSolidityHotLoaderOptions } from '../../../config/webpack';

import styles from '../../App.module.scss';
//import './App.css';

import { walletAddressList } from '../../data/testWalletAddress'



export default class MarketplaceRegistry extends Component {
  constructor(props) {    
    super(props);

    this.state = {
      /////// Default state
      storageValue: 0,
      web3: null,
      accounts: null,
      route: window.location.pathname.replace("/", "")
    };

    this.getTestData = this.getTestData.bind(this);
    this.mintTo = this.mintTo.bind(this);
    this.itemOwnerOf = this.itemOwnerOf.bind(this);
    this.ownershipTransferOrderedItem = this.ownershipTransferOrderedItem.bind(this);
    this.buyItem = this.buyItem.bind(this);
    this.stakeholderRegistry = this.stakeholderRegistry.bind(this);
    this.getItem = this.getItem.bind(this);
    this.getAllOfItems = this.getAllOfItems.bind(this);

    this.handleInputItemProposerAddress = this.handleInputItemProposerAddress.bind(this);
    this.handleInputItemName = this.handleInputItemName.bind(this);
    this.handleInputItemDescription = this.handleInputItemDescription.bind(this);
    this.handleInputItemPrice = this.handleInputItemPrice.bind(this);
    this.handleInputItemType = this.handleInputItemType.bind(this);

    this.handleInputStakeholderRegistry = this.handleInputStakeholderRegistry.bind(this);
  }

  getTestData = async () => {
      const { accounts, marketplace_registry, web3 } = this.state;

      let response = await marketplace_registry.methods.testFunc().send({ from: accounts[0] })
      console.log('=== response of testFunc() function ===', response);
  }


  handleInputItemProposerAddress({ target: { value } }) {
      this.setState({ valueOfItemProposerAddress: value });
  }

  handleInputItemName({ target: { value } }) {
      this.setState({ valueOfItemName: value });
  }

  handleInputItemDescription({ target: { value } }) {
      this.setState({ valueOfItemDescription: value });
  }

  handleInputItemPrice({ target: { value } }) {
      this.setState({ valueOfItemPrice: Number(value) });
  }

  handleInputItemType({ target: { value } }) {
      this.setState({ valueOfItemType: Number(value) });
  }

  mintTo = async () => {
      const { accounts, 
              nft_item, 
              web3, 
              valueOfItemProposerAddress, 
              valueOfItemName,
              valueOfItemDescription,
              valueOfItemPrice,
              valueOfItemType } = this.state;

      const _to = accounts[0];  //@dev - Current Login User

      //@dev - parameter below are for executing itemRegistry function
      const _itemOwnerAddr = accounts[0]   //@notice - _itemOwnerAddr is equal to _stakeholderAddr
      const _itemName = valueOfItemName;
      const _itemDescription = valueOfItemDescription;
      const _itemPrice = valueOfItemPrice;
      const _itemType = valueOfItemType;

      let response = await nft_item.methods.mintTo(_to, 
                                                   _itemOwnerAddr, 
                                                   _itemName,
                                                   _itemDescription, 
                                                   _itemPrice, 
                                                   _itemType).send({ from: accounts[0] });
      console.log('=== response of _mintTo() function ===', response);

      var itemId = response.events.Transfer.returnValues.tokenId;
      console.log('=== itemId of event of _mintTo() function ===', itemId);

      this.setState({ valueOfItemProposerAddress: '',
                      valueOfItemName: '', 
                      valueOfItemDescription: '',
                      valueOfItemPrice: '',
                      valueOfItemType: '' });
  }

  itemOwnerOf = async () => {
      const { accounts, marketplace_registry, web3 } = this.state;
      const _itemId = 1;

      let response = await marketplace_registry.methods.itemOwnerOf(_itemId).call();
      console.log('=== response of itemOwnerOf() function ===', response);
  } 

  itemTransferFrom = async () => {
      const { accounts, marketplace_registry, web3 } = this.state;

      const _oldOwner = accounts[0];
      const _newOwner = walletAddressList.addressList.address1;
      const _itemId = 1;

      let response = await marketplace_registry.methods.itemTransferFrom(_oldOwner, _newOwner, _itemId).send({ from: accounts[0] });
      console.log('=== response of itemTransferFrom() function ===', response);      
  }


  ownershipTransferOrderedItem = async () => {
      const { accounts, marketplace_registry, web3 } = this.state;
      const _itemId = 1;
      const _newOwner = walletAddressList.addressList.address1;

      let response = await marketplace_registry.methods.ownershipTransferOrderedItem(_itemId, _newOwner).send({ from: accounts[0] })
      console.log('=== response of ownershipTransferOrderedItem() function ===', response);
  }

  buyItem = async (_itemId) => {
      const { accounts, marketplace_registry, web3 } = this.state;
      //const _itemId = 1  
      const _buyer = accounts[0];  //@dev - Current User's wallet address
      //const _buyer = walletAddressList.addressList.address1;

      let response = await marketplace_registry.methods.buyItem(_itemId, _buyer).send({ from: accounts[0] })
      console.log('=== response of buyItem() function ===', response);
  }


  handleInputStakeholderRegistry({ target: { value } }) {
      this.setState({ valueOfStakeholderRegistry: Number(value) });
  }

  stakeholderRegistry = async () => {
      const { accounts, marketplace_registry, web3, valueOfStakeholderRegistry } = this.state;

      const _itemId = valueOfStakeholderRegistry;
      //const _itemId = 2;
      const _stakeholderAddr = accounts[0];
      const _stakeholderType = 0;

      //@dev - parameter below are for executing itemRegistry function
      const _itemName = 'Sample Item';
      const _itemPrice = 5;
      const _itemType = 0;

      let response = await marketplace_registry.methods.stakeholderRegistry(_itemId, 
                                                                            _stakeholderAddr, 
                                                                            _stakeholderType,
                                                                            //_itemName,
                                                                            //_itemPrice,
                                                                            //_itemType
                                                                            ).send({ from: accounts[0] });
      console.log('=== response of stakeholderRegistry() function ===', response);

      this.setState({ valueOfStakeholderRegistry: '' });
  }

  getStakeholdersGroup = async () => {
      const { accounts, marketplace_registry, web3 } = this.state;
      const _itemId = 1;

      let response = await marketplace_registry.methods.getStakeholdersGroup(_itemId).call();
      console.log('=== response of getStakeholdersGroup() function ===', response);      
  }

  getItem = async () => {
      const { accounts, nft_item, web3 } = this.state;
      const _itemId = 1;

      let response = await nft_item.methods.getItem(_itemId).call();
      console.log('=== response of getItem() function ===', response);
  }

  getAllOfItems = async () => {
      const { accounts, nft_item, web3 } = this.state;

      const currentItemIdCount = await nft_item.methods.getCurrentItemIdCount().call();
      console.log('=== currentItemIdCount ===', currentItemIdCount);

      //@dev - itemId is started from 1. That's why variable of "i" is also started from 1.
      //const itemIds = []
      const itemObjects = []
      for (let i = 1; i < currentItemIdCount; i++) {
          let response = await nft_item.methods.getItem(i).call();
          console.log('=== response of getAllOfItems ===', response);
          itemObjects.push(response);

          //itemIds.push(i);
      }

      //@dev - For displaying panels each itemId
      // const listItems = itemIds.map((itemId) =>
      //   <li>{itemId}</li>
      // );
      // this.setState({ listItems: listItems });

      const listItemObjects = itemObjects.map((itemObject) =>
          <Card width={"auto"} 
                    maxWidth={"640px"} 
                    mx={"auto"} 
                    my={5} 
                    p={20} 
                    borderColor={"#E8E8E8"}
          >
              <Table>
                  <tr>
                      <td>itemId: </td>
                      <td>{ itemObject.itemId }</td>
                  </tr>
                  <tr>
                      <td>itemName: </td>                           
                      <td>{ itemObject.itemName }</td>
                  </tr>
                  <tr>                    
                      <td>itemOwnerAddr: </td>
                      <td>{ itemObject.itemOwnerAddr }</td>
                  </tr>
                  <tr>                    
                      <td>itemPrice: </td>
                      <td>{ itemObject.itemPrice }</td>
                  </tr>
                  <tr>                    
                      <td>itemProposerAddr: </td>
                      <td>{ itemObject.itemProposerAddr }</td>
                  </tr>
                  <tr>                    
                      <td>itemType: </td>
                      <td>{ itemObject.itemType }</td>
                  </tr>
              </Table>

              <Button size={'small'} mt={3} mb={2} onClick={() => this.buyItem(itemObject.itemId)}> Buy Item </Button> <br />
          </Card>
      );
      this.setState({ listItemObjects: listItemObjects });
  }


  //////////////////////////////////// 
  ///// Refresh Values
  ////////////////////////////////////
  refreshValues = (instanceMarketplaceRegistry, instanceNftTicket) => {
    if (instanceMarketplaceRegistry) {
      console.log('refreshValues of instanceMarketplaceRegistry');
    }
    if (instanceNftTicket) {
      console.log('refreshValues of instanceNftTicket');
    }
  }


  //////////////////////////////////// 
  ///// Ganache
  ////////////////////////////////////
  getGanacheAddresses = async () => {
    if (!this.ganacheProvider) {
      this.ganacheProvider = getGanacheWeb3();
    }
    if (this.ganacheProvider) {
      return await this.ganacheProvider.eth.getAccounts();
    }
    return [];
  }

  componentDidMount = async () => {
    const hotLoaderDisabled = zeppelinSolidityHotLoaderOptions.disabled;
 
    let MarketplaceRegistry = {};
    let NftItem = {};
    try {
      MarketplaceRegistry = require("../../../../build/contracts/MarketplaceRegistry.json");  // Load artifact-file of MarketplaceRegistry
      NftItem = require("../../../../build/contracts/NftItem.json");

    } catch (e) {
      console.log(e);
    }

    try {
      const isProd = process.env.NODE_ENV === 'production';
      if (!isProd) {
        // Get network provider and web3 instance.
        const web3 = await getWeb3();
        let ganacheAccounts = [];

        try {
          ganacheAccounts = await this.getGanacheAddresses();
        } catch (e) {
          console.log('Ganache is not running');
        }

        // Use web3 to get the user's accounts.
        const accounts = await web3.eth.getAccounts();
        // Get the contract instance.
        const networkId = await web3.eth.net.getId();
        const networkType = await web3.eth.net.getNetworkType();
        const isMetaMask = web3.currentProvider.isMetaMask;
        let balance = accounts.length > 0 ? await web3.eth.getBalance(accounts[0]): web3.utils.toWei('0');
        balance = web3.utils.fromWei(balance, 'ether');

        let instanceMarketplaceRegistry = null;
        let instanceNftItem = null;
        let deployedNetwork = null;

        // Create instance of contracts
        if (MarketplaceRegistry.networks) {
          deployedNetwork = MarketplaceRegistry.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceMarketplaceRegistry = new web3.eth.Contract(
              MarketplaceRegistry.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceMarketplaceRegistry ===', instanceMarketplaceRegistry);
          }
        }

        if (NftItem.networks) {
          deployedNetwork = NftItem.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceNftItem = new web3.eth.Contract(
              NftItem.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceNftItem ===', instanceNftItem);
          }
        }

        if (MarketplaceRegistry, NftItem) {
          // Set web3, accounts, and contract to the state, and then proceed with an
          // example of interacting with the contract's methods.
          this.setState({ 
            web3, 
            ganacheAccounts, 
            accounts, 
            balance, 
            networkId, 
            networkType, 
            hotLoaderDisabled,
            isMetaMask, 
            marketplace_registry: instanceMarketplaceRegistry,
            nft_item: instanceNftItem
          }, () => {
            this.refreshValues(
              instanceMarketplaceRegistry
            );
            setInterval(() => {
              this.refreshValues(instanceMarketplaceRegistry, instanceNftItem);
            }, 5000);
          });

          //@dev - Call all of struct of Item every time
          this.getAllOfItems();
        }
        else {
          this.setState({ web3, ganacheAccounts, accounts, balance, networkId, networkType, hotLoaderDisabled, isMetaMask });
        }
      }
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  }



  render() {
      const { listItems, listItemObjects, accounts } = this.state;

      return (
          <div className={styles.widgets}>
              <Grid container style={{ marginTop: 32 }}>
                  <Grid item xs={12}>
                      <h4>Item Marketplace Registry</h4>

                      <Card width={"auto"} 
                            maxWidth={"800px"} 
                            mx={"auto"} 
                            my={5} 
                            p={20} 
                            borderColor={"#E8E8E8"}
                      >
                          <Table>
                              <tr>
                                  <td><p>Item Proposer Address（Current Login Address）</p></td>
                                  <td><Input type="text" placeholder="Please input item proposer address here" value={this.state.valueOfItemProposerAddress} onChange={this.handleInputItemProposerAddress} /></td>
                              </tr>
                              <tr>
                                  <td><p>Item Name</p></td>
                                  <td><Input type="text" placeholder="Please input item name here" value={this.state.valueOfItemName} onChange={this.handleInputItemName} /></td>
                              </tr>
                              <tr>
                                  <td><p>Item Description</p></td>
                                  <td><Input type="text" placeholder="Please input item description here" value={this.state.valueOfItemDescription} onChange={this.handleInputItemDescription} /></td>
                              </tr>
                              <tr>
                                  <td><p>Item Price</p></td>
                                  <td><Input type="text" placeholder="Please input item price here" value={this.state.valueOfItemPrice} onChange={this.handleInputItemPrice} /></td>
                              </tr>
                              <tr>
                                  <td><p>Item Type</p></td>
                                  <td><Input type="text" placeholder="Please input item type here" value={this.state.valueOfItemType} onChange={this.handleInputItemType} /></td>
                              </tr>
                          </Table>

                          <Button size={'small'} mt={3} mb={2} onClick={this.mintTo}> ① Publish NFT Item（Mint To） </Button>
                      </Card>

                      <Card width={"auto"} 
                            maxWidth={"800px"} 
                            mx={"auto"} 
                            my={5} 
                            p={20} 
                            borderColor={"#E8E8E8"}
                      >
                          <Table>
                              <tr>
                                  <td><p>Stakeholder Registry</p></td>
                                  <td><Input type="text" placeholder="Please input itemId here" value={this.state.valueOfStakeholderRegistry} onChange={this.handleInputStakeholderRegistry} /></td>
                                  <td><Button size={'small'} mt={3} mb={2} onClick={this.stakeholderRegistry}> ② Stakeholder Registry </Button></td>
                              </tr>
                          </Table>
                      </Card>
                  </Grid>

                  <Grid item xs={4}>
                  </Grid>

                  <Grid item xs={4}>
                  </Grid>
              </Grid>

              <hr />

              <Grid container style={{ marginTop: 32 }}>
                  <Grid item xs={12}>
                      <h4>List of Items</h4>

                      <h4> { listItemObjects }</h4>
                  </Grid>

                  <Grid item xs={4}>
                  </Grid>

                  <Grid item xs={4}>
                  </Grid>
              </Grid>

          </div>
      );
  }

}
