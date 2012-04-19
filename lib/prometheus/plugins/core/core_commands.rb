module Prometheus
  class Commands < Prometheus::Base
    include Thor::Actions
    source_root TEMPLATES_PATH
    # Tasks added here will be available in all generated Prometheus applications.
  end
end
