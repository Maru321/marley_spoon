class Base
  include ContentfulRenderable

  SPACE_ID = ENV['SPACE_ID']
  ACCESS_TOKEN = ENV['ACCESS_TOKEN']

  def self.space_id
    SPACE_ID
  end

  def self.access_token
    ACCESS_TOKEN
  end

  # Override in your model
  def self.content_type_id
  end

  attr_accessor :contentful_id

  def initialize(contentful_id)
    @contentful_id = contentful_id
  end
end
