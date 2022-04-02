class LeafsController < InheritedResources::Base
  
 

  def create
    @leaf = Leaf.new(leaf_params)
    if @leaf.save 
      redirect_to leafs_path
    else
      render new_leaf_path
    end
  end

  private
    def leaf_params
      params.require(:leaf).permit(:leave_type, :from_date, :till_date, :leave_starts, :leave_end, :total_days, :resion, :leave_status, :employee_id)
    end

end