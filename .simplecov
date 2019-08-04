SimpleCov.start do
  add_group 'Actions', 'app/actions'
  add_group 'API', 'app/api'
  add_group 'Entities', 'app/entities'
  add_group 'Models', 'app/models'
  add_group 'Organizers', 'app/organizers'

  add_filter 'config'
  add_filter 'spec'
  add_filter 'app/jobs'
  add_filter 'app/channels'
  add_filter 'app/mailers'
end
