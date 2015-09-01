require 'csvlint'
require 'mongoid'

  Before ('@data_expiry') do
    # Mongoid only supports a truncation strategy, which means that any indices created will persist - the following code
    # flushes the indices on the Validation model
    Validation.remove_indexes
    Validation.create_indexes
  end

  Before do
    FileUtils.mkdir(File.join('/', 'tmp', 'csvs'))
  end

  After do
    FileUtils.rm_r(File.join('/', 'tmp', 'csvs'))
  end
