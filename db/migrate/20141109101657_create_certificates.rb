class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :subject
      t.string :issuer
      t.datetime :valid_until
      t.string :subject_alt_names
      t.string :cert_hash
      t.boolean :default, default: false

      t.timestamps
    end
    add_index :certificates, :default
  end
end
