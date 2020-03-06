# frozen_string_literal: true

class CDummy < ActiveRecord::Base
  has_and_belongs_to_many :model_with_associations
end
