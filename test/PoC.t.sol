// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

// =====================================================================
// Inline interfaces for the most common interactions across the Lista
// DAO scope. Defined inline so this test compiles standalone; do NOT
// import from src/<...>/contracts — every in-scope contract has its
// own Foundry profile and cross-profile imports break.
// =====================================================================

interface IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// PausableUpgradeable / OwnableUpgradeable — share these across every Lista admin contract.
interface IOwnable {
    function owner() external view returns (address);
    function transferOwnership(address newOwner) external;
}

interface IPausable {
    function paused() external view returns (bool);
    function pause() external;
    function unpause() external;
}

// --- CDP (Hay/Maker fork) -----------------------------------------------------

// Vat is the central accounting contract — the source of truth for all CDP debt + collateral.
interface IVat {
    function live() external view returns (uint256);
    function debt() external view returns (uint256);
    function vice() external view returns (uint256);
    function Line() external view returns (uint256);
    function ilks(bytes32 ilk)
        external
        view
        returns (
            uint256 Art,    // total normalised debt
            uint256 rate,   // accumulated rates
            uint256 spot,   // price with safety margin
            uint256 line,   // debt ceiling
            uint256 dust    // urn debt floor
        );
    function urns(bytes32 ilk, address user)
        external
        view
        returns (uint256 ink, uint256 art);
    function gem(bytes32 ilk, address user) external view returns (uint256);
    function dai(address user) external view returns (uint256);
    function sin(address user) external view returns (uint256);
    function can(address bit, address usr) external view returns (uint256);
}

// Top-level user entrypoint for deposit/borrow/repay/withdraw.
interface IInteraction {
    function deposit(address user, address token, uint256 dink) external returns (uint256);
    function withdraw(address user, address token, uint256 dink) external returns (uint256);
    function borrow(address token, uint256 amount) external returns (uint256);
    function payback(address token, uint256 amount) external returns (int256);
    function locked(address token, address user) external view returns (uint256);
    function borrowed(address token, address user) external view returns (uint256);
    function collateralRate(address token) external view returns (uint256);
    // CollateralType: { GemJoinLike gem; bytes32 ilk; uint32 live; address clip; }
    function collaterals(address token)
        external
        view
        returns (address gem, bytes32 ilk, uint32 live, address clip);
}

interface ISpotter {
    function ilks(bytes32 ilk) external view returns (address pip, uint256 mat);
    function par() external view returns (uint256);
    function poke(bytes32 ilk) external;
}

interface IJug {
    function base() external view returns (uint256);
    function ilks(bytes32 ilk) external view returns (uint256 duty, uint256 rho);
    function drip(bytes32 ilk) external returns (uint256 rate);
}

interface IDog {
    function live() external view returns (uint256);
    function vat() external view returns (address);
    function vow() external view returns (address);
    function ilks(bytes32 ilk)
        external
        view
        returns (address clip, uint256 chop, uint256 hole, uint256 dirt);
}

// Peg stability + lending-yield router for lisUSD.
interface ILisUSDPoolSet {
    function totalAssets() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function pools(uint256 i) external view returns (address);
}

interface IEarnPool {
    function lisUSDPool() external view returns (address);
    function provider() external view returns (address);
}

// --- Liquid staking (slisBNB / clisBNB) --------------------------------------

interface IListaStakeManager {
    function totalSnBnbToBurn() external view returns (uint256);
    function totalDelegated() external view returns (uint256);
    function amountToDelegate() external view returns (uint256);
    function nextUndelegateUUID() external view returns (uint256);
    function reservedFunds() external view returns (uint256);
    function minDelegateThreshold() external view returns (uint256);
    function minUndelegateThreshold() external view returns (uint256);
    function bnbX() external view returns (address);
    function snBnb() external view returns (address);
    function feeBps() external view returns (uint256);
    function deposit() external payable;
    function getSlisBnbWithdrawLimit() external view returns (uint256);
    function convertSnBnbToBnb(uint256 _amountInSlisBnb) external view returns (uint256);
    function convertBnbToSnBnb(uint256 _amount) external view returns (uint256);
}

// Lista MasterVault is a custom (non-ERC4626) vault. asset == address(0) means
// the underlying is native BNB; vaultToken is the share token (ceABNBc on the
// main BNB vault).
interface IMasterVault {
    function totalAssets() external view returns (uint256);
    function totalAssetInVault() external view returns (uint256);
    function asset() external view returns (address);
    function vaultToken() external view returns (address);
    function provider() external view returns (address);
    function strategies(uint256) external view returns (address);
    function feeReceiver() external view returns (address payable);
    function availableToWithdraw() external view returns (uint256);
    function balanceOfTokenFromStrategy(address strategy) external view returns (uint256);
}

interface IHelioProvider {
    function provide() external payable returns (uint256);
    function release(address recipient, uint256 amount) external returns (uint256);
    function _ceToken() external view returns (address);
    function _certToken() external view returns (address);
    function _collateralToken() external view returns (address);
    function _interaction() external view returns (address);
}

// --- Cross-chain bridge (LayerZero V2 OFT) -----------------------------------

interface IListaOFT {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function owner() external view returns (address);
    function paused() external view returns (bool);
    function multiSig() external view returns (address);
    function nonces(address) external view returns (uint256);
    function endpoint() external view returns (address);
    function peers(uint32 eid) external view returns (bytes32);
    function token() external view returns (address);
    function approvalRequired() external view returns (bool);
    function oftVersion() external view returns (bytes4 interfaceId, uint64 version);
    function decimalConversionRate() external view returns (uint256);
    function sharedDecimals() external view returns (uint8);
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
}

// Adapter is the lock/release variant; same surface as OFT, plus token() points at the wrapped asset.
interface IListaOFTAdapter {
    function owner() external view returns (address);
    function paused() external view returns (bool);
    function multiSig() external view returns (address);
    function endpoint() external view returns (address);
    function peers(uint32 eid) external view returns (bytes32);
    function token() external view returns (address);
    function approvalRequired() external view returns (bool);
    function oftVersion() external view returns (bytes4 interfaceId, uint64 version);
    function decimalConversionRate() external view returns (uint256);
    function sharedDecimals() external view returns (uint8);
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

// --- Oracles -----------------------------------------------------------------

interface ILisOracle {
    function peek() external view returns (bytes32 price, bool ok);
    function peekPrice() external view returns (uint256);
}

interface IResilientOracle {
    // Returns the USD price scaled to 18 decimals.
    function peek(address asset) external view returns (uint256);
    function getPriceFromOracle(address oracle, uint256 tolerance) external view returns (uint256);
}

// =====================================================================

contract PoCTest is Test {
    // ----- Fork management --------------------------------------------------
    // Lista DAO is overwhelmingly on BSC (131 of 132 in-scope contracts).
    // The cross-chain ListaOFT lives on Ethereum mainnet — switch via _useEthereumFork().

    uint256 internal bscFork;
    uint256 internal ethFork;
    bool internal bscForkInit;
    bool internal ethForkInit;

    /// Forks are created lazily so the empty test_PoC() can run in CI / scanner
    /// environments that haven't provisioned BSC_RPC_URL. Tests that need a
    /// fork should call _useBscFork() / _useEthereumFork() explicitly.
    function setUp() public {
        string memory bscUrl = vm.envOr("BSC_RPC_URL", string(""));
        if (bytes(bscUrl).length > 0) {
            bscFork = vm.createSelectFork(bscUrl);
            bscForkInit = true;
        }
    }

    function _useBscFork() internal {
        if (!bscForkInit) {
            bscFork = vm.createFork(vm.envString("BSC_RPC_URL"));
            bscForkInit = true;
        }
        vm.selectFork(bscFork);
    }

    function _useEthereumFork() internal {
        if (!ethForkInit) {
            ethFork = vm.createFork(vm.envString("MAINNET_RPC_URL"));
            ethForkInit = true;
        }
        vm.selectFork(ethFork);
    }

    // ====================================================================
    // PROXY ADDRESSES (BSC) — use these in PoCs; state lives at the proxy.
    // ====================================================================

    // ---- CDP / lisUSD stack (Hay-style Maker fork) ----
    address constant LISUSD            = 0x0782b6d8c4551B9760e74c0545a9bCD90bdc41E5;
    address constant INTERACTION       = 0xB68443Ee3e828baD1526b3e0Bdf2Dfc6b1975ec4;
    address constant CE_TOKEN          = 0x563282106A5B0538f8673c787B3A16D3Cc1DbF1a; // ceABNBc
    address constant CLIS_BNB          = 0x4b30fcAA7945fE9fDEFD2895aae539ba102Ed6F6;
    address constant CE_VAULT_V2       = 0x25b21472c073095bebC681001Cbf165f849eEe5E;
    address constant CEROS_ROUTER      = 0xA186D2363E5048D129E0a35E2fddDe767d4dada8;
    address constant HELIO_PROVIDER_V2 = 0xa835F890Fcde7679e7F7711aBfd515d2A267Ed0B;
    address constant VAT               = 0x33A34eAB3ee892D40420507B820347b1cA2201c4;
    address constant SPOTTER           = 0x49bc2c4E5B035341b7d92Da4e6B267F7426F3038;
    address constant HAY_JOIN          = 0x4C798F81de7736620Cd8e6510158b1fE758e22F7;
    address constant JUG               = 0x787BdEaa29A253e40feB35026c3d05C18CbCA7B3;
    address constant DOG               = 0xd57E7b53a1572d27A04d9c1De2c4D423f1926d0B;
    address constant JAR               = 0x0a1Fd12F73432928C190CAF0810b3B767A59717e;
    address constant VOW               = 0x2078A1969Ea581D618FDBEa2C0Dc13Fc15CB9fa7;
    address constant PSM_USDT          = 0xaa57F36DD5Ef2aC471863ec46277f976f272eC0c;
    address constant VAULT_MANAGER_USDT = 0x5763DDeB60c82684F3D0098aEa5076C0Da972ec7;
    address constant VENUS_ADAPTER_USDT = 0xf76D9cFD08dF91491680313B1A5b44307129CDa9;
    address constant LISUSD_POOL_SET   = 0x37DB1AE9B24055D1F9fE973Aea40B7EB2995D0Bf;
    address constant EARN_POOL         = 0x66dE07893Db7492B56bA88503B4cC99bAb1796F3;

    // ---- Liquid staking (slisBNB / ListaStakeManager) ----
    address constant SLIS_BNB              = 0xB0b84D294e0C75A6abe60171b70edEb2EFd14A1B;
    address constant LISTA_STAKE_MANAGER   = 0x1adB950d8bB3dA4bE104211D5AB038628e477fE6;
    address constant MASTER_VAULT          = 0x986b40C2618fF295a49AC442c5ec40febB26CC54;
    address constant CEROS_YIELD_STRAT     = 0x00D8697D73216278de8f97BBEaE6ca90cf0a5CB0;
    address constant STK_BNB_STRAT         = 0x98CB81d921B8F5020983A46e96595471Ad4E60Be;
    address constant SNBNB_YIELD_STRAT     = 0x6F28FeC449dbd2056b76ac666350Af8773E03873;
    address constant BNBX_YIELD_STRAT      = 0x6ae7073d801a74eE753F19323DF320C8F5Fe2DbC;
    address constant SLIS_BNB_PROVIDER_FD31 = 0xfD31e1C5e5571f8E7FE318f80888C1e6da97819b;
    address constant SLIS_BNB_PROVIDER_33F7 = 0x33f7A980a246f9B8FEA2254E3065576E127D4D5f;
    address constant CE_ETH_VAULT          = 0xA230805C28121cc97B348f8209c79BEBEa3839C0;
    address constant HELIO_ETH_PROVIDER    = 0x0326c157bfF399e25dd684613aEF26DBb40D3BA4;
    address constant CEROS_ETH_ROUTER      = 0xA0cD5EAfa37EBA1d04Fb003512f962f2f73C3e86;

    // ---- Cross-chain bridge ----
    address constant LISTA_OFT_ADAPTER_BSC = 0x837CB07f6B8a98731856092457524FF37b25E7B3; // direct
    address constant LZ_ENDPOINT_V2_BSC    = 0x1a44076050125825900e736c501f859c50fE728c;
    uint32  constant EID_ETHEREUM = 30101;
    uint32  constant EID_BSC      = 30102;

    // ---- Lending (Moolah) ----
    address constant BNB_PROVIDER_LISTA_VAULT = 0x367384C54756a25340c63057D87eA22d47Fd5701;
    address constant BNB_PROVIDER_MEV_VAULT   = 0x501bE17CcA1d8a009753Da271D6714C18c1A35c9;
    address constant LENDING_REWARDS_DIST     = 0x665410ee5Ea96aa729589491bADC11E0FE163d29;
    address constant MBTC_PROVIDER            = 0x8A016f1896dC2939fFDbB60f6E42bCc245e2bB0b;

    // ---- Distributors / governance / staking ----
    address constant EMISSION_VOTING        = 0xFc136f286805A7922d9Bf04317068964b231336c;
    address constant VOTING_INCENTIVE       = 0x05AC03faeB31c8102A29Dc1Fa4365Dc9e18A4c9C;
    address constant VELISTA_AUTOCOMPOUNDER = 0x9a0530A81c83D3b0daE720BF91C9254FECC3BF5E;
    address constant VELISTA_INTEREST_REBATE = 0xda1E93d58CCCC9683f9Cb051cAEC5CF2F01B3253;
    address constant VELISTA_REVENUE_DIST   = 0xE4153Eb04417bE05b8d6B2222E4Cdd8AE674ee76;
    address constant PANCAKE_STAKING        = 0xE31f0BcE1F825A8e27f2Cc30B54af19DA2978f10;
    address constant THENA_STAKING          = 0xFA5B482882F9e025facCcE558c2F72c6c50AC719;
    address constant PANCAKE_VAULT          = 0x62DfeC5C9518fE2e0ba483833d1BAD94ecF68153;
    address constant THENA_VAULT            = 0xF40D0d497966fe198765877484FFf08c2D2004ad;
    address constant LP_PROXY               = 0x5A0E3291514F5F1797A0C7eFefdac81eeC70ec01;
    address constant ERC20_LP_TOKEN_PROVIDER = 0x2725d7336027773D7a958E10819A923dcd65aA57;

    // ---- Oracles ----
    address constant RESILIENT_ORACLE = 0xf3afD82A4071f272F403dC176916141f44E6c750;
    address constant BNB_ORACLE       = 0xf81748d12171De989A5Bbf2d76bf10BFbBaEC596;
    address constant ETH_ORACLE       = 0x9945e33Be177b5FCcB90710FEe59C548Cac8ACbA;
    address constant SLISBNB_ORACLE   = 0x8eCf78fB59E5A4C26CB218D34dB29c4696Af89f6;
    address constant SNBNB_ORACLE     = 0x25787055964a8D2A0DE4387D6ec9EbC0Dc139DD5;
    address constant BTC_ORACLE       = 0x2eeDc4723b1ED2f24afCD9c0e3665061bD2D5642;
    address constant USDT_ORACLE      = 0xF19dc2B8AcD55aa4e80583DE3943260FA3a26A72;

    // ====================================================================
    // DIRECT ADDRESSES (BSC) — not behind a proxy.
    // ====================================================================
    address constant AUCTION_PROXY = 0x272d6589CEcC19165cfCd0466f73A648cb1Ea700;

    // ====================================================================
    // PROXY ADDRESSES (Ethereum) — use _useEthereumFork() before reading.
    // ====================================================================
    address constant LISTA_OFT_ETH      = 0xf9B24C9364457Ea85792179D285855753549eBAa; // direct
    address constant LZ_ENDPOINT_V2_ETH = 0x1a44076050125825900e736c501f859c50fE728c;

    // ====================================================================
    // External tokens (BSC)
    // ====================================================================
    address constant WBNB  = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address constant USDT  = 0x55d398326f99059fF775485246999027B3197955;
    address constant USDC  = 0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d;
    address constant BTCB  = 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c;
    address constant ETH   = 0x2170Ed0880ac9A755fd29B2688956BD959F933F8;
    address constant FDUSD = 0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409;
    address constant LISTA_TOKEN = 0xFceB31A79F71AC9CBDCF853519c1b12D379EdC46;
    address constant WBETH = 0xa2E3356610840701BDf5611a53974510Ae27E2e1;
    address constant EZETH = 0x2416092f143378750bb29b79eD961ab195CcEea5;
    address constant WEETH = 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A;

    // ====================================================================
    // Convenience casts
    // ====================================================================
    IListaStakeManager constant stakeManager = IListaStakeManager(LISTA_STAKE_MANAGER);
    IVat              constant vat          = IVat(VAT);
    IInteraction      constant interaction  = IInteraction(INTERACTION);
    IListaOFTAdapter  constant oftAdapter   = IListaOFTAdapter(LISTA_OFT_ADAPTER_BSC);
    IListaOFT         constant oftEth       = IListaOFT(LISTA_OFT_ETH);
    ILayerZeroEndpointV2 constant lzBsc     = ILayerZeroEndpointV2(LZ_ENDPOINT_V2_BSC);
    ILayerZeroEndpointV2 constant lzEth     = ILayerZeroEndpointV2(LZ_ENDPOINT_V2_ETH);

    function test_PoC() public {
        // Researcher: write your exploit here.
    }
}
