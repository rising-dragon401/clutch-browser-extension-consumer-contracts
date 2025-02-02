// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../base/ClutchWalletInstence.sol";
import "@source/dev/Tokens/TokenERC20.sol";

contract DeployDirectTest is Test {
    function setUp() public {}

    function test_Deploy() public {
        bytes[] memory modules = new bytes[](0);
        bytes[] memory plugins = new bytes[](0);
        bytes32 salt = bytes32(0);
        ClutchWalletInstence clutchWalletInstence = new ClutchWalletInstence(
            address(0),
            address(this),
            modules,
            plugins,
            salt
        );
        IClutchWallet clutchWallet = clutchWalletInstence.clutchWallet();
        assertEq(clutchWallet.isOwner(address(this)), true);
        assertEq(clutchWallet.isOwner(address(0x1111)), false);

        TokenERC20 token = new TokenERC20(18);

        vm.startPrank(address(clutchWalletInstence.entryPoint()));
        // execute(address dest, uint256 value, bytes calldata func)
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        clutchWallet.execute(
            address(token),
            0,
            abi.encodeWithSignature(
                "transfer(address,uint256)",
                address(0x1),
                1
            )
        );
        vm.stopPrank();
    }
}
