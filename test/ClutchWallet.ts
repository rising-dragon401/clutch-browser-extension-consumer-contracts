import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { ClutchWalletLib, Data } from "clutch_wallet_lib";

const log_on = false;
const log = (message?: any, ...optionalParams: any[]) => { if (log_on) console.log(message, ...optionalParams) };

describe("ClutchWalletContract", function () {

    it("should deploy", async function () {
        // let a = ClutchWalletLib.new();
        // let b = a.constants.address.entrypoint_address;
        let x = ClutchWalletLib.constants();
        console.log(x.address.entrypoint_address);
    });

    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    // async function deployFixture() {

    //     // get accounts
    //     const accounts = await ethers.getSigners();

    //     // create EOA account
    //     const EOA = await ethers.Wallet.createRandom();
    //     await accounts[0].sendTransaction({ to: EOA.address, value: ethers.utils.parseEther("10") });

    //     // new account
    //     const walletOwner = await ethers.Wallet.createRandom();

    //     let chainId = await (await ethers.provider.getNetwork()).chainId;
    //     log("chainId:", chainId);

    //     // #region SingletonFactory 

    //     let SingletonFactory: string = SoulWalletLib.Defines.SingletonFactoryAddress;
    //     let code = await ethers.provider.getCode(SingletonFactory);
    //     if (code === '0x') {
    //         SingletonFactory = (await (await ethers.getContractFactory("SingletonFactory")).deploy()).address;
    //         code = await ethers.provider.getCode(SingletonFactory);
    //         expect(code).to.not.equal('0x');
    //     }
    //     const clutchWalletLib = new SoulWalletLib(SingletonFactory);

    //     // #endregion

    //     // #region ClutchWalletLogic
    //     const ClutchWalletLogic = {
    //         contract: await (await ethers.getContractFactory("ClutchWallet")).deploy()
    //     };
    //     log("ClutchWalletLogic:", ClutchWalletLogic.contract.address);
    //     // get ClutchWalletLogic contract code
    //     const ClutchWalletLogicCode = await ethers.provider.getCode(ClutchWalletLogic.contract.address);

    //     // calculate ClutchWalletLogic contract code hash
    //     const ClutchWalletLogicCodeHash = ethers.utils.keccak256(ClutchWalletLogicCode);
    //     log("ClutchWalletLogicCodeHash:", ClutchWalletLogicCodeHash);
    //     // #endregion

    //     // #region EntryPoint  
    //     const EntryPoint = {
    //         contract: await (await ethers.getContractFactory("EntryPoint")).deploy()
    //     };
    //     log("EntryPoint:", EntryPoint.contract.address);
    //     // #endregion

    //     // #region USDC
    //     const USDC = {
    //         contract: await (await ethers.getContractFactory("USDCoin")).deploy()
    //     };
    //     log("USDC:", USDC.contract.address);

    //     // #endregion
    //     const MockOracle = {
    //         contract: await (await ethers.getContractFactory("MockOracle")).deploy()
    //     };

    //     // #region PriceOracle
    //     const PriceOracle = {
    //         contract: await (await ethers.getContractFactory("PriceOracle")).deploy(MockOracle.contract.address)
    //     };
    //     // #endregion


    //     // #region wallet factory
    //     const _walletFactoryAddress = await clutchWalletLib.Utils.deployFactory.deploy(ClutchWalletLogic.contract.address, ethers.provider, accounts[0]);

    //     const WalletFactory = {
    //         contract: await ethers.getContractAt("ClutchWalletFactory", _walletFactoryAddress)
    //     };
    //     log("ClutchWalletFactory:", WalletFactory.contract.address);


    //     // #endregion

    //     const bundler = new clutchWalletLib.Bundler(EntryPoint.contract.address, ethers.provider, EOA.privateKey);
    //     await bundler.init();


    //     // #region TokenPaymaster
    //     const TokenPaymaster = {
    //         contract: await (await ethers.getContractFactory("TokenPaymaster")).deploy(
    //             EntryPoint.contract.address,
    //             accounts[0].address,
    //             WalletFactory.contract.address
    //         )
    //     };
    //     await TokenPaymaster.contract.setToken(
    //         [USDC.contract.address],
    //         [PriceOracle.contract.address, PriceOracle.contract.address]);

    //     const _paymasterStake = '' + Math.pow(10, 17);
    //     await TokenPaymaster.contract.addStake(
    //         1, {
    //         from: accounts[0].address,
    //         value: _paymasterStake
    //     });
    //     await TokenPaymaster.contract.deposit({
    //         from: accounts[0].address,
    //         value: _paymasterStake
    //     });
    //     log("TokenPaymaster:", TokenPaymaster.contract.address);

    //     // #endregion TokenPaymaster

    //     // #region guardian logic

    //     const GuardianLogic = {
    //         contract: await (await ethers.getContractFactory("GuardianMultiSigWallet")).deploy()
    //     }
    //     log("GuardianLogic:", GuardianLogic.contract.address);

    //     // #endregion


    //     // #region estimate gas helper

    //     const EstimateGasHelper = {
    //         contract: await (await ethers.getContractFactory("EstimateGasHelper")).deploy()
    //     }
    //     log("EstimateGasHelper:", EstimateGasHelper.contract.address);

    //     // #endregion

    //     // #region SignatureTest
    //     const SignatureTest = {
    //         contract: await (await ethers.getContractFactory("SignatureTest")).deploy()
    //     }
    //     // #endregion


    //     return {
    //         clutchWalletLib,
    //         bundler,
    //         chainId,
    //         accounts,
    //         walletOwner,
    //         SingletonFactory,
    //         ClutchWalletLogic,
    //         EntryPoint,
    //         USDC,
    //         TokenPaymaster,
    //         GuardianLogic,
    //         PriceOracle,
    //         WalletFactory,
    //         EstimateGasHelper,
    //         SignatureTest
    //     };
    // }

});    