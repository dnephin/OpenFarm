module Guides
  class UpdateGuide < Mutations::Command
    include Guides::GuidesConcern

    required do
      string :id
      model :user
      model :guide
    end

    optional do
      string :overview
      string :name
      string :featured_image
    end

    def validate
      validate_permissions
      validate_image_url
    end

    def execute
      set_valid_params
      guide
    end

    def validate_permissions
      if guide.user != user
        # TODO: Make a custom 'unauthorized' exception that we can rescue_from
        # in the controller.
        add_error :user,
                  :unauthorized_user,
                  'You can only update guides that you own.'
      end
    end

    def set_valid_params
      # TODO: Probably a DRYer way of doing this.
      guide.overview       = overview if overview.present?
      guide.name           = name if name.present?
      guide.featured_image = featured_image if featured_image.present?
      guide.save
    end
  end
end
