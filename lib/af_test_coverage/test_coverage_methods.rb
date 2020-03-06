# frozen_string_literal: true

module AfTestCoverage
  module TestCoverageMethods
    def start_recording_code_coverage
      if AfTestCoverage.enabled?
        AfTestCoverage.coverage_collectors.each do |coverage_collector_class, coverage_collector|
          coverage_collector.on_start
        end
      end
    end

    def write_code_coverage_artifact
      if AfTestCoverage.enabled?
        cleanup_stubs
        test_filename = method(name_of_test).source_location[0]
        FileUtils.mkdir_p(coverage_path)
        f = File.open(coverage_file_name, 'w')
        cleaned_coverage = {}.tap do |cleaned|
          AfTestCoverage.coverage_collectors.values.each do |coverage_collector|
            coverage_collector.covered_files.each do |covered_file, coverage_data|
              next if AfTestCoverage.exclude_file?(covered_file)
              cleaned[covered_file] ||= {}
              cleaned[covered_file][coverage_collector.class.name] = coverage_data
            end
          end
        end
        coverage_file_data = {
          filename: test_filename,
          coverage: cleaned_coverage
        }
        f.write(coverage_file_data.to_json)
        f.close
      end
    end

    def name_of_test
      method_name
    end

    def coverage_path
      AfTestCoverage.config.coverage_path
    end

    def coverage_file_name
      basename = "#{self.class.name}__#{name_of_test}.json".tr(' /', '__')
      max_filename_length = 255
      basename = trim_front(basename, max_filename_length - coverage_path.length)
      File.join(coverage_path, basename)
    end

    def trim_front(str, max_length)
      str.length > max_length ? str[-max_length...] : str
    end

    def cleanup_stubs
      File.unstub(:open)
      File.unstub(:directory?)
    end
  end
end
