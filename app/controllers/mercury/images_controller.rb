class Mercury::ImagesController < MercuryController

  respond_to :json, :html

  # POST /images.json
  def create
    @image = Mercury::Image.new(params[:image])
    @image.save
    respond_with @image
  end

  # DELETE /images/1.json
  def destroy
    @image = Mercury::Image.find(params[:id])
    @image.destroy
    respond_with @image
  end

  def update
    @image = Mercury::Image.where(:id=>params[:id]).first
    @image.update_attributes(params[:mercury_image])
    respond_to do |format|
      format.json { respond_with_bip(@image) }
    end
  end

  def index
    @images = Mercury::Image.order("updated_at desc").paginate(:per_page=>10, :page=>params[:page])
    @images = @images.where(' tags like "%' + params[:search][:search] + '%" or image_file_name like "%' + params[:search][:search] + '%"') if params[:search]
    render :layout=>"popup"
  end
end
