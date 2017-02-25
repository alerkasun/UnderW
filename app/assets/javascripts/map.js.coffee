class @LocationMap
  constructor: (@domElement) ->
    L.Icon.Default.imagePath = "/leaflet"
    @lmap = L.map(@domElement).setView([47.0736333,15.4366147], 13)
    @marker_group = new L.FeatureGroup()
    @path_group = new L.FeatureGroup()
    @path = L.polyline([], {color: 'red'}).addTo(@path_group)
    @circle_group = new L.FeatureGroup()

    tile_osm = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    })
    tile_osm_cycle = L.tileLayer('http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenCycleMap</a> contributors'
    })
    @lmap.addLayer(tile_osm)
    @lmap.addLayer(@marker_group)
    @lmap.addLayer(@path_group)
    @lmap.addLayer(@circle_group)
    map_tiles = {
      "Open Street Map" : tile_osm
      "Open Cycle Map" : tile_osm_cycle
    }
    L.control.layers(map_tiles, {
      "Marker":@marker_group
      "Paths":@path_group
      "Accuracy":@circle_group
    }).addTo(@lmap)

  clear: ->
    @marker_group.clearLayers()
    @path_group.clearLayers()
    @path = L.polyline([], {color: 'red'}).addTo(@path_group)
    @circle_group.clearLayers()

  addLocations: (locations) =>
    for location in locations
      @addMarker(location)
      @addAccuracyCircle(location)
      @addToPath(location)
      @lastLocation = location

  moveMapToLocations: ->
    @lmap.fitBounds(@marker_group.getBounds(), {maxZoom: 15})

  addMarker: (location) ->
    marker = L.marker([location.latitude, location.longitude])
    marker.bindPopup("" +
        location["time"] + "<br/>" +
        "Accuracy: " + location.accuracy + "m"
    )
    @marker_group.addLayer(marker)
    console.log @marker_group.getLayers().length

  addAccuracyCircle: (location) ->
    return unless location.accuracy?
    circle = L.circle([location.latitude, location.longitude], location.accuracy)
    @circle_group.addLayer(circle)

  addToPath: (location) ->
    @path.addLatLng([location.latitude, location.longitude])

  getLastLocation: ->
    @lastLocation
