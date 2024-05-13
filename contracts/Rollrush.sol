pragma solidity ^0.8.0;

contract Rollrush {
    address public owner;
    uint256 public minimumBet;
    uint256 public maximumBet;
    uint256 public houseEdge; // Represents house edge in percentage (e.g., 5 for 5%)

    event BetPlaced(address indexed player, uint256 amount, uint256 betNumber);

    constructor(uint256 _minimumBet, uint256 _maximumBet, uint256 _houseEdge) {
        owner = msg.sender;
        minimumBet = _minimumBet;
        maximumBet = _maximumBet;
        houseEdge = _houseEdge;
    }

    function placeBet(uint256 _betNumber) external payable {
        require(msg.value >= minimumBet && msg.value <= maximumBet, "Invalid bet amount");
        require(_betNumber >= 0 && _betNumber <= 36, "Invalid bet number");

        emit BetPlaced(msg.sender, msg.value, _betNumber);
    }

    function spinWheel() external payable  {
        // Simulate the roulette wheel spinning and determine the winning number
        // For simplicity, let's say it generates a random number between 0 and 36
        uint256 winningNumber = generateRandomNumber();

        // Payout to the winners based on their bets
        // For simplicity, let's say each bet has a 1:36 payout ratio (excluding house edge)
        // This is just for demonstration, in a real scenario, the payout logic would be more complex
        uint256 payoutAmount = msg.value * 36;

        // Deduct the house edge from the payout amount
        uint256 houseCut = (payoutAmount * houseEdge) / 100;
        payoutAmount -= houseCut;

        // Transfer the winnings to the winners
        payable(msg.sender).transfer(payoutAmount);
    }

    // Function to generate a pseudo-random number (not secure, for demonstration purposes only)
    function generateRandomNumber() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % 37;
    }

    // Function to allow the owner to withdraw funds from the contract
    function withdrawFunds(uint256 _amount) external {
        require(msg.sender == owner, "Only owner can withdraw funds");
        require(_amount <= address(this).balance, "Insufficient balance");

        payable(owner).transfer(_amount);
    }
}
