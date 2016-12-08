var Players = {
	randomPlayer :function(players){
		var min = 0;
		var max = players.length - 1;
		var random_index = Math.floor(Math.random() * (max - min + 1) + min);
		return players[random_index];
	},
	alertRandomPlayer :function(players) {
		var random_player = this.randomPlayer(players);
		alert("Name: " + random_player.name + ":: Batting average: " + random_player.batting_average);
	}
}
