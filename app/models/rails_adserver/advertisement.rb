module RailsAdserver
  class Advertisement < ActiveRecord::Base
    belongs_to :adspace
    has_many :clicks
    require 'carrierwave/orm/activerecord'
    
    attr_accessible :image, :title, :content, :width, :height, :is_active, :param_restriction, :ad_text, :parameter_restriction_boolean,
    :param_restriction_name, :adspace_id, :ad_type, :url, :geolocation_boolean, :max_clicks, :geolocation_location, :city_name, :state_name, :country_name
    
    mount_uploader :image, AdvertisementUploader
    def self.random_ad(param)
      if param == nil
        ad_ids = self.where("is_active = ? AND parameter_restriction_boolean = ?", true, false).map(&:id)
      else
        ad_ids = self.where("is_active = ? AND param_restriction = ?",true, param).map(&:id)
      end
      id = ad_ids[rand(ad_ids.length)]
    end
    def self.geo_city(city)
      ad_ids = self.where("city_name = ? AND is_active = ?", city, true).map(&:id)
      id = ad_ids[rand(ad_ids.length)]
    end
    def self.geo_state(state)
      ad_ids = self.where("state_name = ? AND is_active = ?", state, true).map(&:id)
      id = ad_ids[rand(ad_ids.length)]
    end
    def self.geo_country(country)
      ad_ids = self.where("country_name = ? AND is_active = ?", country, true).map(&:id)
      id = ad_ids[rand(ad_ids.length)]
    end
  end
end