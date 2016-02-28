RailsAdmin.config do |config|
  # config.included_models = ["Product", "Slide"]
  config.excluded_models = ["PiggybakVariants"]
  config.authenticate_with do
      warden.authenticate! scope: :admin
    end
  config.current_user_method(&:current_admin)

  def get_name
    "Image #{self.id}: #{self.alt}"
  end

  config.model Slide do
    edit do
      field :header
      field :sub_header
      field :body
      field :url
      field :button_name
      include_all_fields
    end
  end
  config.model Product do
    edit do
      field :name
      field :description, :froala
      include_all_fields
    end
  end
  config.model Image do
    object_label_method do
      :get_name
    end
    edit do
      field :asset
      field :alt do
        label "Title"
      end
    end
  end
  config.model Page do
    edit do
      field :title
      field :header
      field :content, :froala
      include_all_fields
    end
  end
  # config.model OptionValue do
  #   edit do
  #     # field
  #   end
  # end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
