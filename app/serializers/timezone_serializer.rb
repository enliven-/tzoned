class TimezoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :city_id, :gmt_difference
end
