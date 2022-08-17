# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
end
