// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "@source/ClutchWallet.sol";
import "@source/SoulWalletFactory.sol";
import "./SoulWalletLogicInstence.sol";
import "@source/dev/SingletonFactory.sol";
import "@account-abstraction/contracts/core/EntryPoint.sol";
import "forge-std/Test.sol";

contract SoulWalletInstence {
    SoulWalletLogicInstence public clutchWalletLogicInstence;
    SoulWalletFactory public clutchWalletFactory;
    SingletonFactory public singletonFactory;
    ISoulWallet public clutchWallet;
    EntryPoint public entryPoint;

    constructor(
        address defaultCallbackHandler,
        address ownerAddr,
        bytes[] memory modules,
        bytes[] memory plugins,
        bytes32 salt
    ) {
        entryPoint = new EntryPoint();
        singletonFactory = new SingletonFactory();
        clutchWalletLogicInstence = new SoulWalletLogicInstence(entryPoint);
        clutchWalletFactory = new SoulWalletFactory(
            address(clutchWalletLogicInstence.clutchWalletLogic()),
            address(entryPoint),
            address(this)
        );

        /*
        address anOwner,
        address defalutCallbackHandler,
        Module[] calldata modules,
        Plugin[] calldata plugins
         */
        bytes memory initializer = abi.encodeWithSignature(
            "initialize(address,address,bytes[],bytes[])",
            ownerAddr,
            defaultCallbackHandler,
            modules,
            plugins
        );
        address walletAddress1 = clutchWalletFactory.getWalletAddress(
            initializer,
            salt
        );
        address walletAddress2 = clutchWalletFactory.createWallet(
            initializer,
            salt
        );
        require(
            walletAddress1 == walletAddress2,
            "walletAddress1 != walletAddress2"
        );
        require(walletAddress2.code.length > 0, "wallet code is empty");
        // walletAddress1 as ClutchWallet
        clutchWallet = ISoulWallet(walletAddress1);
    }
}
