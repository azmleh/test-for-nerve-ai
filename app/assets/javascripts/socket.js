function Socket(id) {
  
  this.ws = new WebSocket('ws://localhost:3000/cable/gamechannel');
  this.identifier = JSON.stringify({ channel: 'GameChannel', id: id});

  this.ws.onopen = () => {
    console.log('WebSocket Connected');
    this.subscribe_cmd = {
      command: 'subscribe',
      identifier: this.identifier
    };
    this.send(this.subscribe_cmd);
  };
  this.ws.onclose = (event) => {
    console.log('WebSocket Closed', event);
  };
  this.ws.onmessage = (message) => {
    var data = JSON.parse(message.data);
    if (data.type != 'ping') {
      if (this.onReceive && data.message) this.onReceive(data.message);
    }
  };
  
  this.onReceive = null;
  
  this.close = () => {
    this.ws.close();
  };
  
  this.sendMove = (data) => {
    data.action = 'move';
    var cmd = {
      command: 'message',
      identifier: this.identifier,
      data: JSON.stringify(data)
    };
    this.send(cmd);
  };
  
  this.send = (cmd) => {
    this.ws.send(JSON.stringify(cmd));
  };
  
}