// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {LibMetadata} from "../libraries/LibMetadata.sol";
import {LibContractOwner} from "../../lib/cu-osc-diamond-template/src/libraries/LibContractOwner.sol";

contract MetadataFacet {
    function setWalletHandle(string calldata handle) external {
        LibMetadata.setWalletHandle(handle);
    }

    function setWalletTokenURI(string calldata tokenURI) external {
        LibMetadata.setWalletTokenURI(tokenURI);
    }

    function deleteWalletHandle() external {
        LibMetadata.deleteWalletHandle();
    }

    function deleteWalletTokenURI() external {
        LibMetadata.deleteWalletTokenURI();
    }

    function walletHandle(
        address wallet
    ) external view returns (string memory handle) {
        handle = LibMetadata.walletHandle(wallet);
    }

    function walletTokenURI(
        address wallet
    ) external view returns (string memory tokenURI) {
        tokenURI = LibMetadata.walletTokenURI(wallet);
    }

    function walletMetadata(
        address wallet
    ) external view returns (string memory handle, string memory tokenURI) {
        (handle, tokenURI) = LibMetadata.walletMetadata(wallet);
    }
}
