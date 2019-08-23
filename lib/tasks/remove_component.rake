namespace :component do
  # Remove components
  # rails components:rm <component>
  task rm: :environment do
    ARGV.each { |a| task a.to_sym do ; end }

    # abort('Error Syntax: rails trailblazer:rm_component component_name')
    remove_components
    puts "Nothing changes" unless @is_remove
  end

  def remove_components
    return unless File.exist? component_path
    @is_remove = true
    puts "remove #{component_path}"
    FileUtils.rm_rf(component_path)
  end

  def component_name
    ARGV.last
  end

  def component_path
    Rails.root.join('app', 'javascript', 'components', component_name).to_path
  end
end
