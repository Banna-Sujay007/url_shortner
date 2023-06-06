ActiveAdmin.register Url do
  permit_params :long_url, :short_url

  index do
    selectable_column
    id_column
    column :long_url
    column :short_url
  end

  form do |f|
    f.inputs 'URL Details' do
      f.input :long_url
      f.input :short_url
    end
    f.actions
  end
end

