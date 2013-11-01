module SimpleTypex
  class Type < ActiveRecord::Base
    attr_accessor :active_noupdate
    attr_accessible :active, :brief_note, :last_updated_by_id, :name, :ranking_order,
                    :active_noupdate,
                    :as => :role_new
    attr_accessible :active, :brief_note, :last_updated_by_id, :name, :ranking_order,
                    :active_noupdate,
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates :name, :presence => true,
                     :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Name!')}
  end
end
