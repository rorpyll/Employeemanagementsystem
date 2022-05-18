# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  # before_action :get_ip

  # def show_employee
  # end

  # def after_sign_in_path_for(resource_or_scope)
  # 	#Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  # ips = Ip.pluck(:unblockip)
  # #byebug
  # if ips.include?(request.ip)
  #  		destroy_employee_session_path
  #  	else
  #        	stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
  #  	end
  # end

  #    def get_ip
  #    	if UnblockIP.pluck(:id).includes?(request.ip)

  #    	else

  #    	end
  #    end

  rescue_from CanCan::AccessDenied do
    flash[:error] = 'Access denied!'
    redirect_to root_url
  end

  def current_user
    current_employee
  end

  def get_employee
    Employee.first
  end
end
