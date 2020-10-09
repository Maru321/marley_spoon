class Recipe < Base
  include ContentfulRenderable

  def self.content_type_id
    'recipe'
  end
end
