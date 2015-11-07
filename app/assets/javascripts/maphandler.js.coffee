# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.map = null
window.geocoder = null
window.marker = null

window.initMap = () ->
  stockholm = new google.maps.LatLng(-34.607061, -58.435915)

  mapOptions = {
    center: stockholm
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoom: 11
  }

  window.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

  window.geocoder = new google.maps.Geocoder();

  $('#publication_country').change ->
    field_change_cb()

  $('#publication_province').change ->
    field_change_cb()

  $('#publication_locality').change ->
    field_change_cb()

  $('#publication_address').change ->
    field_change_cb()

  field_change_cb()


field_change_cb = () ->
  if (  $('#publication_country').val().length > 0 and $('#publication_province').val().length > 0 and $('#publication_locality').val().length > 0 and $('#publication_address').val().length > 0 )
    address = $('#publication_country').val()
    address = address + " " + $('#publication_province').val()
    address = address + " " + $('#publication_locality').val()
    address = address + " " + $('#publication_address').val()
    window.geocoder.geocode({'address': address}, geocoder_cb)

geocoder_cb = (results, status) ->
  if (status == google.maps.GeocoderStatus.OK)
    if (window.marker != null)
      window.marker.setMap(null)

    location = results[0].geometry.location

    window.map.setCenter( location )
    window.marker = new google.maps.Marker({
      map: window.map,
      position: location
    })
    window.map.setZoom( 15 )
    $('#publication_latitude').val( location.lat() )
    $('#publication_longitude').val( location.lng() )
  else
    alert('Geocode was not successful for the following reason: ' + status)
  

jQuery ->
  ready = ->
    key = 'AIzaSyDOL8ztdtkWKIel4pqu6G2ZW9iCSz7-WfQ'
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src  = 'https://maps.googleapis.com/maps/api/js?v=3.21&' + 'callback=initMap&' + 'key=' + key
    document.body.appendChild(script);
  

  $(document).ready( ready )
  $(document).on('page:load', ready )
