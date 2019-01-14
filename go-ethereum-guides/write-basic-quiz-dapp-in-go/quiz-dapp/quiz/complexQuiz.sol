pragma solidity >=0.5.2 <0.6.0;

contract Quiz {
  // Adding the public modifier automatically gives this state variable a getter
  // that we can call with question().
    bytes public question; 

    // The internal modifier makes sure that only code in this contract 
    // can access this state variable.
    // Stored as bytes32 because we're storing the answer as keccak256 hash
    // instead of plaintext.
    bytes32 internal _answer;

    // Keep count of how many answers we've gotten.
    // For indexing the leaderBoard.
    uint256 internal _ansCount;

    // Mapping index to record struct, so that we can get
    // values of the mapping in a given sequence counting from _ansCount.
    mapping (address => bool) public leaderBoard;

    event CorrectAnswer(address indexed _addr);
    event UpdateLeaderBoard(address);

    constructor(bytes memory _qn, bytes memory _ans) public {
        require(_qn.length!=0, "contract must be initialized with a Question");
        require(_ans.length!=0, "contract must be initialized with an Answer");

        question = _qn;
        _answer = keccak256(_ans);
    }
    

    function _isCorrect(bytes memory _ans) internal view returns (bool){
        return _answer == keccak256(_ans);
    }

    function _updateLeaderBoard() internal returns (bool){
        leaderBoard[msg.sender] = true;
        emit UpdateLeaderBoard(msg.sender);
        return true;
    }

    function sendAnswer(bytes memory _ans, bytes32 _username) public returns (bool){
        require(_ans.length!=0, "please provide an answer");
        require(_username.length != 0, "user name must not be empty");

        if (_isCorrect(_ans)){
            emit CorrectAnswer(msg.sender);
            assert(_updateLeaderBoard());
            return true;
        }
        return false;
    }

    function checkBoard() public returns (bool){
        leaderBoard[msg.sender] = false;
        return leaderBoard[msg.sender];
    }
}
