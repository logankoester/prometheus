module Prometheus
  class Commands < Prometheus::Base
    include Thor::Actions
    source_root File.expand_path('../../../../templates', __FILE__)
    # Tasks added here will be available in all generated Prometheus applications.
  end
end
