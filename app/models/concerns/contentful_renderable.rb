module ContentfulRenderable
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend(ClassMethods)
  end

  # Overridable
  # Override this method to change the parameters set for your Contentful query on each specific model
  # For more information on queries you can look into: https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/search-parameters
  def render
    self.class.client.entries(content_type: self.class.content_type_id, include: 2, "sys.id" => contentful_id).first
  end

  module ClassMethods
    def client
      @client ||= Contentful::Client.new(
        access_token: Base.access_token,
        space: Base.space_id,
        dynamic_entries: :auto,
        raise_errors: true,
        raise_for_empty_fields: false
      )
    end

    # Overridable
    # Override this method to change the parameters set for your Contentful query on each specific model
    # For more information on queries you can look into: https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/search-parameters
    def render_all
      client.entries(content_type: content_type_id, include: 2)
    end
  end
end
