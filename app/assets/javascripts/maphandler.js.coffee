# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.script_loaded = false

window.main_map = null
window.publication_map = null

window.geocoder = null
window.marker = null

initMap = ( canvas_id ) ->
  buenos_aires = new google.maps.LatLng(-34.607061, -58.435915)

  mapOptions = {
    center: buenos_aires
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoom: 11
  }

  new google.maps.Map(document.getElementById( canvas_id ), mapOptions)


window.initPublicationMap = () ->
  window.publication_map = initMap( 'publication-map-canvas' )
  window.geocoder = new google.maps.Geocoder();


  if ( $('#publication_country').length != 0 )
    $('#publication_country').change ->
      publication_field_change_cb()
  
    $('#publication_province').change ->
      publication_field_change_cb()
  
    $('#publication_locality').change ->
      publication_field_change_cb()
  
    $('#publication_address').change ->
      publication_field_change_cb()
  
    publication_field_change_cb()


publication_field_change_cb = () ->
  if (  $('#publication_country').val().length > 0 and $('#publication_province').val().length > 0 and $('#publication_locality').val().length > 0 and $('#publication_address').val().length > 0 )
    address = $('#publication_country').val()
    address = address + " " + $('#publication_province').val()
    address = address + " " + $('#publication_locality').val()
    address = address + " " + $('#publication_address').val()
    window.geocoder.geocode({'address': address}, publication_geocoder_cb)

publication_geocoder_cb = (results, status) ->
  if (status == google.maps.GeocoderStatus.OK)
    if (window.marker != null)
      window.marker.setMap(null)

    location = results[0].geometry.location

    window.publication_map.setCenter( location )
    window.marker = new google.maps.Marker({
      map: window.publication_map,
      position: location
    })
    window.publication_map.setZoom( 15 )
    $('#publication_latitude').val( location.lat() )
    $('#publication_longitude').val( location.lng() )
  else
    alert('Geocode was not successful for the following reason: ' + status)

window.initMainMap = () ->
  window.main_map = initMap( 'main-map-canvas' )
  $.getJSON( 'publications.json', publications_list_cb )


publications_list_cb = ( data ) ->
  markers = []
  $.each( data, (index, pub) ->
    m = new google.maps.Marker({ 
      map: window.main_map, 
      position:  {lat: pub.latitude, lng: pub.longitude},
      label: pub.name
      })
    markers.push( m )
  )


jQuery ->
  ready = ->
    if ( $('#main-map-canvas').length != 0 )
      if (not window.script_loaded )
        key = 'AIzaSyDOL8ztdtkWKIel4pqu6G2ZW9iCSz7-WfQ'
        script = document.createElement('script')
        script.type = 'text/javascript'
        script.src  = 'https://maps.googleapis.com/maps/api/js?v=3.21&' + 'callback=initMainMap' + '&' + 'key=' + key
        document.body.appendChild(script);
        window.script_loaded = true
      else 
        initMainMap()

    if ( $('#publication-map-canvas').length != 0 )
      if (not window.script_loaded )
        key = 'AIzaSyDOL8ztdtkWKIel4pqu6G2ZW9iCSz7-WfQ'
        script = document.createElement('script')
        script.type = 'text/javascript'
        script.src  = 'https://maps.googleapis.com/maps/api/js?v=3.21&' + 'callback=initPublicationMap' + '&' + 'key=' + key
        document.body.appendChild(script);
        window.script_loaded = true
      else 
        initPublicationMap()

  
  $(document).ready( ready )
  $(document).on('page:load', ready )
