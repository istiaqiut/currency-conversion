require 'spec_helper'

describe 'Your application' do

  it "should GET to / " do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include("<div class=\"container-fluid convert\">")
  end

  it "should POST to /" do
    post '/', "inputvalue" => 1, "inputcurrency" => "EUR", "outputcurrency" => "USD"
    expect(last_response.status).to eq 302
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should GET to / when no params in the post request" do
    post '/'
    expect(last_response.status).to eq 500
    expect(last_request.path).to eq('/')
  end

  it "should GET to / when invalid input currency value given in the post request" do
    post '/', "inputvalue" => -1, "inputcurrency" => "EUR", "outputcurrency" => "USD"
    expect(last_response.status).to eq 302
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should GET to / when invalid currency is provided in the post request" do
    post '/', "inputvalue" => 1, "inputcurrency" => "EUR", "outputcurrency" => "GBP"
    expect(last_response.status).to eq 302
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should GET to /histories" do
    get '/histories'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include("<div class=\"container-fluid\">")
  end

end
