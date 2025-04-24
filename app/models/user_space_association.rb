# -*- encoding : utf-8 -*-
class UserSpaceAssociation < ActiveRecord::Base
  include ClassyEnum::ActiveRecord

  # Em alguns casos o enrollment é chamado utilizando o gem activerecord-import
  # por questões de otimização. Este gem desabilita qualquer tipo de callback
  # cuidado ao adicionar callbacks a esta entidade.
  belongs_to :user
  belongs_to :space

  classy_enum_attr :role, :default => 'member'

  scope :users_by_name,
    lambda { |name| includes(:user).
      where("users.first_name LIKE :keyword OR
             users.last_name LIKE :keyword OR
             users.login LIKE :keyword", {:keyword => "%#{name.to_s}%"})
  }

  validates_uniqueness_of :user_id, :scope => :space_id

  def self.import(records, validate: false)
    records.each do |record|
      record.save(validate: validate)
    end
  end
end
