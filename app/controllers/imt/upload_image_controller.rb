module Imt
  class UploadImageController < ApplicationController
    skip_before_filter :all
    # require "RMagick"
    # include CarrierWave::RMagick


    def index
    end

    def get_file
      session["file1"] = nil
      session["operations"] = []
      session["file_name"] = "/assets/"+ params[:image].original_filename
      img = params[:image]
      session["location"] = Rails.root.join('app/assets/images',img.original_filename).to_s
      File.open(Rails.root.join('app/assets/images',img.original_filename),'wb') do |file| 
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
       # session["dd"] = StringIO.new(painting1.to_blob)
       @params=[params[:x],params[:y], params[:w], params[:h], params[:r]]
       session[:rotation] = params[:r].to_i or 0
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
    # response.headers["Content-type"] = painting1.mime_type
      # session[:blob_data] = painting1.to_blob
      # render :file => 
      # send_data(@fff, :type => painting1.mime_type,:disposition => 'inline')# (painting1.to_blob)
      # send =>"<img src= '"+ painting1.to_blob + "'/>"
       # format.js   { send_data @fff, :type => painting1.mime_type,:disposition => 'inline' }
      # render :layout=>false
      respond_to do |format|  
      format.html {render :partial => "preview", :layout => false }  
      format.js { render :html=>"<%= image_tag show_blob_image_upload_image_index_path(@params) %> " }#  { render :text =>  painting1.to_blob   }  
    end     
       
    end

    def show_blob_image
      image =get_image #session["dd"].data
      format = params[:format] || [0,0,0,0]
      if format[2].to_i > 0 && format[3].to_i > 0 
        cropped_image = image.crop(format[0].to_i,format[1].to_i ,format[2].to_i, format[3].to_i)
      end
      cropped_image = cropped_image || image
      cropped_image  = cropped_image.rotate(format[4].to_i)
      cropped_image  = cropped_image.flip if format[5] == "flip"     
      cropped_image  = cropped_image.flop if format[5] == "flop" 
          
      # cropped_image = img_operation cropped_image, format
      render :text=>cropped_image.to_blob #session[:blob_data]
    end
    
    def flip
      @params=[params[:x],params[:y], params[:w], params[:h], params[:r],"flip"]
      image = get_image
      respond_to do |format|  
        format.html {render :partial => "preview", :layout => false }  
        format.js { render :js=>"<%= image_tag show_blob_image_upload_image_index_path(@params) %> "} #  { render :text =>  painting1.to_blob   }  
      end  
    end
    def save_it
       image = get_image
       format=[params[:x],params[:y], params[:w], params[:h], params[:r],params[:f]]
       cropped_image = image.crop(format[0].to_i,format[1].to_i ,format[2].to_i, format[3].to_i)
       cropped_image  = cropped_image.rotate(format[4].to_i)
       cropped_image  = cropped_image.flip if format[5] == "flip"     
       cropped_image  = cropped_image.flop if format[5] == "flop" 
       @cropped_image = cropped_image.to_blob
       cropped_image.write(session["location"])
       respond_to do |format|

        format.js {render :layout=>false} 
       end
    end
    def flop
      @params=[params[:x],params[:y], params[:w], params[:h], params[:r],"flop"]
      session["operations"] << "flop"
      image = get_image
      respond_to do |format|  
        format.html {render :partial => "preview", :layout => false }  
        format.js { render :html=>"<%= image_tag show_blob_image_upload_image_index_path(@params) %> " } #  { render :text =>  painting1.to_blob   }  
      end  
    end
    def rotate
      @params=[params[:x],params[:y], params[:w], params[:h], params[:r]]
      session["operations"] << "rotate"
      respond_to do |format|  
        format.html {render :partial => "preview", :layout => false }  
        format.js #{ render :html=>"<%= image_tag show_blob_image_upload_image_index_path(@params) %> " } #  { render :text =>  painting1.to_blob   }  
      end   
    end

    def get_image
      painting1 = Magick::Image.read(session["location"]).first
    end
unloadable
  end  
end
