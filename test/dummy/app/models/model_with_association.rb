# frozen_string_literal: true

class ModelWithAssociation < ActiveRecord::Base
  belongs_to :a_dummy
  belongs_to :b_dummy
  has_and_belongs_to_many :c_dummies
end
