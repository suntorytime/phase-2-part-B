require_relative "../spec_helper"

feature "writing a new post" do
  background(:each) do
    @previous_post = create(:post)
  end

  context "without javascript" do
    scenario "user navigates to post form, submits it, and sees the post", { js: false } do
      visit "/"
      expect(page).to have_content "Share Anything"
      expect(page).to have_content @previous_post.title
      click_link("Share Your Thoughts")


      expect(page).to have_content "Write Your Post"
      within("#post_form") do
        fill_in "post[title]", with: "Bright Idea"
        fill_in "post[author_name]", with: "Evelyn"
        fill_in "post[body]", with: "I've been doing a lot of thinking ..."
        find("input[name='submit']").click
      end

      expect(page).to have_content "The Post ..."
      expect(page).to have_content "Bright Idea"
      expect(page).to have_content "Evelyn"
      expect(page).to have_content "I've been doing a lot of thinking ..."
    end
  end
end
