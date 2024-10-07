// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IPermissionProvider} from "../interfaces/IPermissionProvider.sol";
import {LibDelegate} from "../libraries/LibDelegate.sol";
import {LibBin} from "../../lib/cu-osc-common/src/libraries/LibBin.sol";

/// @custom:storage-location erc7201:games.laguna.LibDelegatePermissions
library LibDelegatePermissions {
    event PermissionsChanged(
        address indexed owner,
        address indexed delegate,
        uint256 oldPermissions,
        uint256 newPermissions
    );

    bytes32 constant PERMISSIONS_STORAGE_POSITION =
        keccak256(
            abi.encode(
                uint256(keccak256("games.laguna.LibDelegatePermissions")) - 1
            )
        ) & ~bytes32(uint256(0xff));

    struct DelegatePermissionsStorage {
        mapping(address => uint256) delegatorToPermissionsOnDelegates;
    }

    function delegatePermissionsStorage()
        internal
        pure
        returns (DelegatePermissionsStorage storage ps)
    {
        bytes32 position = PERMISSIONS_STORAGE_POSITION;
        assembly {
            ps.slot := position
        }
    }

    function getRawDelegatePermissions(
        address delegator
    ) internal view returns (uint256) {
        return
            delegatePermissionsStorage().delegatorToPermissionsOnDelegates[
                delegator
            ];
    }

    function setDelegatePermission(
        IPermissionProvider.Permission permission,
        bool state
    ) internal {
        uint256 currentDelegatePermissions = delegatePermissionsStorage()
            .delegatorToPermissionsOnDelegates[msg.sender];
        uint256 delegatePermissionToChange = getIndexForDelegatePermission(
            permission
        );
        uint256 result = LibBin.setBit(
            currentDelegatePermissions,
            delegatePermissionToChange,
            state
        );

        setDelegatePermissionsRaw(result);
    }

    function setDelegatePermissions(
        IPermissionProvider.Permission[] calldata permissions,
        bool[] calldata states
    ) internal {
        uint256 originalDelegatePermissions = delegatePermissionsStorage()
            .delegatorToPermissionsOnDelegates[msg.sender];
        uint256 result = originalDelegatePermissions;
        for (uint256 i = 0; i < permissions.length; i++) {
            uint256 permissionToChange = getIndexForDelegatePermission(
                permissions[i]
            );
            result = LibBin.setBit(result, permissionToChange, states[i]);
        }
        setDelegatePermissionsRaw(result);
    }

    function getIndexForDelegatePermission(
        IPermissionProvider.Permission permission
    ) internal pure returns (uint256) {
        return uint8(permission);
    }

    function setDelegatePermissionsRaw(
        uint256 delegatePermissionsRaw
    ) internal {
        uint256 currentDelegatePermissions = delegatePermissionsStorage()
            .delegatorToPermissionsOnDelegates[msg.sender];
        delegatePermissionsStorage().delegatorToPermissionsOnDelegates[
            msg.sender
        ] = delegatePermissionsRaw;
        address delegate = LibDelegate.getDelegate(msg.sender);
        emit PermissionsChanged(
            msg.sender,
            delegate,
            currentDelegatePermissions,
            delegatePermissionsRaw
        );
    }

    function checkDelegatePermission(
        address delegator,
        IPermissionProvider.Permission permission
    ) internal view returns (bool) {
        uint256 currentDelegatePermissions = delegatePermissionsStorage()
            .delegatorToPermissionsOnDelegates[delegator];
        return
            LibBin.getBit(
                currentDelegatePermissions,
                getIndexForDelegatePermission(permission)
            );
    }

    function checkDelegatePermissions(
        address delegator,
        IPermissionProvider.Permission[] calldata permissions
    ) internal view returns (bool) {
        uint256 currentDelegatePermissions = delegatePermissionsStorage()
            .delegatorToPermissionsOnDelegates[delegator];
        for (uint256 i = 0; i < permissions.length; i++) {
            if (
                !LibBin.getBit(
                    currentDelegatePermissions,
                    getIndexForDelegatePermission(permissions[i])
                )
            ) {
                return false;
            }
        }
        return true;
    }

    function resetDelegatePermissions(address delegator) internal {
        uint256 currentDelegatePermissions = delegatePermissionsStorage()
            .delegatorToPermissionsOnDelegates[delegator];
        delegatePermissionsStorage().delegatorToPermissionsOnDelegates[
            delegator
        ] = 0;
        address delegate = LibDelegate.getDelegate(delegator);
        emit PermissionsChanged(
            delegator,
            delegate,
            currentDelegatePermissions,
            0
        );
    }
}
