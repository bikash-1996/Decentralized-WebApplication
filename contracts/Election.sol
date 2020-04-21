pragma solidity  >=0.4.22 <0.7.0;

contract Election
{
    struct Candidate
    {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // We need a place to store one of the structure types that we've just created.
    // We can do this with a Solidity mapping.

    mapping(uint => Candidate) public candidates;

    //Next, we set this mapping's visibility to public in order to get a getter function. 
    uint public candidatesCount;

     // voted event
    event votedEvent (
        uint indexed _candidateId
    );
    constructor() public
    {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private
    {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);

    }

    function vote(uint _candidateId) public{
        //require they have not voted before //
        require(!voters[msg.sender]);

        //require a valid candidate //
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        //recording the voter that has voted //
        voters[msg.sender] = true;

        //update candidate vote count //
        candidates[_candidateId].voteCount ++;

        //trigger voted event //
        emit votedEvent(_candidateId);

    }
    
}