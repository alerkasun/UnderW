ActiveAdmin.register Certificate do
  permit_params :subject, :issuer, :valid_until, :subject_alt_names, :cert_hash, :default, :certificate_file

  index do
    column :id do |cert|
      link_to cert.id, [:admin, cert]
    end
    column :subject
    column :issuer
    column :valid_until
    column :subject_alt_names
    column :cert_hash do |cert|
      cert.cert_hash.truncate 20
    end
    column :default
    actions
  end


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do

      tab 'Upload Cert' do
        f.inputs do
          f.input :certificate_file, as: :file
        end

      end

      tab 'Manually enter details' do
        f.inputs do
          f.input :subject
          f.input :issuer
          f.input :valid_until
          f.input :subject_alt_names
          f.input :cert_hash
          f.input :default, label: "Mark this as the new default certificate?"
        end
      end
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
