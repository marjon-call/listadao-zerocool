// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

// =====================================================================
// Minimal interfaces for in-scope and adjacent contracts.
// Defined inline so this test compiles without depending on the project
// remappings or per-contract Foundry profiles.
// =====================================================================

interface IListaOFT {
    // ----- ERC20 / ERC2612 -----
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function nonces(address owner) external view returns (uint256);
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
    function PERMIT_TYPE_HASH() external view returns (bytes32);
    function EIP712_VERSION() external view returns (string memory);
    function EIP712_DOMAIN() external view returns (bytes32);
    function updateDomainSeparator() external;

    // ----- Ownable / PausableAlt -----
    function owner() external view returns (address);
    function transferOwnership(address newOwner) external;
    function renounceOwnership() external;
    function paused() external view returns (bool);
    function pause() external;
    function unpause() external;
    function multiSig() external view returns (address);
    function setMultiSig(address _multiSig) external;

    // ----- TransferLimiter -----
    function transferLimitConfigs(uint32 dstEid)
        external
        view
        returns (
            uint32 dstEid_,
            uint256 maxDailyTransferAmount,
            uint256 singleTransferUpperLimit,
            uint256 singleTransferLowerLimit,
            uint256 dailyTransferAmountPerAddress,
            uint256 dailyTransferAttemptPerAddress
        );
    function dailyTransferAmount(uint32 dstEid) external view returns (uint256);
    function lastUpdatedTime(uint32 dstEid) external view returns (uint256);
    function userDailyTransferAmount(uint32 dstEid, address user) external view returns (uint256);
    function userDailyAttempt(uint32 dstEid, address user) external view returns (uint256);
    function lastUserUpdatedTime(uint32 dstEid, address user) external view returns (uint256);

    // ----- LayerZero V2 OAppCore / OFT -----
    function endpoint() external view returns (address);
    function peers(uint32 eid) external view returns (bytes32);
    function setPeer(uint32 eid, bytes32 peer) external;
    function setDelegate(address _delegate) external;
    function token() external view returns (address);
    function approvalRequired() external view returns (bool);
    function oftVersion() external view returns (bytes4 interfaceId, uint64 version);
    function decimalConversionRate() external view returns (uint256);
    function sharedDecimals() external view returns (uint8);
    function preCrime() external view returns (address);
    function enforcedOptions(uint32 eid, uint16 msgType) external view returns (bytes memory);
}

interface ILayerZeroEndpointV2 {
    function eid() external view returns (uint32);
    function delegates(address oapp) external view returns (address);
    function getSendLibrary(address sender, uint32 dstEid) external view returns (address);
    function getReceiveLibrary(address receiver, uint32 srcEid)
        external
        view
        returns (address lib, bool isDefault);
}

contract PoCTest is Test {
    // =================================================================
    // DIRECT ADDRESSES (not behind a proxy — verified via ERC1967 slot)
    // =================================================================

    // ListaOFT — slisBNB OFT on Ethereum mainnet (mint/burn side, eid 30101)
    address constant LISTA_OFT = 0xf9B24C9364457Ea85792179D285855753549eBAa;

    // LayerZero V2 endpoint on Ethereum mainnet
    address constant LZ_ENDPOINT_V2 = 0x1a44076050125825900e736c501f859c50fE728c;

    // Owner / delegator (set during deployment per slisBNBOftChains.json)
    address constant LISTA_OWNER = 0x8d388136d578dCD791D081c6042284CED6d9B0c6;

    // MultiSig that can pause()
    address constant LISTA_MULTISIG = 0xEEfebb1546d88EA0909435DF6f615084DD3c5Bd8;

    // =================================================================
    // CROSS-CHAIN PEERS (counterparties on other chains — for reference)
    // =================================================================

    // ListaOFTAdapter on BNB Smart Chain (lock/release side, eid 30102)
    // bytes32 form (peers() return value): 0x000...000837CB07f6B8a98731856092457524FF37b25E7B3
    address constant LISTA_OFT_ADAPTER_BSC = 0x837CB07f6B8a98731856092457524FF37b25E7B3;

    // BSC slisBNB token (the token that ListaOFTAdapter wraps over)
    address constant SLIS_BNB_BSC = 0xB0b84D294e0C75A6abe60171b70edEb2EFd14A1B;

    // LayerZero endpoint IDs
    uint32 constant EID_ETHEREUM = 30101;
    uint32 constant EID_BSC = 30102;

    IListaOFT constant oft = IListaOFT(LISTA_OFT);
    ILayerZeroEndpointV2 constant lzEndpoint = ILayerZeroEndpointV2(LZ_ENDPOINT_V2);

    function setUp() public {
        vm.createSelectFork(vm.envString("MAINNET_RPC_URL"));
    }

    function test_PoC() public {
        // Researcher: write your exploit here.
    }
}
