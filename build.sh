#!/bin/bash
# Generated. Builds each in-scope contract under its own Foundry profile.
set +e
echo "Building 132 contracts individually..."
echo ""
OK=0; FAIL=0; FAILED=()
echo "[$((OK+FAIL+1))/132] AsUsdfOracle_53c7"
FOUNDRY_PROFILE=contract_AsUsdfOracle_53c7 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("AsUsdfOracle_53c7"); }
echo "[$((OK+FAIL+1))/132] AuctionProxy_272d"
FOUNDRY_PROFILE=contract_AuctionProxy_272d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("AuctionProxy_272d"); }
echo "[$((OK+FAIL+1))/132] BBtcOracle_2ea1"
FOUNDRY_PROFILE=contract_BBtcOracle_2ea1 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BBtcOracle_2ea1"); }
echo "[$((OK+FAIL+1))/132] BNBProvider_3673"
FOUNDRY_PROFILE=contract_BNBProvider_3673 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BNBProvider_3673"); }
echo "[$((OK+FAIL+1))/132] BNBProvider_501b"
FOUNDRY_PROFILE=contract_BNBProvider_501b forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BNBProvider_501b"); }
echo "[$((OK+FAIL+1))/132] BnbOracle_f817"
FOUNDRY_PROFILE=contract_BnbOracle_f817 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BnbOracle_f817"); }
echo "[$((OK+FAIL+1))/132] BnbxYieldConverterStrategy_6ae7"
FOUNDRY_PROFILE=contract_BnbxYieldConverterStrategy_6ae7 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BnbxYieldConverterStrategy_6ae7"); }
echo "[$((OK+FAIL+1))/132] BorrowListaDistributor_031a"
FOUNDRY_PROFILE=contract_BorrowListaDistributor_031a forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BorrowListaDistributor_031a"); }
echo "[$((OK+FAIL+1))/132] BorrowListaDistributor_5f43"
FOUNDRY_PROFILE=contract_BorrowListaDistributor_5f43 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BorrowListaDistributor_5f43"); }
echo "[$((OK+FAIL+1))/132] BorrowListaDistributor_982d"
FOUNDRY_PROFILE=contract_BorrowListaDistributor_982d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BorrowListaDistributor_982d"); }
echo "[$((OK+FAIL+1))/132] BorrowListaDistributor_a3bc"
FOUNDRY_PROFILE=contract_BorrowListaDistributor_a3bc forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BorrowListaDistributor_a3bc"); }
echo "[$((OK+FAIL+1))/132] BorrowListaDistributor_f8d1"
FOUNDRY_PROFILE=contract_BorrowListaDistributor_f8d1 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BorrowListaDistributor_f8d1"); }
echo "[$((OK+FAIL+1))/132] BtcOracle_2eed"
FOUNDRY_PROFILE=contract_BtcOracle_2eed forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("BtcOracle_2eed"); }
echo "[$((OK+FAIL+1))/132] CeETHVault_a230"
FOUNDRY_PROFILE=contract_CeETHVault_a230 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CeETHVault_a230"); }
echo "[$((OK+FAIL+1))/132] CeToken_4510"
FOUNDRY_PROFILE=contract_CeToken_4510 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CeToken_4510"); }
echo "[$((OK+FAIL+1))/132] CeToken_5632"
FOUNDRY_PROFILE=contract_CeToken_5632 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CeToken_5632"); }
echo "[$((OK+FAIL+1))/132] CeToken_6c81"
FOUNDRY_PROFILE=contract_CeToken_6c81 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CeToken_6c81"); }
echo "[$((OK+FAIL+1))/132] CeToken_b0af"
FOUNDRY_PROFILE=contract_CeToken_b0af forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CeToken_b0af"); }
echo "[$((OK+FAIL+1))/132] CeVaultV2_25b2"
FOUNDRY_PROFILE=contract_CeVaultV2_25b2 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CeVaultV2_25b2"); }
echo "[$((OK+FAIL+1))/132] CerosETHRouter_a0cd"
FOUNDRY_PROFILE=contract_CerosETHRouter_a0cd forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CerosETHRouter_a0cd"); }
echo "[$((OK+FAIL+1))/132] CerosRouter_a186"
FOUNDRY_PROFILE=contract_CerosRouter_a186 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CerosRouter_a186"); }
echo "[$((OK+FAIL+1))/132] CerosYieldConverterStrategy_00d8"
FOUNDRY_PROFILE=contract_CerosYieldConverterStrategy_00d8 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CerosYieldConverterStrategy_00d8"); }
echo "[$((OK+FAIL+1))/132] Clipper_2dcf"
FOUNDRY_PROFILE=contract_Clipper_2dcf forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_2dcf"); }
echo "[$((OK+FAIL+1))/132] Clipper_334e"
FOUNDRY_PROFILE=contract_Clipper_334e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_334e"); }
echo "[$((OK+FAIL+1))/132] Clipper_4192"
FOUNDRY_PROFILE=contract_Clipper_4192 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_4192"); }
echo "[$((OK+FAIL+1))/132] Clipper_5784"
FOUNDRY_PROFILE=contract_Clipper_5784 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_5784"); }
echo "[$((OK+FAIL+1))/132] Clipper_5aab"
FOUNDRY_PROFILE=contract_Clipper_5aab forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_5aab"); }
echo "[$((OK+FAIL+1))/132] Clipper_6339"
FOUNDRY_PROFILE=contract_Clipper_6339 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_6339"); }
echo "[$((OK+FAIL+1))/132] Clipper_96b6"
FOUNDRY_PROFILE=contract_Clipper_96b6 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_96b6"); }
echo "[$((OK+FAIL+1))/132] Clipper_af71"
FOUNDRY_PROFILE=contract_Clipper_af71 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_af71"); }
echo "[$((OK+FAIL+1))/132] Clipper_b12f"
FOUNDRY_PROFILE=contract_Clipper_b12f forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_b12f"); }
echo "[$((OK+FAIL+1))/132] Clipper_ba92"
FOUNDRY_PROFILE=contract_Clipper_ba92 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_ba92"); }
echo "[$((OK+FAIL+1))/132] Clipper_c485"
FOUNDRY_PROFILE=contract_Clipper_c485 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_c485"); }
echo "[$((OK+FAIL+1))/132] Clipper_deb9"
FOUNDRY_PROFILE=contract_Clipper_deb9 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_deb9"); }
echo "[$((OK+FAIL+1))/132] Clipper_df9c"
FOUNDRY_PROFILE=contract_Clipper_df9c forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_df9c"); }
echo "[$((OK+FAIL+1))/132] Clipper_e7e8"
FOUNDRY_PROFILE=contract_Clipper_e7e8 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_e7e8"); }
echo "[$((OK+FAIL+1))/132] Clipper_eb99"
FOUNDRY_PROFILE=contract_Clipper_eb99 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_eb99"); }
echo "[$((OK+FAIL+1))/132] Clipper_f21b"
FOUNDRY_PROFILE=contract_Clipper_f21b forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_f21b"); }
echo "[$((OK+FAIL+1))/132] Clipper_f57a"
FOUNDRY_PROFILE=contract_Clipper_f57a forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_f57a"); }
echo "[$((OK+FAIL+1))/132] Clipper_f920"
FOUNDRY_PROFILE=contract_Clipper_f920 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Clipper_f920"); }
echo "[$((OK+FAIL+1))/132] ClisToken_88a5"
FOUNDRY_PROFILE=contract_ClisToken_88a5 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ClisToken_88a5"); }
echo "[$((OK+FAIL+1))/132] CollateralListaDistributor_5662"
FOUNDRY_PROFILE=contract_CollateralListaDistributor_5662 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CollateralListaDistributor_5662"); }
echo "[$((OK+FAIL+1))/132] CollateralListaDistributor_b1da"
FOUNDRY_PROFILE=contract_CollateralListaDistributor_b1da forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CollateralListaDistributor_b1da"); }
echo "[$((OK+FAIL+1))/132] CollateralListaDistributor_d603"
FOUNDRY_PROFILE=contract_CollateralListaDistributor_d603 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CollateralListaDistributor_d603"); }
echo "[$((OK+FAIL+1))/132] CollateralListaDistributor_e61f"
FOUNDRY_PROFILE=contract_CollateralListaDistributor_e61f forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CollateralListaDistributor_e61f"); }
echo "[$((OK+FAIL+1))/132] CollateralListaDistributor_e786"
FOUNDRY_PROFILE=contract_CollateralListaDistributor_e786 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CollateralListaDistributor_e786"); }
echo "[$((OK+FAIL+1))/132] CollateralListaDistributor_f533"
FOUNDRY_PROFILE=contract_CollateralListaDistributor_f533 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("CollateralListaDistributor_f533"); }
echo "[$((OK+FAIL+1))/132] Dog_d57e"
FOUNDRY_PROFILE=contract_Dog_d57e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Dog_d57e"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_11bf"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_11bf forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_11bf"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_1cf9"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_1cf9 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_1cf9"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_39d0"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_39d0 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_39d0"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_4b2d"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_4b2d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_4b2d"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_9b4f"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_9b4f forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_9b4f"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_9f6c"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_9f6c forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_9f6c"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_c23d"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_c23d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_c23d"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_e8f4"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_e8f4 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_e8f4"); }
echo "[$((OK+FAIL+1))/132] ERC20LpListaDistributor_f6ab"
FOUNDRY_PROFILE=contract_ERC20LpListaDistributor_f6ab forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpListaDistributor_f6ab"); }
echo "[$((OK+FAIL+1))/132] ERC20LpTokenProvider_2725"
FOUNDRY_PROFILE=contract_ERC20LpTokenProvider_2725 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ERC20LpTokenProvider_2725"); }
echo "[$((OK+FAIL+1))/132] EarnPool_66de"
FOUNDRY_PROFILE=contract_EarnPool_66de forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("EarnPool_66de"); }
echo "[$((OK+FAIL+1))/132] EmissionVoting_fc13"
FOUNDRY_PROFILE=contract_EmissionVoting_fc13 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("EmissionVoting_fc13"); }
echo "[$((OK+FAIL+1))/132] EthOracle_9945"
FOUNDRY_PROFILE=contract_EthOracle_9945 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("EthOracle_9945"); }
echo "[$((OK+FAIL+1))/132] EzEthOracle_e859"
FOUNDRY_PROFILE=contract_EzEthOracle_e859 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("EzEthOracle_e859"); }
echo "[$((OK+FAIL+1))/132] FlashBuy_9ba8"
FOUNDRY_PROFILE=contract_FlashBuy_9ba8 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("FlashBuy_9ba8"); }
echo "[$((OK+FAIL+1))/132] GemJoin_03db"
FOUNDRY_PROFILE=contract_GemJoin_03db forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_03db"); }
echo "[$((OK+FAIL+1))/132] GemJoin_157c"
FOUNDRY_PROFILE=contract_GemJoin_157c forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_157c"); }
echo "[$((OK+FAIL+1))/132] GemJoin_2367"
FOUNDRY_PROFILE=contract_GemJoin_2367 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_2367"); }
echo "[$((OK+FAIL+1))/132] GemJoin_3cd4"
FOUNDRY_PROFILE=contract_GemJoin_3cd4 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_3cd4"); }
echo "[$((OK+FAIL+1))/132] GemJoin_3f3e"
FOUNDRY_PROFILE=contract_GemJoin_3f3e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_3f3e"); }
echo "[$((OK+FAIL+1))/132] GemJoin_5aef"
FOUNDRY_PROFILE=contract_GemJoin_5aef forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_5aef"); }
echo "[$((OK+FAIL+1))/132] GemJoin_6053"
FOUNDRY_PROFILE=contract_GemJoin_6053 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_6053"); }
echo "[$((OK+FAIL+1))/132] GemJoin_68b9"
FOUNDRY_PROFILE=contract_GemJoin_68b9 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_68b9"); }
echo "[$((OK+FAIL+1))/132] GemJoin_876c"
FOUNDRY_PROFILE=contract_GemJoin_876c forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_876c"); }
echo "[$((OK+FAIL+1))/132] GemJoin_8b35"
FOUNDRY_PROFILE=contract_GemJoin_8b35 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_8b35"); }
echo "[$((OK+FAIL+1))/132] GemJoin_91e4"
FOUNDRY_PROFILE=contract_GemJoin_91e4 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_91e4"); }
echo "[$((OK+FAIL+1))/132] GemJoin_98b1"
FOUNDRY_PROFILE=contract_GemJoin_98b1 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_98b1"); }
echo "[$((OK+FAIL+1))/132] GemJoin_a94a"
FOUNDRY_PROFILE=contract_GemJoin_a94a forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_a94a"); }
echo "[$((OK+FAIL+1))/132] GemJoin_ad9e"
FOUNDRY_PROFILE=contract_GemJoin_ad9e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_ad9e"); }
echo "[$((OK+FAIL+1))/132] GemJoin_b53e"
FOUNDRY_PROFILE=contract_GemJoin_b53e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_b53e"); }
echo "[$((OK+FAIL+1))/132] GemJoin_d7e3"
FOUNDRY_PROFILE=contract_GemJoin_d7e3 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_d7e3"); }
echo "[$((OK+FAIL+1))/132] GemJoin_f45c"
FOUNDRY_PROFILE=contract_GemJoin_f45c forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_f45c"); }
echo "[$((OK+FAIL+1))/132] GemJoin_fa14"
FOUNDRY_PROFILE=contract_GemJoin_fa14 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("GemJoin_fa14"); }
echo "[$((OK+FAIL+1))/132] HayJoin_4c79"
FOUNDRY_PROFILE=contract_HayJoin_4c79 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("HayJoin_4c79"); }
echo "[$((OK+FAIL+1))/132] HelioETHProvider_0326"
FOUNDRY_PROFILE=contract_HelioETHProvider_0326 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("HelioETHProvider_0326"); }
echo "[$((OK+FAIL+1))/132] HelioProviderV2_a835"
FOUNDRY_PROFILE=contract_HelioProviderV2_a835 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("HelioProviderV2_a835"); }
echo "[$((OK+FAIL+1))/132] Interaction_b684"
FOUNDRY_PROFILE=contract_Interaction_b684 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Interaction_b684"); }
echo "[$((OK+FAIL+1))/132] Jar_0a1f"
FOUNDRY_PROFILE=contract_Jar_0a1f forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Jar_0a1f"); }
echo "[$((OK+FAIL+1))/132] Jug_787b"
FOUNDRY_PROFILE=contract_Jug_787b forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Jug_787b"); }
echo "[$((OK+FAIL+1))/132] LendingRewardsDistributor_6654"
FOUNDRY_PROFILE=contract_LendingRewardsDistributor_6654 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("LendingRewardsDistributor_6654"); }
echo "[$((OK+FAIL+1))/132] LinearDecrease_c135"
FOUNDRY_PROFILE=contract_LinearDecrease_c135 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("LinearDecrease_c135"); }
echo "[$((OK+FAIL+1))/132] LisUSDPoolSet_37db"
FOUNDRY_PROFILE=contract_LisUSDPoolSet_37db forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("LisUSDPoolSet_37db"); }
echo "[$((OK+FAIL+1))/132] LisUSD_0782"
FOUNDRY_PROFILE=contract_LisUSD_0782 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("LisUSD_0782"); }
echo "[$((OK+FAIL+1))/132] ListaOFTAdapter_837c"
FOUNDRY_PROFILE=contract_ListaOFTAdapter_837c forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ListaOFTAdapter_837c"); }
echo "[$((OK+FAIL+1))/132] ListaOFT_f9b2"
FOUNDRY_PROFILE=contract_ListaOFT_f9b2 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ListaOFT_f9b2"); }
echo "[$((OK+FAIL+1))/132] ListaStakeManager_1adb"
FOUNDRY_PROFILE=contract_ListaStakeManager_1adb forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ListaStakeManager_1adb"); }
echo "[$((OK+FAIL+1))/132] LpProxy_5a0e"
FOUNDRY_PROFILE=contract_LpProxy_5a0e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("LpProxy_5a0e"); }
echo "[$((OK+FAIL+1))/132] MasterVault_986b"
FOUNDRY_PROFILE=contract_MasterVault_986b forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("MasterVault_986b"); }
echo "[$((OK+FAIL+1))/132] PSM_aa57"
FOUNDRY_PROFILE=contract_PSM_aa57 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("PSM_aa57"); }
echo "[$((OK+FAIL+1))/132] PancakeStaking_e31f"
FOUNDRY_PROFILE=contract_PancakeStaking_e31f forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("PancakeStaking_e31f"); }
echo "[$((OK+FAIL+1))/132] ResilientOracle_f3af"
FOUNDRY_PROFILE=contract_ResilientOracle_f3af forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ResilientOracle_f3af"); }
echo "[$((OK+FAIL+1))/132] SLisBNB_b0b8"
FOUNDRY_PROFILE=contract_SLisBNB_b0b8 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SLisBNB_b0b8"); }
echo "[$((OK+FAIL+1))/132] SlisBNBProvider_33f7"
FOUNDRY_PROFILE=contract_SlisBNBProvider_33f7 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SlisBNBProvider_33f7"); }
echo "[$((OK+FAIL+1))/132] SlisBNBProvider_fd31"
FOUNDRY_PROFILE=contract_SlisBNBProvider_fd31 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SlisBNBProvider_fd31"); }
echo "[$((OK+FAIL+1))/132] SlisBnbOracle_8ecf"
FOUNDRY_PROFILE=contract_SlisBnbOracle_8ecf forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SlisBnbOracle_8ecf"); }
echo "[$((OK+FAIL+1))/132] SnBNBOracle_2578"
FOUNDRY_PROFILE=contract_SnBNBOracle_2578 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SnBNBOracle_2578"); }
echo "[$((OK+FAIL+1))/132] SnBnbYieldConverterStrategy_6f28"
FOUNDRY_PROFILE=contract_SnBnbYieldConverterStrategy_6f28 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SnBnbYieldConverterStrategy_6f28"); }
echo "[$((OK+FAIL+1))/132] SolvBtcOracle_b7a7"
FOUNDRY_PROFILE=contract_SolvBtcOracle_b7a7 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("SolvBtcOracle_b7a7"); }
echo "[$((OK+FAIL+1))/132] Spotter_49bc"
FOUNDRY_PROFILE=contract_Spotter_49bc forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Spotter_49bc"); }
echo "[$((OK+FAIL+1))/132] StakeLisUSDListaDistributor_f2fa"
FOUNDRY_PROFILE=contract_StakeLisUSDListaDistributor_f2fa forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("StakeLisUSDListaDistributor_f2fa"); }
echo "[$((OK+FAIL+1))/132] StakingVault_62df"
FOUNDRY_PROFILE=contract_StakingVault_62df forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("StakingVault_62df"); }
echo "[$((OK+FAIL+1))/132] StakingVault_f40d"
FOUNDRY_PROFILE=contract_StakingVault_f40d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("StakingVault_f40d"); }
echo "[$((OK+FAIL+1))/132] StkBnbStrategy_98cb"
FOUNDRY_PROFILE=contract_StkBnbStrategy_98cb forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("StkBnbStrategy_98cb"); }
echo "[$((OK+FAIL+1))/132] StoneOracle_df5a"
FOUNDRY_PROFILE=contract_StoneOracle_df5a forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("StoneOracle_df5a"); }
echo "[$((OK+FAIL+1))/132] ThenaERC20LpProvidableListaDistributor_ff5e"
FOUNDRY_PROFILE=contract_ThenaERC20LpProvidableListaDistributor_ff5e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ThenaERC20LpProvidableListaDistributor_ff5e"); }
echo "[$((OK+FAIL+1))/132] ThenaStaking_fa5b"
FOUNDRY_PROFILE=contract_ThenaStaking_fa5b forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("ThenaStaking_fa5b"); }
echo "[$((OK+FAIL+1))/132] Usd1Oracle_d111"
FOUNDRY_PROFILE=contract_Usd1Oracle_d111 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Usd1Oracle_d111"); }
echo "[$((OK+FAIL+1))/132] UsdfOracle_a53a"
FOUNDRY_PROFILE=contract_UsdfOracle_a53a forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("UsdfOracle_a53a"); }
echo "[$((OK+FAIL+1))/132] UsdtOracle_f19d"
FOUNDRY_PROFILE=contract_UsdtOracle_f19d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("UsdtOracle_f19d"); }
echo "[$((OK+FAIL+1))/132] Vat_33a3"
FOUNDRY_PROFILE=contract_Vat_33a3 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Vat_33a3"); }
echo "[$((OK+FAIL+1))/132] VaultManager_5763"
FOUNDRY_PROFILE=contract_VaultManager_5763 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("VaultManager_5763"); }
echo "[$((OK+FAIL+1))/132] VeListaAutoCompounder_9a05"
FOUNDRY_PROFILE=contract_VeListaAutoCompounder_9a05 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("VeListaAutoCompounder_9a05"); }
echo "[$((OK+FAIL+1))/132] VeListaInterestRebater_da1e"
FOUNDRY_PROFILE=contract_VeListaInterestRebater_da1e forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("VeListaInterestRebater_da1e"); }
echo "[$((OK+FAIL+1))/132] VeListaRevenueDistributor_e415"
FOUNDRY_PROFILE=contract_VeListaRevenueDistributor_e415 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("VeListaRevenueDistributor_e415"); }
echo "[$((OK+FAIL+1))/132] VenusAdapter_f76d"
FOUNDRY_PROFILE=contract_VenusAdapter_f76d forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("VenusAdapter_f76d"); }
echo "[$((OK+FAIL+1))/132] VotingIncentive_05ac"
FOUNDRY_PROFILE=contract_VotingIncentive_05ac forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("VotingIncentive_05ac"); }
echo "[$((OK+FAIL+1))/132] Vow_2078"
FOUNDRY_PROFILE=contract_Vow_2078 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("Vow_2078"); }
echo "[$((OK+FAIL+1))/132] WeEthOracle_e514"
FOUNDRY_PROFILE=contract_WeEthOracle_e514 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("WeEthOracle_e514"); }
echo "[$((OK+FAIL+1))/132] mBTCOracle_31d5"
FOUNDRY_PROFILE=contract_mBTCOracle_31d5 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("mBTCOracle_31d5"); }
echo "[$((OK+FAIL+1))/132] mBTCProvider_8a01"
FOUNDRY_PROFILE=contract_mBTCProvider_8a01 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("mBTCProvider_8a01"); }
echo "[$((OK+FAIL+1))/132] mCAKEOracle_01b3"
FOUNDRY_PROFILE=contract_mCAKEOracle_01b3 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("mCAKEOracle_01b3"); }
echo "[$((OK+FAIL+1))/132] mwBETHOracle_aa49"
FOUNDRY_PROFILE=contract_mwBETHOracle_aa49 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("mwBETHOracle_aa49"); }
echo "[$((OK+FAIL+1))/132] slisBNBx_4b30"
FOUNDRY_PROFILE=contract_slisBNBx_4b30 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("slisBNBx_4b30"); }
echo "[$((OK+FAIL+1))/132] xSolvBTCOracle_0ad7"
FOUNDRY_PROFILE=contract_xSolvBTCOracle_0ad7 forge build --silent && OK=$((OK+1)) || { FAIL=$((FAIL+1)); FAILED+=("xSolvBTCOracle_0ad7"); }
echo ""
echo "=== summary ==="
echo "ok=$OK fail=$FAIL total=$((OK+FAIL))"
if [ $FAIL -gt 0 ]; then
  echo "failed profiles:"
  printf "  %s\n" "${FAILED[@]}"
fi
exit $FAIL
