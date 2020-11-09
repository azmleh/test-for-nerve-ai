//= require vue

//= require http
//= require socket

var socket = null

var app = new Vue({
  el: '#game-app',
  data: {
    loading: true,
    id: null,
    socket: null,
    match: {},
    sign: '',
    field: {},
    winLine: []
  },
  created: function () {
    this.id = window.location.pathname.split('/')[2];
    this.getMatch();
  },
  computed: {
    isLoaded: function () {
      return !this.loading;
    }
  },
  methods: {
    getMatch: function () {
      http.get('/api/matches/' + this.id).then(resp => {
        let data = JSON.parse(resp);
        this.match = data.match;
        this.sign = data.player;
        this.field = data.field;
        socket = new Socket(this.id);
        socket.onReceive = (data) => {
          console.log(data);
          this.finishMove(data);
          this.loading = !!data.processing;
        };
        this.loading = false;
      });
    },
    move: function (key) {
      if (this.loading || this.field[key]) return;
      this.loading = true;
      socket.sendMove({ name: key, value: this.sign });
    },
    finishMove: function (data) {
      if (!data.cell || data.cell.action != 'move') return;
      if (data.result && data.result.win) {
        this.winLine = data.result.cells
      } else {
        this.field[cell.name] = cell.value;
      }
    }
  }
});
