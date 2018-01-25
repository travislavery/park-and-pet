require './config/environment'

if ActiveRecord::Migrator.needs_migration?
	raise 'Migrations are pending. Run `rake db:migrate`.'
end

use Rack::MethodOverride

use ParksController
use PetsController
use OwnersController
run ApplicationController