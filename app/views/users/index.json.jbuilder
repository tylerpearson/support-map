json.type "FeatureCollection"

json.features(@users) do |user|
  json.type "Feature"
  json.geometry do
    json.type "Point"
    json.coordinates [user.longitude, user.latitude]
  end
  json.properties do
    json.id user.id
    # json.name user.name
    json.title user.name
    # json.marker-color #f00"
    # json.marker-size 'large'
  end
end