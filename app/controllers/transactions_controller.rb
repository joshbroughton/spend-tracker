class TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :update_category, :change_category ]
  require "csv"

  def index
    @categories = Category.all
    # base query
    @transactions = Transaction.all

    # Filter transactions by category if a category_id is passed
    if params[:category_id].present?
      @transactions = @transactions.where(category_id: params[:category_id])
    end

    if params[:sort].present?
      @transactions = @transactions.order("#{params[:sort]} #{params[:direction]}")
    end
  end

  def upload
    if params[:file].present?
      file = params[:file].tempfile

      # Parse the CSV file
      transactions = []

      begin
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          # Parse each row into a hash with symbolized keys (e.g., :date, :transaction, etc.)
          transactions << {
            date: row[:date],
            transaction_type: row[:transaction],
            description: row[:description],
            amount: row[:amount].to_f,
            balance: row[:balance].to_f,
          }
        end

        transactions.each do |transaction|
          Transaction.create!(transaction
          )
        end

        flash[:notice] = "#{transactions.size} transactions parsed successfully."
      rescue CSV::MalformedCSVError => e
        flash[:alert] = "There was an error parsing the CSV file: #{e.message}"
      end
        flash[:notice] = "#{transactions.size} transactions parsed successfully."
      redirect_to upload_transactions_path
    else
      flash[:alert] = "Please choose a file to upload."
    end
  end

  def change_category
    @categories = Category.all
    render partial: "category_form", locals: { transaction: @transaction }
  end

  def update_category
    if @transaction.update(transaction_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("transaction_#{@transaction.id}_category", partial: "transactions/category", locals: { transaction: @transaction }) }
        format.html { redirect_to transactions_path, notice: "Transaction updated." }
      end
    else
      render :edit
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :category_id)
  end
end
