# frozen_string_literal: true

class ADummy < ActiveRecord::Base
  has_one :model_with_association
end
