require 'rails_helper'

describe 'Recipes show' do
  let(:api_response) do
    File.read('spec/support/successful_response.txt')
  end

  before do
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/entries?content_type=recipe&include=2&sys.id=:id")
      .to_return(status: 200, body: api_response, headers: {})
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
