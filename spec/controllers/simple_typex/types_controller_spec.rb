require 'spec_helper'

module SimpleTypex
  describe TypesController do
  
    before(:each) do
      controller.should_receive(:require_signin)
    end

    render_views
    
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
    end
    
    describe "GET 'index'" do
      it "returns all type" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SimpleTypex::Type.order('ranking_order')")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        ls = FactoryGirl.create(:simple_typex_type, :active => true, :last_updated_by_id => @u.id)
        ls1 = FactoryGirl.create(:simple_typex_type,:name => 'new', :active => false, :last_updated_by_id => @u.id)
        get 'index' , {:use_route => :simple_typex}
        assigns(:types).should =~ [ls, ls1] 
      end

    end
  
    describe "GET 'new'" do
      it "returns success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new' , {:use_route => :simple_typex}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "should create successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        ls = FactoryGirl.attributes_for(:simple_typex_type, :active => true, :last_updated_by_id => @u.id)
        get 'create' , {:use_route => :simple_typex, :type => ls}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' for data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        ls = FactoryGirl.attributes_for(:simple_typex_type, :active => true, :last_updated_by_id => @u.id, :name => nil)
        get 'create' , {:use_route => :simple_typex, :type => ls}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        ls = FactoryGirl.create(:simple_typex_type, :active => true, :last_updated_by_id => @u.id)
        get 'edit' , {:use_route => :simple_typex, :id => ls.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "returns update" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        ls = FactoryGirl.create(:simple_typex_type, :active => true, :last_updated_by_id => @u.id)
        get 'update' , {:use_route => :simple_typex, :id => ls.id, :type => {:name => 'newnewone'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'edit' with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'simple_typex_types', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        ls = FactoryGirl.create(:simple_typex_type, :active => true, :last_updated_by_id => @u.id)
        get 'update' , {:use_route => :simple_typex, :id => ls.id, :type => {:name => ''}}
        response.should render_template('edit')
      end
    end
  
  end
end
