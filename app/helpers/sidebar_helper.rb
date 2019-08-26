module SidebarHelper
  def sidebar(type)
    data =
      case type
      when :other then data_other
      when :group then data_group
      when :user  then data_user
      end
    content_tag :ul, safe_join(list_items(data)), class: 'nav flex-column'
  end

  private

  # text: I18n.t('.helpers.view.create_project'),
  # path: new_translation_path,
  # controller: 'translations#new',
  # icon: 'fa icon icon-language'
  def data_other
    [
      {
        text: I18n.t('sidebar.area'),
        path: areas_path,
        controller: %w[areas#new areas#index areas#edit]
      },
      {
        text: I18n.t('sidebar.device'),
        path: devices_path,
        controller: %w[devices#new devices#index devices#edit]
      },
    ]
  end

  def data_group
    [
      {
        text: I18n.t('sidebar.group'),
        path: groups_path,
        controller: %w[groups#new groups#index groups#edit]
      }
    ]
  end

  def data_user
    [
      {
        text: I18n.t('sidebar.user'),
        path: users_path,
        controller: %w[users#new users#index users#edit]
      }
    ]
  end

  def list_items(data)
    data.map do |item|
      content_tag :li, class: 'nav-item' do
        concat link_to_tag item
      end
    end
  end

  def link_to_tag(option)
    link_to option[:path], class: "nav-link #{active(option)}", target: option[:target] do
      concat content_tag :i, nil, class: option[:icon]
      concat option[:text]
    end
  end

  def active(options)
    path            = @controller_data[:path]
    controller_name = @controller_data[:controller_name]
    action_name     = @controller_data[:action_name]
    active_class = 'deactivate'
    Array(options[:controller]).each do |controller|
      resource        = controller.try(:split, '#')
      ctr             = resource.first
      act             = resource.last
      active_class = 'active' if (ctr == controller_name || ctr == path) && act == action_name
    end
    active_class
  end
end
