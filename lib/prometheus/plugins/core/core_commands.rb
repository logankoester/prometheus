module Prometheus
  class Commands < Prometheus::Base
    include Thor::Actions

    full_name 'Prometheus Shell'
    namespace :prometheus
    source_root TEMPLATES_PATH

    # Tasks added here will be available in all generated Prometheus applications.

  end
end
