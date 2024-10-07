// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {LibDelegatePermissions} from '../libraries/LibDelegatePermissions.sol';
import {IPermissionProvider} from '../interfaces/IPermissionProvider.sol';
import {LibDelegate} from '../libraries/LibDelegate.sol';

contract DelegatePermissionsFacet {
    function resetDelegatePermissions() external {
        LibDelegatePermissions.resetDelegatePermissions(msg.sender);
    }

    function getIndexForDelegatePermission(IPermissionProvider.Permission permission) external pure returns (uint256) {
        return LibDelegatePermissions.getIndexForDelegatePermission(permission);
    }

    function getRawDelegatePermissions(address owner) external view returns (uint256) {
        return LibDelegatePermissions.getRawDelegatePermissions(owner);
    }

    function setDelegatePermissionsRaw(uint256 permissionsRaw) external {
        LibDelegatePermissions.setDelegatePermissionsRaw(permissionsRaw);
    }

    function checkDelegatePermission(
        address owner,
        IPermissionProvider.Permission permission
    ) external view returns (bool) {
        return LibDelegatePermissions.checkDelegatePermission(owner, permission);
    }

    function checkDelegatePermissions(
        address owner,
        IPermissionProvider.Permission[] calldata permissions
    ) external view returns (bool) {
        return LibDelegatePermissions.checkDelegatePermissions(owner, permissions);
    }

    function requireDelegatePermission(address owner, IPermissionProvider.Permission permission) external view {
        require(
            LibDelegatePermissions.checkDelegatePermission(owner, permission),
            'PermissionsFacet: delegate does not have requested permission.'
        );
    }

    function requireDelegatePermissions(
        address owner,
        IPermissionProvider.Permission[] calldata permissions
    ) external view {
        require(
            LibDelegatePermissions.checkDelegatePermissions(owner, permissions),
            'PermissionsFacet: delegate does not have all the requested permissions.'
        );
    }

    function setDelegatePermission(IPermissionProvider.Permission permission, bool state) external {
        LibDelegatePermissions.setDelegatePermission(permission, state);
    }

    function setDelegatePermissions(
        IPermissionProvider.Permission[] calldata permissions,
        bool[] calldata states
    ) external {
        require(permissions.length == states.length, 'PermissionsFacet: array lengths must match.');
        LibDelegatePermissions.setDelegatePermissions(permissions, states);
    }

    //  Equivalent to calling setDelegate() and setDelegatePermissions()
    function setDelegateAndPermissions(
        address delegate,
        IPermissionProvider.Permission[] calldata permissions,
        bool[] calldata states
    ) external {
        require(permissions.length == states.length, 'PermissionsFacet: array lengths must match.');
        LibDelegate.setDelegate(delegate);
        LibDelegatePermissions.setDelegatePermissions(permissions, states);
    }

    //  Equivalent to calling setDelegate() and setDelegatePermissionsRaw()
    function setDelegateAndPermissionsRaw(address delegate, uint256 permissionsRaw) external {
        LibDelegate.setDelegate(delegate);
        LibDelegatePermissions.setDelegatePermissionsRaw(permissionsRaw);
    }
}
