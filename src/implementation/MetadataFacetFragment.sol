// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Dummy "implementation" contract for LG Diamond interface for ERC-1967 compatibility
/// @dev adapted from https://github.com/zdenham/diamond-etherscan?tab=readme-ov-file
/// @dev This interface is used internally to call endpoints on a deployed diamond cluster.
contract MetadataFacetFragment {

    function setWalletHandle(string calldata handle) external {}

    function setWalletTokenURI(string calldata tokenURI) external {}

    function deleteWalletHandle() external {}

    function deleteWalletTokenURI() external {}

    function walletHandle(address wallet) external view returns (string memory handle) {}

    function walletTokenURI(address wallet) external view returns (string memory tokenURI) {}

    function walletMetadata(address wallet) external view returns (string memory handle, string memory tokenURI) {}
}
