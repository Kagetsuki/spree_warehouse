require 'spec_helper'

describe "Warehouses" do
  before(:each) do
    sign_in_as!(Factory(:admin_user))
    #user = Factory(:admin_user, :email => "admin@person.com", :password => "password", :password_confirmation => "password")
    Spree::Ability.register_ability(AbilityDecorator)

    @warehouse1 = Factory(:warehouse, :name => 'huge_warehouse_1')
    Factory(:warehouse, :name => 'huge_warehouse_2')

    #visit spree.login_path
    #fill_in "user_email", :with => user.email
    #fill_in "user_password", :with => user.password
    #click_button "Login"
    
    visit spree.admin_path
    click_link "Warehouses"
  end

  context "listing warehouses" do
    it "should list existing warehouses" do
      page.should have_css('table#warehouses')
      within("table#warehouses") do
        page.should have_content("huge_warehouse_1")
        page.should have_content("huge_warehouse_2")
      end
    end
  end
  
  context "adding new warehouse" do 
    before(:each) do 
      click_link "New Warehouse"
    end 

    it "you should be redirected to warehouses/new view when you hit new warehouse button" do
      page.should have_css('div#admin_warehouse_new_form')
      fill_in "warehouse_name", :with => Faker::Name.name
      click_button "Create"
      page.should have_content("Warehouse was successfully created.")
    end

    it "should give an error if name is not unique" do
      fill_in "warehouse_name" , :with => @warehouse1.name
      click_button "Create"
      page.should have_css('span.field_with_errors')
      page.should have_content("has already been taken")
      
    end
  end

end
