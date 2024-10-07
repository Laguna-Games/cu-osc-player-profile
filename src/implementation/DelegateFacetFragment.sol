// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Dummy "implementation" contract for LG Diamond interface for ERC-1967 compatibility
/// @dev adapted from https://github.com/zdenham/diamond-etherscan?tab=readme-ov-file
/// @dev This interface is used internally to call endpoints on a deployed diamond cluster.
contract DelegateFacetFragment {
    function setDelegate(address delegate) external {}

    function revokeDelegate() external {}

    function abandonDelegation() external {}

    function getDelegate(address delegator) external view returns (address) {}

    function getDelegator(address delegate) external view returns (address) {}
}
