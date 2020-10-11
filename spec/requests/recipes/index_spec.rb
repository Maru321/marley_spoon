require 'rails_helper'

describe 'Recipes index' do
  let(:api_response_content_types) do
    File.read('spec/support/successful_response_content_types.txt')
  end
  let(:api_response_entries) do
    File.read('spec/support/successful_response_entries.txt')
  end

  before do
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/content_types?limit=1000")
      .to_return(status: 200, body: api_response_content_types, headers: {})
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/entries?content_type=recipe&include=2")
      .to_return(status: 200, body: api_response_entries, headers: {})
  end

  it 'renders the index view' do
    get '/recipes'

    expect(response).to render_template(:index)
  end

  it 'assigns the recipes variable' do
    get '/recipes'

    expect(assigns(:recipes)).not_to be_nil
  end

  it 'returns a successful response' do
    get '/recipes'

    expect(response).to have_http_status(:successful)
  end
end
