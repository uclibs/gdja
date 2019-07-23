require Hyrax::Engine.root.join('app/controllers/hyrax/downloads_controller.rb')
module Hyrax
  class DownloadsController < ApplicationController

    private

    # make pdf downloads inline to display in browser

		def content_options        
			if file.mime_type == 'application/pdf'
				super.merge(disposition: 'inline')          
			else 
				super.merge(disposition: 'attachment')
			end
		end
  end
end
