# Progress 360

## Requirements

* Ruby 1.9.3 (Pearson servers use 1.9.3-p484)
* Node ~0.10 (for asset compilation)
* bower
* MySQL
* bundler

## Installing the app

If you already have node and bower you can skip the following.

    brew install nodejs
    npm install bower -g

if you are starting from *scratch* on a new machine (no ruby)
you will need to get your machine setup:
https://wiki.unboxedconsulting.com/wiki/Mac_Dev_Environment_-_Mountain_Lion

Then...

    bundle
    bower install
    # imagemagick required for image-resizing
    brew install imagemagick 
    # PhantomJS required to run headless test
    brew install phantomjs
    cp config/database.yml.example config/database.yml
    cp config.ru.example config.ru
    rake db:create:all
    rake db:migrate
    rake db:seed
    rails s

## Running the tests:

### JavaScript
    rake spec:javascript

or visit `/spec` in the app

## Setting up S3
    cp config/carrierwave.yml.example config/carrierwave.yml
The S3 credentials can be found on the Jira ticket for creating the environment
(ML-51: http://jira.pearson.com/browse/ML-51). Add the to the yml file.

## Adding learner credentials

See the corresponding seed file for detailed instructions: db/seeds/learners.rb
If you don't have account details you can use the test user credentials:
Email: t@example.com
Password: Aloof-Ruler4begin

## Git Branching Strategy

We are using the git flow branching strategy. Builds will be run from the develop branch. Please work on new stories using a feature branch.
https://github.com/nvie/gitflow
http://nvie.com/posts/a-successful-git-branching-model/




## A Simple Change README Driven Development (RDD)

> http://tom.preston-werner.com/2010/08/23/readme-driven-development.html

Add Description to the Activities Modle/Table as per ML-70
http://jira.pearson.com/secure/RapidBoard.jspa?rapidView=421&view=detail&selectedIssue=ML-70

Design: http://jira.pearson.com/secure/attachment/73577/131127-newAchievementDialogue.png

### Add Description Test to Spec

in the file spec/models/**achievement_spec.rb**

Add a test in the validations:
```ruby
    it 'Does NOT require a description' do
      expect(Achievement.make(:description=> "")).to be_valid
    end
```

Run the spec and watch it fail:
```sh
rspec spec/models/achievement_spec.rb
```
should see something like: 
```sh
Failure/Error: expect(Achievement.make(:description=> "")).not_to be_valid
# ./spec/models/achievement_spec.rb:16:in `block ...
6 examples, 1 failure
```

### Adding a Field to a Model/Table

```sh
rails g migration add_description_to_achievements description:string
rake db:migrate
```
Rerun the spec should pass now:
```sh
rspec spec/models/achievement_spec.rb
```

Rusty on Rails Migrations?
- Quick guide: http://stackoverflow.com/questions/4834809/adding-a-column-to-a-table-in-rails
- More Detail: http://guides.rubyonrails.org/migrations.html

### Add the Field to the View

#### Data Entry

First we need to add the field to the input form.
The file to edit is: app/views/achievements/_form.html.erb

```ruby
<%= f.label :description %>
<%= f.text_field :description %>
```
This just adds the label and field to our achievement creation form.

#### Tell the Controller to Permit Form Submissions with the New Field

Find the line that specifies which fiels a user can submit:
```rb
  def permitted_params
    params.permit(:achievement => [:name])
  end
```
And add the description field to the array:
```rb
  def permitted_params
    params.permit(:achievement => [:name, :description])
  end
```

#### Display

Now we add it to the view that is *dispalying* our achievements:
app/views/achievements/_achievement.html.erb
```ruby
<%= f.label :description %>
<%= f.text_field :description %>
```

#### *Quick Create* (Without Leaving the Page)

To allow the learner to create their achievements from the dashboard
we need to add the achievements/form to views/dashboard/index.html.erb

```html
<!-- include partial: _form.html.erb -->
<div class="achievement-inline-form">
    <%= form_for Achievement.new do |f| %>
      <%= render 'achievements/form', :f => f %>
    <% end %>
</div>
```
I wrapped the form in a <div> with a class of **achievement-inline-form**
so we can style the inline form without affecting other instances of the form.

#### Placeholder Text

The designs for inline achievement creation removes the labels from the input
fields and instead has placeholder text.

In the achievements form app/views/achievements/_form.html.erb
we need to add the placeholder text:

```ruby
<%= f.text_field :name, 
:placeholder => 'What do you want to call your achievement?'%>
...
<%= f.text_field :description, 
:placeholder => 'Describe your achievement'%>
```

Rather than hiding the labels in the form I will only hide them for 
the inline form (in CSS)

Make sure the achievements.scss SASS file is imported in application.scss:

```css
@import "modules/achievements";
```

Capybara Cheet Sheet:
https://gist.github.com/zhengjia/428105