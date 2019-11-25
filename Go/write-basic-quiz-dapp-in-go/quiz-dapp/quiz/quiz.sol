pragma solidity >=0.5.2 <0.6.0;

contract Quiz {
    string public question; 
    bytes32 internal _answer;
    mapping (address => bool) internal _leaderBoard;

    // On contract.DeployContract():
    // Create a new contract and set question and expected answer.
    constructor(string memory _qn, bytes32 _ans) public {
        question = _qn;
        _answer = _ans;
    }

    // We expect our application to keccak256() hash the answer before sending it over.
    function sendAnswer(bytes32 _ans) public returns (bool){
        return _updateLeaderBoard(_answer == _ans);
    }

    function _updateLeaderBoard(bool ok) internal returns (bool){
        _leaderBoard[msg.sender] = ok;
        return true;
    }

    function checkBoard() public view returns (bool){
        return _leaderBoard[msg.sender];
    }
}
