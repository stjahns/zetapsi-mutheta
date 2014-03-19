json.array! @events do |event|
  json.title event.name
  json.allDay false 
  json.start event.time
  json.url event_path(event)
end
