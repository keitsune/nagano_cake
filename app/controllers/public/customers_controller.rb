class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
<<<<<<< HEAD
    @customer = current_customer
    if @customer.update
     redirect_to customers_path
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
=======
    
  end

  def unsubscribe
  end

  def withdraw
>>>>>>> 0c8883a683847de0535243a6a51641cdef56f7ed
  end


end
