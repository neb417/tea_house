# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many :subscriptions }
    it { should have_many :customers }
  end
end
