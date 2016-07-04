Enjoy.configure do |config|
  config.ability_manager_config ||= []
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Pages::Page,
    actions: [:show, :read, :new, :create, :edit, :update, :nested_set]
  }
  config.ability_manager_config << {
    method: :cannot,
    model: Enjoy::Pages::Menu,
    actions: :manage
  }
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Pages::Blockset,
    actions: [:show, :read, :new, :create, :edit, :update, :sort_embedded]
  }
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Pages::Block,
    actions: [:show, :read, :new, :create, :edit, :update]
  }

  config.ability_admin_config ||= []
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Pages::Page,
    actions: :manage
  }
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Pages::Menu,
    actions: :manage
  }
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Pages::Blockset,
    actions: :manage
  }
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Pages::Block,
    actions: :manage
  }
end


Enjoy.rails_admin_configure do |config|
  config.action_visible_for :nested_set, 'Enjoy::Pages::Page'
  if Enjoy::Pages.active_record?
    config.action_visible_for :nested_set, 'Enjoy::Pages::Blockset'
  end

  if Enjoy::Pages.mongoid?
    config.action_visible_for :sort_embedded, 'Enjoy::Pages::Blockset'
  end

  config.action_visible_for :toggle_menu, 'Enjoy::Pages::Page'

  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Enjoy::Pages::Menu'
    config.action_visible_for :comments, 'Enjoy::Pages::Page'
    config.action_visible_for :comments, 'Enjoy::Pages::Blockset'
    config.action_visible_for :model_comments, 'Enjoy::Pages::Menu'
    config.action_visible_for :model_comments, 'Enjoy::Pages::Page'
    config.action_visible_for :model_comments, 'Enjoy::Pages::Blockset'
    if Enjoy::Pages.active_record?
      config.action_visible_for :comments, 'Enjoy::Pages::Block'
      config.action_visible_for :model_comments, 'Enjoy::Pages::Block'
    end
  end
end


if defined?(RailsAdmin)
  RailsAdmin.config do |config|
    config.excluded_models ||= []
    if Enjoy::Pages.mongoid?
      config.excluded_models << [
        # 'Enjoy::Pages::Block'
      ]
    end
    config.excluded_models.flatten!
  end
end
