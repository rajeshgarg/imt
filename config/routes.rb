Rails.application.routes.draw do  
 
  resources :paintings
  resources :upload_image do    
    collection do
      get 'preview'
      get 'show_blob_image'
      get 'rotate'
      get 'flip'
      get 'flop'
      get 'save_it'
    end
    
  end
  resources :upload_images do    
    collection do
      get 'preview'
      get 'show_blob_image'
      get 'rotate'
      get 'flip'
      get 'flop'
      get 'save_it'
    end
  end
  resources :galleries do
    collection do
      # get 'show_blob_image'
      get 'preview'
      get 'rotate'
      post 'get_file'
      get 'get_file'
    end
  end
  
end