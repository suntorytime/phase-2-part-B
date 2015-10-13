get "/posts" do
  @posts = Post.order("created_at DESC")
  erb :'posts/index'
end

post "/posts" do
  @post = Post.new(params[:post])
  @post.save
  if request.xhr?
    content_type :json
    # p "In the /posts"
    {id: @post.id, title: @post.title, author_name: @post.author_name, body: @post.body }.to_json
  else
    redirect "posts/#{@post.id}"
  end
end

get "/posts/new" do
  @post = Post.new
  if request.xhr?
    erb :'/posts/new', layout: false
    # p erb :'posts/_post', { layout: false, locals: {:post => post }}
  else
    erb :'posts/new'
  end
end

get "/posts/:id" do
  @post = Post.find(params[:id])
  erb :'posts/show'
end
