// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IPermissionProvider} from '../interfaces/IPermissionProvider.sol';

/// @title Dummy "implementation" contract for LG Diamond interface for ERC-1967 compatibility
/// @dev adapted from https://github.com/zdenham/diamond-etherscan?tab=readme-ov-file
/// @dev This interface is used internally to call endpoints on a deployed diamond cluster.
contract DelegatePermissionsFacetFragment {
    function resetDelegatePermissions() external {}

    function getIndexForDelegatePermission(IPermissionProvider.Permission permission) external pure returns (uint256) {}

    function getRawDelegatePermissions(address owner) external view returns (uint256) {}

    function setDelegatePermissionsRaw(uint256 permissionsRaw) external {}

    function checkDelegatePermission(
        address owner,
        IPermissionProvider.Permission permission
    ) external view returns (bool) {}

    function checkDelegatePermissions(
        address owner,
        IPermissionProvider.Permission[] calldata permissions
    ) external view returns (bool) {}

    function requireDelegatePermission(address owner, IPermissionProvider.Permission permission) external view {}

    function requireDelegatePermissions(
        address owner,
        IPermissionProvider.Permission[] calldata permissions
    ) external view {}

    function setDelegatePermission(IPermissionProvider.Permission permission, bool state) external {}

    function setDelegatePermissions(
        IPermissionProvider.Permission[] calldata permissions,
        bool[] calldata states
    ) external {}

    //  Equivalent to calling setDelegate() and setDelegatePermissions()
    function setDelegateAndPermissions(
        address delegate,
        IPermissionProvider.Permission[] calldata permissions,
        bool[] calldata states
    ) external {}

    //  Equivalent to calling setDelegate() and setDelegatePermissionsRaw()
    function setDelegateAndPermissionsRaw(address delegate, uint256 permissionsRaw) external {}
}
