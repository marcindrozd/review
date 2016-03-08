desc 'Remove a project'
task :remove_project, [:project_name] => :environment do |t, args|
  projects_with_name = fetch_projects(args.project_name)
  projects_with_name.destroy_all
  puts "Project with name '#{args.project_name}' was successfully removed."
end

def fetch_projects(name)
  projects_with_name = Project.where(name: name)
  fail ArgumentError, wrong_params_hint_message(name) if projects_with_name.count == 0
  projects_with_name
end

def wrong_params_hint_message(name)
  "The project '#{name}' doesn't exist. Try to pass parameters as follows: rake 'remove_project[facebook]'"
end
