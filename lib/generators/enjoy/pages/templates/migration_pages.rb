class EnjoyPagesCreatePages < ActiveRecord::Migration
  def change
    create_table :enjoy_pages_menus do |t|

      if Enjoy.config.localize
        t.column :name_translations, 'hstore'
      else
        t.string :name, null: false
      end
      t.string :slug, null: false
      t.timestamps
    end
    add_index :enjoy_pages_menus, :slug, unique: true

    create_table :enjoy_pages_pages do |t|
      t.boolean :enabled, default: true, null: false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      if Enjoy.config.localize
        t.column :name_translations, 'hstore', default: {}
        t.column :content_html_translations, 'hstore', default: {}
        t.column :content_clear_translations, 'hstore', default: {}
      else
        t.string :name, null: false
        t.text :content
      end

      t.string :slug, null: false
      t.string :regexp
      t.string :redirect
      t.string :fullpath, null: false
      t.timestamps
    end
    add_index :enjoy_pages_pages, :slug, unique: true
    add_index :enjoy_pages_pages, [:enabled, :lft]


    ######### pages <-> menus join table #############

    create_join_table :enjoy_pages_menus, :enjoy_pages_pages, table_name: :enjoy_pages_menu_pages

    add_foreign_key(:enjoy_pages_menu_pages, :enjoy_pages_menus, dependent: :delete)
    add_foreign_key(:enjoy_pages_menu_pages, :enjoy_pages_pages, dependent: :delete)
  end
end
