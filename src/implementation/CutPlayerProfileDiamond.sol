// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CutDiamond} from "../../lib/cu-osc-diamond-template/src/diamond/CutDiamond.sol";

import {DelegateFacetFragment} from "./DelegateFacetFragment.sol";
import {DelegatePermissionsFacetFragment} from "./DelegatePermissionsFacetFragment.sol";
import {MetadataFacetFragment} from "./MetadataFacetFragment.sol";

/// @title Dummy "implementation" contract for LG Diamond interface for ERC-1967 compatibility
/// @dev adapted from https://github.com/zdenham/diamond-etherscan?tab=readme-ov-file
/// @dev This interface is used internally to call endpoints on a deployed diamond cluster.
contract CutPlayerProfileDiamond is
    CutDiamond,
    DelegateFacetFragment,
    DelegatePermissionsFacetFragment,
    MetadataFacetFragment
{
    event DelegateChanged(
        address indexed owner,
        address indexed oldDelegate,
        address indexed newDelegate,
        uint256 permissions
    );
    event PermissionsChanged(
        address indexed owner,
        address indexed delegate,
        uint256 oldPermissions,
        uint256 newPermissions
    );
}
