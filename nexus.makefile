.PHONY: build clean

NEXUS_RESULT := nexus_build_result.yaml

build: $(NEXUS_RESULT)

$(NEXUS_RESULT):
	@if [ -f "$(NEXUS_RESULT)" ]; then \
		echo "$(NEXUS_RESULT) already exists, skipping build"; \
		exit 0; \
	fi
	git submodule update --init --recursive
	forge build
	@printf '%s\n' \
		'language: solidity' \
		'build_targets:' \
		'  - .' \
		'installation_script: "git submodule update --init --recursive && forge build"' \
		'run_test_command: "forge test"' \
		'developer_note: ""' \
		'blocking_error: ""' \
		> $(NEXUS_RESULT)
	@echo "Wrote $(NEXUS_RESULT)"

clean:
	rm -f $(NEXUS_RESULT)
	forge clean
