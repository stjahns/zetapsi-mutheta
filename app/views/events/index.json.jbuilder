json.array! @events do |event|
  json.title event.name
  json.allDay false 
  json.start event.start_time
  json.end event.end_time
  json.url event_path(event)
end
