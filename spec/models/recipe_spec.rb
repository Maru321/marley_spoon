require 'rails_helper'

describe Recipe do
  describe '.content_type_id' do
    it 'has the correct content type id' do
      expect(Recipe.content_type_id).to eq('recipe')
    end
  end

  describe '.content_type_id' do
    it 'has the correct content type id' do
      expect(Recipe.content_type_id).to eq('recipe')
    end
  end
end
