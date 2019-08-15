SimpleCov.start do
  add_group 'API', 'app/api'
  add_group 'Entities', 'app/entities'
  add_group 'Models', 'app/models'
  add_group 'Macro Mutations', 'app/macro_mutations'
  add_group 'Mutations', 'app/mutations'
  add_group 'Extensions', 'lib/extensions'
  add_group 'Utils', 'lib/utils'

  add_filter 'config'
  add_filter 'spec'
  add_filter 'app/jobs'
  add_filter 'app/channels'
  add_filter 'app/mailers'
end
