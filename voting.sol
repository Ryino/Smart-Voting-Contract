// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Voting {
    // Structure to store details of each proposal
    struct Proposal {
        // Name of the proposal
        string name;
        // Number of accumulated votes
        uint voteCount;
    }

    // Address of the contract creator
    address public chairperson;
    // Mapping to track who has voted
    mapping(address => bool) public hasVoted;
    // Dynamic array to store all proposals
    Proposal[] public proposals;

    // Constructor to initialize the contract with a list of proposal names
    constructor(string[] memory proposalNames) {
        // Set the chairperson to the address that deploys the contract
        chairperson = msg.sender;
        // Loop through each proposal name provided
        for (uint i = 0; i < proposalNames.length; i++) {
            // Add each proposal to the proposals array
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Function to cast a vote for a specific proposal
    function vote(uint proposalIndex) public {
        // Ensure the voter hasn't already voted
        require(!hasVoted[msg.sender], "You have already voted.");
        // Mark the voter as having voted
        hasVoted[msg.sender] = true;
        // Increment the vote count for the chosen proposal
        proposals[proposalIndex].voteCount += 1;
    }

    // Function to get details of a specific proposal
    function getProposal(uint proposalIndex) public view returns (string memory name, uint voteCount) {
        // Retrieve the proposal from the array
        // we have input ["School Board Member 1", "School Board Member 2", "School Board Member 3"] as this is intended towards School Board Voting
        Proposal memory proposal = proposals[proposalIndex];
        // Return the proposal's name and vote count
        return (proposal.name, proposal.voteCount);
    }
}
