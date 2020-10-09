require "rails_helper"

describe 'Recipes index' do
  let(:api_response) do
    File.read("spec/support/successful_response.txt")
  end

  before do
    stub_request(:get, 'https://cdn.contentful.com/spaces/kk2bw5ojx476/content_types?limit=1000')
      .to_return(status: 200, body: api_response, headers: {})
    stub_request(:get, 'https://cdn.contentful.com/spaces/kk2bw5ojx476/entries?content_type=recipe&include=2')
      .to_return(status: 200, body: api_response, headers: {})
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
