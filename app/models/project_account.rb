# -*- coding: utf-8 -*-
class ProjectAccount < ActiveRecord::Base
  include I18n::Alchemy
  include Shared::BankAccountHelper
  enum entity_type: {
    pf: 'pf',
    pj: 'pj',
    mei: 'mei'
  }
  belongs_to :project
  belongs_to :bank
  has_many :project_account_errors

  attr_accessor :input_bank_number
  validate :input_bank_number_validation
  before_validation :load_bank_from_input_bank_number

  validates_presence_of :email, :address_street, :address_number, :address_city, :address_state, :address_zip_code, :phone_number, :bank, :agency, :account, :account_digit, :owner_name, :owner_document
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates_length_of :agency, minimum: 4

  def self.entity_type_for_select
    entity_types.map do |name, _| 
      [I18n.t("shared.project_account_enum.#{name}"), name]
    end
  end

  def email=(value)
    self[:email] = value.to_s.strip
  end

  def agency=(value)
    self[:agency] = value.to_s.strip
  end

  def account=(value)
    self[:account] = value.to_s.strip
  end
end
