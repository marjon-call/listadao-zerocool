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
		'developer_note: "132 in-scope contracts compiled via per-contract Foundry profiles (5 distinct solc versions). Each contract lives under src/<Name>_<addr4>/ with verified-source bytes pulled directly from BscScan/Etherscan. Use FOUNDRY_PROFILE=contract_<Name>_<addr4> forge build to compile a single contract."' \
		'blocking_error: ""' \
		> $(NEXUS_RESULT)
	@echo "Wrote $(NEXUS_RESULT)"

clean:
	rm -f $(NEXUS_RESULT)
	rm -rf out/ cache/
