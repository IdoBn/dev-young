class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
  # #override create_marker method
  # create_marker: ->
  #   options = _.extend @marker_options(), @rich_marker_options()
  #   @serviceObject = new RichMarker options #assign marker to @serviceObject

  # rich_marker_options: ->
  #   marker = document.createElement("div")
  #   marker.setAttribute 'class', 'marker_container'
  #   marker.innerHTML = @args.title
  #   { content: marker }

    # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'yellow') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

    # add @bind_infowindow() for < 2.1
  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-50, -60)
    boxStyle:
      width: "100px"
      height: "50px"

@buildMap = (markers)->
  handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} } #dependency injection

  #then standard use
  handler.buildMap {
    provider: {
      disableDefaultUI: true
    }, 
    internal: {
      id: 'map'
      } 
    }, ->
      markers = handler.addMarkers(markers)
      handler.bounds.extendWith(markers)
      handler.fitMapToBounds()
