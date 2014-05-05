module ApplicationHelper
	def flash_to_toastr
    if flash
    	html = '<script>'
    	flash.each do |type, message|
    		if type == 'notice'
    			html += "toastr.success('#{message}');"
    		elsif type == 'alert'
    			html += "toastr.warning('#{message}');"
    		elsif type == 'error'
    			html += "toastr.error('#{message}');"
    		end
    	end
    	return (html + '</script>').html_safe
    end
	end
end
