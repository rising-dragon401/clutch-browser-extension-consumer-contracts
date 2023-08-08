// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "@source/ClutchWallet.sol";
import "@account-abstraction/contracts/core/EntryPoint.sol";
import "@source/modules/SecurityControlModule/SecurityControlModule.sol";
import "@source/trustedContractManager/trustedModuleManager/TrustedModuleManager.sol";
import "@source/trustedContractManager/trustedPluginManager/TrustedPluginManager.sol";

contract SoulWalletLogicInstence {
    ClutchWallet public clutchWalletLogic;

    constructor(EntryPoint _entryPoint) {
        clutchWalletLogic = new ClutchWallet(_entryPoint);
    }
}
