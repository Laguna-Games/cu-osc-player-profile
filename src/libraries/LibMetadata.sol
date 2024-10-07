// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @custom:storage-location erc7201:games.laguna.LibMetadata
library LibMetadata {
    bytes32 constant METADATA_STORAGE_POSITION =
        keccak256(abi.encode(uint256(keccak256('games.laguna.LibMetadata')) - 1)) & ~bytes32(uint256(0xff));

    struct MetadataStorage {
        mapping(address => string) walletToHandle; //wallet => handle
        mapping(address => string) walletToTokenURI; //wallet => tokenURI
    }

    function metadataStorage() internal pure returns (MetadataStorage storage ms) {
        bytes32 position = METADATA_STORAGE_POSITION;
        assembly {
            ms.slot := position
        }
    }

    function setWalletHandle(string calldata handle) internal {
        metadataStorage().walletToHandle[msg.sender] = handle;
    }

    function deleteWalletHandle() internal {
        delete metadataStorage().walletToHandle[msg.sender];
    }

    function setWalletTokenURI(string calldata tokenURI) internal {
        metadataStorage().walletToTokenURI[msg.sender] = tokenURI;
    }

    function deleteWalletTokenURI() internal {
        delete metadataStorage().walletToTokenURI[msg.sender];
    }

    function walletHandle(address wallet) internal view returns (string memory) {
        return metadataStorage().walletToHandle[wallet];
    }

    function walletTokenURI(address wallet) internal view returns (string memory) {
        return metadataStorage().walletToTokenURI[wallet];
    }

    function walletMetadata(address wallet) internal view returns (string memory, string memory) {
        return (walletHandle(wallet), walletTokenURI(wallet));
    }

    function emptyString(string memory argument) private pure returns (bool) {
        return bytes(argument).length == 0;
    }
}
