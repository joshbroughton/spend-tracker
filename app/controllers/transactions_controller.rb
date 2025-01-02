class TransactionsController < ApplicationController
  require "csv"
  def upload
    @transactions = Transaction.all
  end

  def submit
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
            balance: row[:balance].to_f
          }
        end

        Transaction.insert_all!(transactions)

        flash[:notice] = "#{transactions.size} transactions parsed successfully."
      rescue CSV::MalformedCSVError => e
        flash[:alert] = "There was an error parsing the CSV file: #{e.message}"
      end
    else
      flash[:alert] = "Please choose a file to upload."
    end

    redirect_to upload_transactions_path
  end
end
