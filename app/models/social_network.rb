# -*- encoding : utf-8 -*-
class SocialNetwork < ActiveRecord::Base
  include ClassyEnum::ActiveRecord

  belongs_to :user

  classy_enum_attr :name, :enum => 'SocialNetworkSite'
  validates_presence_of :url
end
