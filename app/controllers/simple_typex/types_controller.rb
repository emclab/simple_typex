require_dependency "simple_typex/application_controller"

module SimpleTypex
  class TypesController < ApplicationController
    before_filter :require_employee
    
    def index
      @title = 'Type Definitions'  
      @types = params[:simple_typex_types][:model_ar_r].page(params[:page]).per_page(@max_pagination)  
      @erb_code = find_config_const('type_index_view', 'simple_typex')   
    end
  
    def new
      @title = 'New Type Definition'
      @type = SimpleTypex::Type.new
      @erb_code = find_config_const('type_new_view', 'simple_typex') 
    end
  
    def create
      @type = SimpleTypex::Type.new(params[:type], :as => :role_new)
      @type.last_updated_by_id = session[:user_id]
      if @type.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @erb_code = find_config_const('type_new_view', 'simple_typex')
        flash.now[:error] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = 'Edit Type Definition'
      @type = SimpleTypex::Type.find_by_id(params[:id])
      @erb_code = find_config_const('type_edit_view', 'simple_typex')
    end
  
    def update
      @type = SimpleTypex::Type.find_by_id(params[:id])
      @type.last_updated_by_id = session[:user_id]
      if @type.update_attributes(params[:type], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('type_edit_view', 'simple_typex')
        flash.now[:error] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
    
  end
end
