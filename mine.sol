pragma solidity >=0.4.17;

contract Mine {

    uint256 total;
    mapping (address => uint256) balances;

    event Deposit(address indexed coinbase, uint256 value);
    event Withdraw(address indexed coinbase, uint256 value);


    function balanceOf(address owner) public view returns (uint256) { return balances[owner]; }

    function totalDeposit() public view returns (uint256) { return total; }

    function deposit() public payable returns (bool success) {
        if (msg.value <= 0) {
            return true;
        }

        total += msg.value;
        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);

        return true;
    }

    function withdraw() public returns (bool success) {
        uint256 value = balances[msg.sender];

        if (value <= 0) {
            return true;
        }

        total -= value;
        balances[msg.sender] = 0;

        if (!msg.sender.send(value)) {
            total += value;
            balances[msg.sender] = value;
            return false;
        }

        emit Withdraw(msg.sender, value);

        return true;
    }

}
