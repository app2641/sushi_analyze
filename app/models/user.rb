# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :prefecture
  belongs_to :origin_prefecture, class_name: 'Prefecture'
  belongs_to :region
  belongs_to :origin_region, class_name: 'Region'

  enum gender: {
    man: 0,
    woman: 1,
  }

  enum age: {
    less_than_or_equal_nineteen: 0,
    twenties: 1,
    thirties: 2,
    fourties: 3,
    fifties: 4,
    greater_than_or_equal_sixties: 5
  }

  enum ew: {
    east: 0,
    west: 1
  }

  enum origin_ew: {
    east: 0,
    west: 1,
  },
  _prefix: :origin
end
