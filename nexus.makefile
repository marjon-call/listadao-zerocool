.PHONY: build clean

NEXUS_RESULT := nexus_build_result.yaml

build: $(NEXUS_RESULT)

$(NEXUS_RESULT):
	@if [ -f "$(NEXUS_RESULT)" ]; then \
		echo "$(NEXUS_RESULT) already exists, skipping build"; \
		exit 0; \
	fi
	git submodule update --init --recursive
	./build.sh
	@printf '%s\n' \
		'language: solidity' \
		'build_targets:' \
		'  - .' \
		'installation_script: "git submodule update --init --recursive && ./build.sh"' \
		'run_test_command: "forge test"' \
		'developer_note: "132 in-scope contracts (131 BSC + 1 Ethereum) compiled via per-contract Foundry profiles — 5 distinct solc versions. Each contract lives under src/<Name>_<addr4>/ with verified-source bytes pulled from BscScan/Etherscan. Use FOUNDRY_PROFILE=contract_<Name>_<addr4> forge build for a single contract. RPC URL ENVIRONMENT: test/PoC.t.sol creates forks lazily so the harness compiles and the empty test_PoC() passes without any RPC env var; researchers using the fork helpers must export BSC_RPC_URL (Lista is BSC-native, but BSC is not in the scanner standard list) and MAINNET_RPC_URL (for the cross-chain ListaOFT on Ethereum)."' \
		'blocking_error: ""' \
		> $(NEXUS_RESULT)
	@echo "Wrote $(NEXUS_RESULT)"

clean:
	rm -f $(NEXUS_RESULT)
	rm -rf out/ cache/
