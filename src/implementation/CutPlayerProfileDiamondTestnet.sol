// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CutPlayerProfileDiamond} from './CutPlayerProfileDiamond.sol';

/// @title Dummy "implementation" contract for LG Diamond interface for ERC-1967 compatibility
/// @dev adapted from https://github.com/zdenham/diamond-etherscan?tab=readme-ov-file
/// @dev This interface is used internally to call endpoints on a deployed diamond cluster.
contract CutPlayerProfileDiamondTestnet is CutPlayerProfileDiamond {

}
