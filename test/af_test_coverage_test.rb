# frozen_string_literal: true

require 'test_helper'

class AfTestCoverageTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AfTestCoverage::VERSION
  end
end
