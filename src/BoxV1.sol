//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";


// storage is stored in the proxy, NOT the implementation

// if implementation had a constructor lets say that changed number to 1, the proxy one would be still remain unchanged
// so proxy -> deploy implementation -> call some " initializer" function 
// constructors are not used in proxy contract , so what a lot of upgradable contracts do is they first, they call this disableinitializer functions in the contructor  // constructor() {
    //     _disableInitializers();
    // }
// but lets day we do need a constructor, we can use the Initializable contract from openzeppelin, which has a modifier called initializer    


contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal value;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();                // this means we dont to run any initializers in the constructor
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    function getValue() public view returns (uint256) {
        return value;
    }

    function version() public pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}