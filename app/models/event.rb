class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  attr_accessible :description, :image, :name, :target_minimum, :conv_course, :ex_name, :sorting_order, :convert_name, :report_link

  validates_presence_of :name, :description, :target_minimum, :conv_course, :ex_name
end
