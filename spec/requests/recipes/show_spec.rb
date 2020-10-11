require 'rails_helper'

describe 'Recipes show' do
  let(:api_response_content_types) do
    File.read('spec/support/successful_response_content_types.txt')
  end
  let(:api_response_single_entry) do
    File.read('spec/support/successful_response_entries_single_entry.txt')
  end

  before do
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/content_types?limit=1000")
      .to_return(status: 200, body: api_response_content_types, headers: {})
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/entries?content_type=recipe&include=2&sys.id=:id")
      .to_return(status: 200, body: api_response_single_entry, headers: {})
  end

  it 'renders the index view' do
    get '/recipes/:id'

    expect(response).to render_template(:show)
  end

  it 'assigns the recipes variable' do
    get '/recipes/:id'

    expect(assigns(:recipe)).not_to be_nil
  end

  it 'returns a successful response' do
    get '/recipes/:id'

    expect(response).to have_http_status(:successful)
  end
end
