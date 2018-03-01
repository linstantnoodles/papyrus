require 'rails_helper'

RSpec.describe Card, type: :model do
  subject {
    described_class.new(
      front: 'test-front',
      back: 'test-back',
    )
   }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a front" do
    subject.front = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a back" do
    subject.back = nil
    expect(subject).to_not be_valid
  end
end
