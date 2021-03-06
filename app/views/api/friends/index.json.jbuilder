json.array! @friends do |friend|
  json.uid friend.uid
  json.first_name friend.first_name
  json.last_name friend.last_name
  json.name friend.name
  json.username friend.username
  json.city friend.location.city
  json.image_normal_url "https://graph.facebook.com/#{friend.uid}/picture?type=square"
end