class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string  :name
      t.text    :description
      t.text    :country
      t.text    :province
      t.text    :locality
      t.text    :address
      t.string  :status

      t.float   :latitude
      t.float   :longitude

      t.timestamps null: false
    end
  end
end
