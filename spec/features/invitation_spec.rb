require 'spec_helper'

describe "An Invitation" do
  describe "View page" do
    before do
      @guest1 = FactoryGirl.create :guest1
      @guest2 = FactoryGirl.create :guest2
      @invite1 = FactoryGirl.create :invitation
      @invite1.guests << @guest1 << @guest2
      @question1 = FactoryGirl.create :boolean_question
      @question2 = FactoryGirl.create :string_question
      @question3 = FactoryGirl.create :text_question
      @question4 = FactoryGirl.create :boolean_question, options: 'Please|Ouch'

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
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text 'Yes' } }
        end

        it "shows a no button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text 'No' } }
        end
      end

      context "for the fourth question" do
        before { @question_class = ".question_#{@question4.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question4.label } }
        end

        it "shows the custom 'yes' button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text 'Please' } }
        end

        it "shows the custom 'no' button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text 'Ouch' } }
        end
      end

      context "for the second question" do
        before { @question_class = ".question_#{@question2.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question2.label } }
        end

        it "shows a text field" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "answer_#{@question2.id}" } }
        end
      end

      context "for the third question" do
        before { @question_class = ".question_#{@question3.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question3.label } }
        end

        it "shows a text area" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "answer_#{@question3.id}" } }
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
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text 'Yes' } }
        end

        it "shows a no button" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text 'No' } }
        end
      end

      context "for the second question" do
        before { @question_class = ".question_#{@question2.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question2.label } }
        end

        it "shows a text field" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "answer_#{@question2.id}" } }
        end
      end

      context "for the third question" do
        before { @question_class = ".question_#{@question3.id}" }

        it "shows the question" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_text @question3.label } }
        end

        it "shows a text area" do
          within(:css, @guest_class) { within(:css, @question_class) { page.should have_field "answer_#{@question3.id}" } }
        end
      end
    end

    context "when the form is filled" do
      before do
        @guest_class = ".guest_#{@guest1.id}"
        within(:css, @guest_class) do 
          within(:css, ".question_#{@question1.id}") { choose "Yes" }
          fill_in "answer_#{@question2.id}", with: "radical"
          fill_in "answer_#{@question3.id}", with: "This is a good form."
        end
      end

      context "and submitted" do
        before do
          click_on('Save')
        end

        it "the form is no longer displayed" do
          page.should_not have_text @question1.label
        end

        context "and re-visiting the form" do
          before { visit invitation_url(@invite1) }

          it "the guest's first answer is updated" do
            within(:css, @guest_class) { within(:css, ".question_#{@question1.id}") { page.should have_checked_field "Yes" } }
          end

          it "the guest's second answer is updated" do
            page.should have_field "answer_#{@question2.id}", with: "radical"
          end
        end
      end
    end
  end
end
