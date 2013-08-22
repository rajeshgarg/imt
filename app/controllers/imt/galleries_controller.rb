module Imt
  class GalleriesController < ApplicationController
    def index1
      @galleries = Gallery.all
    end

    def show
      @gallery = Gallery.find(params[:id])
      @p=[]
      for painting in @gallery.paintings do
        s = painting.image_url(:thumb) if painting.image? 
        @p << Magick::Image.read("public"+s).first
      end
      @im = get_image
      # perview @gallery
    end
    def get_file
      session["file1"] = nil
      session["operations"] = []
      session["file_name"] = "/images/"+ params[:image].original_filename
      img = params[:image]
      session["location"] = Rails.root.join('public/images',img.original_filename).to_s
      File.open(Rails.root.join('public/images',img.original_filename),'wb') do |file| 
        file.write(img.read) 
      end     
      session["file1"] = session["file_name"] 
      respond_to do |format|
        # format.js {render :text => "$('.logo').html(\"<img src='#{session["file1"].to_s}'>\")" }
        format.js {render :layout=>false} 

        # format.js {render :json => {:result => ["#{session["file1"].to_s}"]}.to_json }
        format.html {render :text=>"ok"}
      end
    end

    def preview
      painting1 = get_image
       @params=[params[:x],params[:y], params[:w], params[:h], params[:r]]
      #session[:rotation] = params[:r].to_i or 0
      # painting1 = painting1.rotate(-90)  # for anti clockrotating the image
      # painting1 = painting1.rotate(90)  # for clock rotating the image

      # painting1 = painting1.flip # to flip image virtically
      # painting1 = painting1.transpose # to flip image virtically
      # painting1 = painting1.flop # to flip image virtically
       # painting1 =  new_image_list
      # painting1 = painting1.crop!(10, 10, 21, 26) # crop image 
      # painting1 = croped painting1
      # painting1 = painting1.resize_to_fit(100,100)  
      # painting1 = painting1.cycle_colormap(1)
      # painting1 = painting1.resize(250,250)          
        # painting1.format
      #response.headers["Content-type"] = painting1.mime_type
      # session[:blob_data] = painting1.to_blob
      # render :file => 
      # send_data(@fff, :type => painting1.mime_type,:disposition => 'inline')# (painting1.to_blob)
      # send =>"<img src= '"+ painting1.to_blob + "'/>"
       # format.js   { send_data @fff, :type => painting1.mime_type,:disposition => 'inline' }
       #result = show_blob_image_galleries_path(@params)
      respond_to do |format|  
        format.html {render :partial => "preview", :layout => false }  
        format.js   #{ render :text =>  result   }  
      end     
       
    end
    
    def rotate
       
      session[:rotation] = params[:r].to_i or 0
      @params=[params[:x],params[:y], params[:w], params[:h],session[:rotation] ]
      @image = crope_image @params
      respond_to do |format|  
        format.html {render :partial => "preview", :layout => false }  
        format.js   #{ render :text =>  result   }  
      end  
      
    end


    def show_blob_image
       cordinates = params[:format] || [0,0,0,0]
       image = crope_image cordinates
       image = image.resize_to_fit(19,14)
      render :text=>"image.to_blob"
    end

    def get_image
      gallery = Gallery.find 2
      painting = gallery.paintings.last
      image = Magick::Image.read("public" + painting.image_url(:thumb)).first if painting.image?
      img_data = Abc.new
      
       # file = StringIO.new(image.to_blob)
       # debugger
      # file = (FileString.new(image.to_blob))
      img_data.data = image
      img_data
    end
    
    def crope_image cordinates
      # image = session["dd"].data
      image = get_image.data
      response.headers["Content-type"] = image.mime_type
      format = cordinates || [0,0,0,0]
      if format[2].to_i > 0 && format[3].to_i > 0 
      cropped_image = image.crop(format[0].to_i,format[1].to_i ,format[2].to_i, format[3].to_i)
      end
      cropped_image = cropped_image || image
      cropped_image = cropped_image.rotate(format[4].to_i)
    end


    def new
      @gallery = Gallery.new
    end

    def create
      @gallery = Gallery.new(params[:gallery])
      if @gallery.save
        flash[:notice] = "Successfully created gallery."
        redirect_to @gallery
      else
        render :action => 'new'
      end
    end

    def edit
      @gallery = Gallery.find(params[:id])
    end

    def update
      @gallery = Gallery.find(params[:id])
      if @gallery.update_attributes(params[:gallery])
        flash[:notice] = "Successfully updated gallery."
        redirect_to gallery_url
      else
        render :action => 'edit'
      end
    end

    def destroy
      @gallery = Gallery.find(params[:id])
      @gallery.destroy
      flash[:notice] = "Successfully destroyed gallery."
      redirect_to galleries_url
    end
    unloadable
  end
end