class GuideSerializer < ApplicationSerializer
  attributes :_id, :crop_id, :user_id, :stages, :requirements,
             :name, :overview, :featured_image

  def featured_image
    object.featured_image.url
  end
end
