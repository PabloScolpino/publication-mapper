# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.map = null
window.initMap = () ->
  stockholm = new google.maps.LatLng(-34.607061, -58.435915)

  mapOptions = {
    center: stockholm
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoom: 11
  }

  window.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

  get_points()

get_points = () ->
  console.log("getting points")
  coords = new google.maps.LatLng(-34.607061, -58.435915)
  title = "pepe"
  marker = new google.maps.Marker({
    position: coords,
    map: window.map,
    title: title
  })



jQuery ->
  ready = ->
    key = 'AIzaSyDOL8ztdtkWKIel4pqu6G2ZW9iCSz7-WfQ'
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src  = 'https://maps.googleapis.com/maps/api/js?v=3.21&' + 'callback=initMap&' + 'key=' + key
    document.body.appendChild(script);
  

  $(document).ready ->
    ready()
