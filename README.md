# README

This is a Pinterest-clone following the tutorial by [Mackenzie Child](https://mackenziechild.me/) in his
[12-apps-in-12-weeks](https://mackenziechild.me/12-in-12/) series.  
* The video for the tutorial is located here: [Week 12: How To Build A Dribble Type App With Rails 4](https://mackenziechild.me/12-in-12/12/)
* Mackenzie's GitHub repo for this project is here: [muse](https://github.com/mackenziechild/muse)



* As a reminder, when generating a model, I don't have to specify the type if it is a string:
```shell
rails g model Post title link description:text
rails db:migrate
```
* maybe try adding each action and view at a time...let the errors guide what you develop next?
* I have to make a flash card or something to just remember this:
```ruby
def post_params
	params.require(:post).permit(:title, :link, :description)
end

def find_post
	@post = Post.find(params[:id])
end
```
#### ~23:12
* by this time, nothing that we've done thus far is that groundbreaking.  We are creating the actions and the views
and I have now (after 12 apps!) gotten a good handle on the basic rhythm of creating the foundation for the app. 
* We are now going to add Users
#### ~26:30
* We have completed the Devise set-up (added Users) but now we need to set it up so that all new posts are attached to
a user.
* To start, we create a migration to add a user_id column to posts
```shell
rails g migration add_user_id_to_post user_id:integer
```
* Double check the migration file before rails db:migrate
* complete the association by adding the necessary code to each model
* Take a look at the new 'new' and 'create' actions. How do they stack up to what is in Michael Hartl's Rails Tutorial?
```ruby
def new
	@post = current_user.posts.build
end

def create
	@post = current_user.posts.build(post_params)

	if @post.save
		redirect_to @post
	else
		render 'new'
	end
end
```
* User authentication:
```ruby
before_action :authenticate_user!, except: [:show, :index]
```
* Now, we want to modify the User model so that there is a name field:
```shell
rails g migration add_name_to_user name:string
```
* I made a minor mistake, hopefully I was able to reverse it:
```shell
rails g devise views
```
  * ths above is wrong; I wanted 'rails g devise:views'.  This is how I reversed it:
```shell
rails destroy devise views
```
* I also changed the application_controller file:
```ruby
before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
	# sign_up and account_update are the things that I am adding name to (as part of authentication)
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name])
end
```



