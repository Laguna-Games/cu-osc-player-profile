// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {LibDelegatePermissions} from './LibDelegatePermissions.sol';

/// @custom:storage-location erc7201:games.laguna.LibDelegate
library LibDelegate {
    event DelegateChanged(
        address indexed owner,
        address indexed oldDelegate,
        address indexed newDelegate,
        uint256 permissions
    );

    bytes32 constant DELEGATE_STORAGE_POSITION =
        keccak256(abi.encode(uint256(keccak256('games.laguna.LibDelegate')) - 1)) & ~bytes32(uint256(0xff));

    struct DelegateStorage {
        mapping(address delegator => address delegate) delegatorToDelegate;
        mapping(address delegate => address delegator) delegateToDelegator;
    }

    function delegateStorage() internal pure returns (DelegateStorage storage ds) {
        bytes32 position = DELEGATE_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    function setDelegate(address delegate) internal {
        DelegateStorage storage ds = delegateStorage();

        if (ds.delegateToDelegator[delegate] != address(0)) {
            require(
                ds.delegateToDelegator[delegate] == msg.sender,
                'LibDelegate: Delegate already assigned to someone else.'
            );
        }
        address previousDelegate = ds.delegatorToDelegate[msg.sender];
        ds.delegatorToDelegate[msg.sender] = delegate;
        ds.delegateToDelegator[delegate] = msg.sender;
        emitDelegateChangedEvent(msg.sender, previousDelegate, delegate);
    }

    function revokeDelegate() internal {
        DelegateStorage storage ds = delegateStorage();
        address deletedDelegate = ds.delegatorToDelegate[msg.sender];
        require(deletedDelegate != address(0), 'LibDelegate: cannot revoke without a delegate.');
        LibDelegatePermissions.resetDelegatePermissions(msg.sender);
        delete ds.delegatorToDelegate[msg.sender];
        delete ds.delegateToDelegator[deletedDelegate];
        emitDelegateChangedEvent(msg.sender, deletedDelegate, address(0));
    }

    function abandonDelegation() internal {
        DelegateStorage storage ds = delegateStorage();
        address delegator = ds.delegateToDelegator[msg.sender];
        require(delegator != address(0), 'LibDelegate: address is not a delegate.');
        LibDelegatePermissions.resetDelegatePermissions(delegator);
        delete ds.delegateToDelegator[msg.sender];
        delete ds.delegatorToDelegate[delegator];
        emitDelegateChangedEvent(delegator, msg.sender, address(0));
    }

    function getDelegate(address delegator) internal view returns (address) {
        return delegateStorage().delegatorToDelegate[delegator];
    }

    function getDelegator(address delegate) internal view returns (address) {
        return delegateStorage().delegateToDelegator[delegate];
    }

    function emitDelegateChangedEvent(address delegator, address oldDelegate, address newDelegate) private {
        uint256 permissions = LibDelegatePermissions.getRawDelegatePermissions(msg.sender);
        emit DelegateChanged(delegator, oldDelegate, newDelegate, permissions);
    }
}
