require 'spec_helper'

describe "FormBuilder" do
  let(:mock_learner) { mock_model(Learner) }
  subject { FormBuilder.new(:learner, mock_learner, self, {}, nil) }

  describe 'label' do
    describe "without specifying the human readable name" do
      describe "without using a block" do
        it 'contains the label' do
          expect(subject.label :age, class: 'field').to have_xpath("//label[@class=\"field\"][@for=\"learner_age\"]")
        end

        it 'wraps the human readable field name in a span' do
          markup = subject.label :age, class: 'field'
          expect(markup).to have_xpath("//label/span[@class=\"sub-heading\"][contains(., \"Age\")]")
        end
      end
      describe "using a block" do
        it 'contains the label' do
          markup = subject.label :age, class: 'field' do "foo" end
          expect(markup).to have_xpath("//label[@class=\"field\"][@for=\"learner_age\"][contains(text(), \"foo\")]")
        end

        it 'wraps the human readable field name in a span' do
          markup = subject.label :age, class: 'field' do "foo" end
          expect(markup).to have_xpath("//label/span[@class=\"sub-heading\"][contains(., \"Age\")]")
        end
      end
    end
    describe "with specifying the human readable name" do
      describe "without using a block" do

        it 'contains the label' do
          expect(subject.label :favourite_things, '3 favourite things', class: 'field').to have_xpath("//label[@class=\"field\"][@for=\"learner_favourite_things\"]")
        end

        it 'wraps the human readable field name in a span' do
          markup = subject.label :favourite_things, '3 favourite things', class: 'field'
          expect(markup).to have_xpath("//label/span[@class=\"sub-heading\"][contains(., \"3 favourite things\")]")
        end
      end
      describe "using a block" do
        it 'contains the label' do
          markup = subject.label :favourite_things, '3 favourite things', class: 'field' do
            text_field_tag(:foo)
          end
          expect(markup).to have_xpath("//label[@class=\"field\"][@for=\"learner_favourite_things\"]/input[@id=\"foo\"][@name=\"foo\"][@type=\"text\"]")
        end

        it 'wraps the human readable field name in a span' do
          markup = subject.label :favourite_things, '3 favourite things', class: 'field' do "foo" end
          expect(markup).to have_xpath("//label/span[@class=\"sub-heading\"][contains(., \"3 favourite things\")]")
        end
      end
    end
  end
end
