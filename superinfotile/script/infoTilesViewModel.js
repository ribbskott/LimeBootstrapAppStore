var infoTilesViewModel = function () {
    var self = this;
    var infoTiles = new ko.observableArray([]);
    self.saveInfoTiles = function () {
        ko.ToJson(infoTiles);
    },
    self.loadInfoTiles = function () {
        infoTiles(lbs.common.executeVba("superinfotile.LoadInfoTiles"));
    },
    self.addInfoTile = function () {
        var infoTile = New infotile();
        infoTiles.push(infoTile);
    }

}