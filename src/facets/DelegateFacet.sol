// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {LibDelegate} from '../libraries/LibDelegate.sol';

contract DelegateFacet {
    function setDelegate(address delegate) external {
        LibDelegate.setDelegate(delegate);
    }

    function revokeDelegate() external {
        LibDelegate.revokeDelegate();
    }

    function abandonDelegation() external {
        LibDelegate.abandonDelegation();
    }

    function getDelegate(address delegator) external view returns (address) {
        return LibDelegate.getDelegate(delegator);
    }

    function getDelegator(address delegate) external view returns (address) {
        return LibDelegate.getDelegator(delegate);
    }
}
