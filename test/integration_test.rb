require 'hello_world'
require 'test/unit'
require 'rack/test'

class IdeaBoxTest < Test::Unit::TestCase
  include Rack::Test::Methods

  describe 'IdeaBox' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_has_an_index
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end

  def test_it_says_hello_to_a_person
    get '/', :name => 'Simon'
    assert last_response.body.include?('Simon')
  end
end