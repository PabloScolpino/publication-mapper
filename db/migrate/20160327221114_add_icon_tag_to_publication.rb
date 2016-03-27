class AddIconTagToPublication < ActiveRecord::Migration
  def change
    add_reference :publications, :icon_tag
  end
end
