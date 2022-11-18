// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

// Uncomment this line to use console.log
 import "hardhat/console.sol";

 import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
 import "@openzeppelin/contracts/utils/Strings.sol";

 import "./IXeu.sol";

contract hardhatTuto is ERC721Enumerable{
    struct player{
        string pseudo;
        uint pdv;
        uint force;
        uint agilite;
    }

    mapping(uint256 => player) playerInfo;
    mapping(uint256 => address) playerOwner;
    mapping(address => uint256) countPlayerByOwner;

    IXeu token;
    uint256 countPlayer = 1;

    function addPlayer(string memory _pseudo) public {
        playerInfo[countPlayer] = player(_pseudo, random(countPlayer) % 20, random(countPlayer) % 20, random(countPlayer) % 20 );
        console.log("le pseudo %s a les stats suivantes", playerInfo[countPlayer].pseudo);
        console.log('pdv : %d \n force : %d \n agilite: %d',playerInfo[countPlayer].pdv,playerInfo[countPlayer].force,
        playerInfo[countPlayer].agilite);
        countPlayerByOwner[msg.sender]+=1;
        playerOwner[countPlayer] = msg.sender;
        _safeMint(msg.sender, countPlayer);
        countPlayer += 1;
    }

    function random(uint256 _count) private view returns(uint256){
        return uint(keccak256 (abi.encodePacked(block.difficulty, block.timestamp, _count)));
    }

    function getPlayer(uint _id) public view returns(player memory){
        return playerInfo[_id];
    }

    function getOwnerOf(uint _id) public view returns(address){
        return playerOwner[_id];
    }

    function setToken(address _token)public{
        token = IXeu(_token);
    }

    function fight(uint _firstID, uint _secondID) public {
        player memory first = getPlayer(_firstID);
        player memory second = getPlayer(_secondID);

        if(first.force>second.force){
            token.wonCombat(getOwnerOf(_firstID));
        }
        else{
            token.wonCombat(getOwnerOf(_secondID));
        }
    }

    /*function getPlayerbyOwner() returns() {}{

    }*/

    function tokenURI(uint256 tokenId) public view override returns (string memory){
        player memory p = getPlayer(tokenId);
        return (string(abi.encodePacked(
            'data:application/json,{"name":"',p.pseudo,'#',Strings.toString(tokenId),
            '","image":"https://bafybeigkztjpz47sjpvk4kvzpnsjx66n43sknbemrs6awwpd5j7l4tqsve.ipfs.cf-ipfs.com/',Strings.toString(tokenId),'.jpeg",',
            '"description":"Collection test",',
            '"attributes":[{"trait_type":"agilite","value":"',
            Strings.toString(p.agilite),
            '"},{"trait_type":"force","value":"',
            Strings.toString(p.force),
            '"},{"trait_type":"pdv","value":"',
            Strings.toString(p.pdv),
            '"}]',
            '}'
        )));
    } 


    constructor(string memory _pseudo, string memory _symbol) ERC721(_pseudo, _symbol){
        addPlayer('Mehdi');
        addPlayer('Ghita');
    }

}
