# frozen_string_literal: true

class BDummy < ActiveRecord::Base
  has_many :model_with_associations
end
