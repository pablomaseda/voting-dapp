pragma solidity >=0.4.21 <0.6.0;

contract Voting {
  mapping (bytes32 => uint8) public votes;
  bytes32[] private candidateList ;

  event UpdateCandidates();

  function getCandidateVotes(bytes32 candidate) public view returns (uint8) {
    assert(doesCandidateExist(candidate));

    return votes[candidate];
  }

  function listCandidates() public view returns (bytes32[] memory) {
    return candidateList;
  }

  function postulateCandidate(bytes32 candidate) public {
    assert(!doesCandidateExist(candidate));

    candidateList.push(candidate);
    emit UpdateCandidates();
  }

  function voteForCandidate(bytes32 candidate) public {
    assert(doesCandidateExist(candidate));

    votes[candidate] += 1;
    emit UpdateCandidates();
  }

  function doesCandidateExist(bytes32 candidate) internal view returns (bool) {
    if(candidateList.length == 0){
	return false;
    }
    for (uint i = 0; i < candidateList.length; i++) {
      if ( candidateList[i] ==  candidate) {
        return true;
      }
    }
    return false;
  }
  function stringToBytes32(string memory source) public pure returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
}
}
