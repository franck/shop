require 'spec_helper'

feature "Admin Home:" do

  describe "when I go to the admin panel" do
    it "shows the admin dashboard" do
      visit '/admin'
      expect(page).to have_content "Tableau de bord"
    end
  end

end
