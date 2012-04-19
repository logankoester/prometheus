require 'bundler/gem_tasks'

module Rake
  def self.remove_task(task_name)
    Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
  end
end

Rake.class_eval do
  remove_task 'release'
end
