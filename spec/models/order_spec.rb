# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  describe 'associations' do
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
  end

end