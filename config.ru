require_relative './config/environment'

use Rack::MethodOverride

#use or run application controllers here

use MusicianController
use SectionController 
use ProgramController
run ApplicationController