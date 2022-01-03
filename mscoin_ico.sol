// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract mscoin_ico {

    // Introducing the total number of mscoins available for sale 
    uint public max_ms_coins = 1000000; 

    // Conversion rate from usd to mscoin
    uint public usd_to_mscoin = 1000; 

    // Total number of mscoins bought
    uint public total_ico_bought = 0; 

    // Mapping from the investor address to its equity in mscoins and USD
    mapping (address => uint ) equity_mscoins;
    mapping (address => uint ) equity_usd;

    // Checking an investor can buy mscoins
    modifier can_buy_mscoin (uint usd_invested){
        require(usd_invested * usd_to_mscoin + total_ico_bought <= max_ms_coins);
        _;
    }

    // Getting the equity in mscoins of an investor
    function equity_in_mscoin(address investor) external view returns (uint){
       return equity_mscoins[investor];
    }

    // Getting the equity in usd of an investor 
    function equity_in_usd(address investor) external view returns (uint){
        return equity_usd[investor];
    }

    // Buying mscoins
    function buy_mscoins(address investor , uint usd_invested) external 
    can_buy_mscoin(usd_invested){
        uint mscoins_bougth=usd_invested*usd_to_mscoin;
        equity_mscoins[investor] +=mscoins_bougth;
        equity_usd[investor] = equity_mscoins[investor] / 1000;
        total_ico_bought += mscoins_bougth;
    }

    // Selling mscoins
    function sell_mscoins(address investor , uint mscoins_sold) external {
        equity_mscoins[investor] -= mscoins_sold;
        equity_usd[investor] = equity_mscoins[investor] / 1000;
        total_ico_bought -= mscoins_sold;
    }

    

}
