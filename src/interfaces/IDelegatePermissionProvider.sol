// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IPermissionProvider {
    event DelegateChanged(
        address indexed owner,
        address indexed oldDelegate,
        address indexed newDelegate,
        uint256 permissions
    );
}
