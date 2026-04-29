# Lista DAO Security Review — ListaOFT (slisBNB)

Source originally extracted by Immunefi Instascope; refactored to mirror upstream
[`lista-dao/lista-token`](https://github.com/lista-dao/lista-token).

## Target

| | |
|---|---|
| Contract | `ListaOFT` (slisBNB cross-chain mint/burn) |
| Address | `0xf9B24C9364457Ea85792179D285855753549eBAa` |
| Chain | **Ethereum mainnet** (eid `30101`) |
| Counterparty | `ListaOFTAdapter` `0x837CB07f6B8a98731856092457524FF37b25E7B3` on BSC (eid `30102`) |
| LZ V2 endpoint | `0x1a44076050125825900e736c501f859c50fE728c` |
| Owner / delegate | `0x8d388136d578dCD791D081c6042284CED6d9B0c6` |
| MultiSig (pause) | `0xEEfebb1546d88EA0909435DF6f615084DD3c5Bd8` |
| Proxy? | No — direct deployment (ERC1967 impl slot is zero) |

> The Instascope export labeled this address as on BSC; that was wrong.
> `0xf9B24C9...eBAa` is on Ethereum mainnet. On BSC that same address holds
> an unrelated `SnBnbYieldConverterStrategy`.

## Layout

```
src/contracts/oft/{ListaOFT,TransferLimiter,PausableAlt}.sol
src/contracts/interfaces/IERC2612.sol
lib/instascope-vendor/@openzeppelin/...    # frozen at deployed bytecode
lib/instascope-vendor/@layerzerolabs/...   # frozen at deployed bytecode
lib/forge-std/                             # test framework
test/PoC.t.sol                             # PoC scaffold (fork-validated)
foundry.toml + remappings.txt
```

## Building & testing

```bash
forge build
export MAINNET_RPC_URL=<your-eth-mainnet-rpc>
forge test --match-contract PoCTest -vvv
```

The PoC template forks Ethereum mainnet via `MAINNET_RPC_URL` and exposes
`oft` (ListaOFT) and `lzEndpoint` (LayerZero V2) for researchers to use.
