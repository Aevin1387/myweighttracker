require "csv"

class WeightImport
  attr_reader :user, :csv, :valid, :errors

  def initialize(user, file)
    @user = user
    @csv = CSV.open(file, headers: :first_row)
    @errors = Hash.new([])
    @valid = true
  end

  def start_import
    return valid? unless verify_csv

    @csv.each do |row|
      import_row(row)
    end

    valid?
  end

  def valid?
    @valid
  end

  private

  def verify_csv
    missing_date = []
    missing_measurements = []
    @csv.each do |row|
      unless row["DATE"].present?
        missing_date << @csv.lineno
      end

      unless row["WEIGHT"].present? || row["FATMASS"].present?
        missing_measurements << @csv.lineno
      end
    end

    if missing_date.any?
      errors[:csv].add("#{missing_date.join(', ')} are missing dates.")
      @valid = false
    end

    if missing_date.any?
      errors[:csv].add("#{missing_date.join(', ')} are missing weight and/or fat.")
      @valid = false
    end

    @csv.rewind
    valid?
  end

  def import_row(row)
    weight = row["WEIGHT"]
    fat = nil

    if weight.present? && row["FATMASS"].present?
      weight = weight.to_f
      fat_mass = row["FATMASS"].to_f
      fat = ((weight/(weight-fat_mass)).to_f-1)*100
    end

    @user.measurements.where(measured_at: row["DATE"]).first_or_initialize(weight: weight, fat: fat, measured_at: row["DATE"]).save
  end
end
