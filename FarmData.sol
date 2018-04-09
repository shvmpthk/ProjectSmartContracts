pragma solidity ^0.4.0;
contract FarmData{
    struct Data{
        bytes32 id;
        address sensor;
        uint dataPoints;
        bytes32 dataHash;
        uint timestamp;
        bytes32 location;
        address farmManager;
        uint value;
    }

    mapping(address=>mapping(bytes32=>Data)) sensorData;  //matrix of all sensorData
    mapping(address=>bytes32[]) dataIdArray;                //of each snesor

    function sendSensorDataTo(bytes32 data_id, uint dataPoints, bytes32 dataHash, uint timestamp, bytes32 location, address addr) public{

        dataIdArray[msg.sender].push(data_id);

        sensorData[msg.sender][data_id] = Data(
        data_id,
        msg.sender,
        dataPoints,
        dataHash,
        timestamp,
        location,
        addr,
        0
        );
    }

    function paySensorForData(address addr, bytes32 data_id) public payable{
        sensorData[addr][data_id].value = msg.value;
        addr.transfer(msg.value);
    }

    function getSensorDataCount(address addr) view public returns(uint){
        return dataIdArray[addr].length;
    }

    function getSensorDataInfo(address addr,uint index) view public returns(bytes32,uint,bytes32,uint,bytes32,uint){
        Data memory d = sensorData[addr][dataIdArray[msg.sender][index]];
        return (d.id, d.dataPoints, d.dataHash, d.timestamp, d.location, d.value);
    }
}
