require 'spec_helper'

describe "An Invitation" do
  describe "View page" do
    before do
      @guest1 = FactoryGirl.create :guest1
      @guest2 = FactoryGirl.create :guest2
      @invite1 = FactoryGirl.create :invitation
      @invite1.guests << @guest1 << @guest2
      @invite1.save
      @question1 = FactoryGirl.create :boolean_question
      @question2 = FactoryGirl.create :string_question
      @question3 = FactoryGirl.create :text_question

      visit invitation_path(@invite1)
    end

    context "for the first guest" do
      before { @guest_class = ".guest_#{@guest1.id}" }

      context "for the first question" do
        before { @question_class = ".question_#{@question1.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question1.label } }
        end

        it "shows a yes button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_button 'Yes' } }
        end

        it "shows a no button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_button 'No' } }
        end
      end

      context "for the second question" do
        before { @question_class = ".question_#{@question2.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question2.label } }
        end

        it "shows a text field" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "question_#{@question2.id}" } }
        end
      end

      context "for the third question" do
        before { @question_class = ".question_#{@question3.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question2.label } }
        end

        it "shows a text area" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "question_#{@question3.id}" } }
        end
      end
    end

     context "for the second guest" do
      before { @guest_class = ".guest_#{@guest2.id}" }

      context "for the first question" do
        before { @question_class = ".question_#{@question1.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question1.label } }
        end

        it "shows a yes button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_button 'Yes' } }
        end

        it "shows a no button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_button 'No' } }
        end
      end

      context "for the second question" do
        before { @question_class = ".question_#{@question2.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question2.label } }
        end

        it "shows a text field" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "question_#{@question2.id}" } }
        end
      end

      context "for the third question" do
        before { @question_class = ".question_#{@question3.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question2.label } }
        end

        it "shows a text area" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "question_#{@question3.id}" } }
        end
      end
    end   
  end
end
