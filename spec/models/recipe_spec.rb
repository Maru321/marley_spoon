require 'rails_helper'

describe Recipe do
  describe '#render_all' do
    before do
      stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/content_types?limit=1000")
        .to_return(status: status, body: api_response_content_types, headers: {})
      stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/entries?content_type=recipe&include=2")
        .to_return(status: status, body: api_response_entries, headers: {})
    end

    context 'when the response is successful' do
      let(:status) { 200 }
      let(:api_response_content_types) do
        File.read('spec/support/successful_response_content_types.txt')
      end
      let(:api_response_entries) do
        File.read('spec/support/successful_response_entries.txt')
      end

      subject { Recipe.render_all }

      it 'returns the recipes' do
        expect(subject.count).to eq(4)
      end
    end

    context 'when the response is not successful' do
      let(:status) { 500 }
      let(:api_response_content_types) do
        File.read('spec/support/error_response_content_types.txt')
      end
      let(:api_response_entries) do
        File.read('spec/support/error_response_content_types.txt')
      end

      subject { Recipe.render_all }

      it 'returns an empty array' do
        expect(subject.count).to eq(0)
      end
    end
  end

  describe '.render' do
    before do
      stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/content_types?limit=1000")
        .to_return(status: status, body: api_response_content_types, headers: {})
      stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/entries?content_type=recipe&include=2&sys.id=#{recipe_id}")
        .to_return(status: status, body: api_response_single_entry, headers: {})
    end

    context 'when the response is successful' do
      let(:status)    { 200 }
      let(:recipe_id) { '4dT8tcb6ukGSIg2YyuGEOm' }
      let(:api_response_content_types) do
        File.read('spec/support/successful_response_content_types.txt')
      end
      let(:api_response_single_entry) do
        File.read('spec/support/successful_response_entries_single_entry.txt')
      end

      subject { Recipe.new(recipe_id).render }

      it 'returns the recipe' do
        expect(subject.id).to eq(recipe_id)
      end

      [:tags, :title, :chef, :description, :photo].each do |attribute|
        it "responds to #{attribute}" do
          expect(subject.respond_to?(attribute)).to be(true)
        end
      end
    end

    context 'when the response is not successful' do
      let(:status)    { 404 }
      let(:recipe_id) { 'non existent id' }
      let(:api_response_content_types) do
        File.read('spec/support/successful_response_content_types.txt')
      end
      let(:api_response_single_entry) do
        File.read('spec/support/error_response_entries_single_entry.txt')
      end

      subject { Recipe.new(recipe_id).render }

      it 'returns nil' do
        expect(subject).to be(nil)
      end
    end
  end

  describe '.content_type_id' do
    it 'has the correct content type id' do
      expect(Recipe.content_type_id).to eq('recipe')
    end
  end
end
