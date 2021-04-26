pragma solidity >= 0.7.0 <= 0.7.4;

contract SendBack{
    
    address owner;
    //mapping (address => uint) timeouts;
    
    event Withdrawal(address indexed to);
    event Deposit(address indexed from, uint amount);
    
    constructor() {
        //Will be called on creation of the smart contract.
        owner = msg.sender;
    }
    
    //  Sends 0.1 ETH to the sender when the contract has enough funds
    function withdraw() internal{
        
        require(address(this).balance >= 0.1 ether, "This faucet is empty. Please check back later.");
        
        msg.sender.transfer(0.1 ether);
        
        emit Withdrawal(msg.sender);
    }
    
    //  Sending Tokens to this faucet fills it up and send back if the contract has enough funds
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
        withdraw();
    } 
    
    
    //  Destroys this smart contract and sends all remaining funds to the owner
    function destroy() public{
        require(msg.sender == owner, "Only the owner of this faucet can destroy it.");
        selfdestruct(msg.sender);
    }
}