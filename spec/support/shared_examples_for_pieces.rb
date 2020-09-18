# frozen_string_literal: true

RSpec.shared_examples 'a piece' do
  let(:piece) { described_class.new(:white, 0, 0) }

  it 'responds to #move_to' do
    expect(piece).to respond_to(:move_to).with(2).arguments
  end

  it 'responds to #threatens?' do
    expect(piece).to respond_to(:threatens?).with(2).arguments
  end

  it 'responds to #position' do
    expect(piece).to respond_to(:position)
  end
end
