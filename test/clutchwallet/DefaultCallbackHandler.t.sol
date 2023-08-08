// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "./base/SoulWalletInstence.sol";
import "@source/handler/DefaultCallbackHandler.sol";
import "@source/dev/Tokens/TokenERC721.sol";

contract DefaultCallbackHandlerTest is Test {
    SoulWalletInstence public clutchWalletInstence;
    DefaultCallbackHandler public defaultCallbackHandler;
    ISoulWallet public clutchWallet;
    TokenERC721 tokenERC721;

    function setUp() public {
        (address ownerAddr, ) = makeAddrAndKey("owner1");
        bytes[] memory modules = new bytes[](0);
        bytes[] memory plugins = new bytes[](0);
        bytes32 salt = bytes32(0);
        defaultCallbackHandler = new DefaultCallbackHandler();
        clutchWalletInstence = new SoulWalletInstence(
            address(defaultCallbackHandler),
            ownerAddr,
            modules,
            plugins,
            salt
        );
        clutchWallet = clutchWalletInstence.clutchWallet();
        tokenERC721 = new TokenERC721();
    }

    function test_defaultCallbackHandler() public {
        (bool success, bytes memory returnData) = address(
            defaultCallbackHandler
        ).staticcall(
                abi.encodeWithSignature(
                    "onERC721Received(address,address,uint256,bytes)",
                    address(this),
                    address(this),
                    1,
                    ""
                )
            );
        assertEq(success, true);
        assertEq(
            abi.decode(returnData, (bytes4)),
            bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))
        );
    }

    function test_onERC721Received() public {
        (bool success, bytes memory returnData) = address(clutchWallet)
            .staticcall(
                abi.encodeWithSignature(
                    "onERC721Received(address,address,uint256,bytes)",
                    address(this),
                    address(this),
                    1,
                    ""
                )
            );
        assertEq(success, true);
        assertEq(
            abi.decode(returnData, (bytes4)),
            bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))
        );
    }

    function test_transferERC721() public {
        tokenERC721.safeMint(address(clutchWallet), 1);
        assertEq(tokenERC721.ownerOf(1), address(clutchWallet));
        vm.expectRevert(
            bytes("ERC721: transfer to non ERC721Receiver implementer")
        );
        tokenERC721.safeMint(address(this), 2);
    }
}
