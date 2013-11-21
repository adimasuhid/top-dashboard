Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

module CustomSpecHelper
  include UsersSpecHelper
  include TimeLogsSpecHelper
end
