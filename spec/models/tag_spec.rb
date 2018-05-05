require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'saves name in lowercase' do
    new_tag = Tag.create(name: 'Uppercase')
    expect(new_tag.name).to eq('uppercase')
  end
end