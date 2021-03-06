#require 'twitter'

module TWSS

  class Trainer

    attr_reader :engine

    def initialize(engine, options = {})
      @engine = engine
      engine.clear_state!
    end

    def train
      path = File.join(File.dirname(__FILE__), '../../data/')

      run_training(path)

      puts "Writing to file..."
      engine.dump_classifier_to_file

      run_tests(path)
    end

    def total_documents(file)
      t = 0
      File.read(file).each_line do |l|
        t += 1
      end
      t
    end
    
    def run_training(path)
      positive_file = File.join(path, 'twss.txt')
      negative_file = File.join(path, 'non_twss.txt')

      puts "Clearing state..."
      engine.clear_state!

      puts "Training NON-TWSS strings..."
      File.read(negative_file).each_line do |l|
        print '.'
        $stdout.flush
        engine.train(TWSS::Engine::FALSE, l)
      end
      puts

      puts "Training TWSS strings..."
      File.read(positive_file).each_line do |l|
        print '.'
        $stdout.flush
        engine.train(TWSS::Engine::TRUE, l)
      end
      puts      
    end
    
    def run_tests(path)
      positive_test_file = File.join(path, 'test_twss.txt')
      negative_test_file = File.join(path, 'test_non_twss.txt')
      
      total_positive = total_documents(positive_test_file)
      total_negative = total_documents(negative_test_file)
      
      false_negatives = 0
      false_positives = 0
      total = 0
      correct = 0
      test_each(positive_test_file) do |line, result|
        if result
          correct += 1
        else
          false_negatives += 1
        end
        total += 1
      end

      test_each(negative_test_file) do |line, result|
        if !result
          correct += 1
        else
          false_positives += 1
        end
        total += 1
      end
      
      puts
      puts "Test set size: #{total}"
      puts "Overall accuracy: #{100 * correct / total.to_f}%"
      puts "False positives: #{false_positives} (#{100 * false_positives / total_negative.to_f}%)"
      puts "False negatives: #{false_negatives} (#{100 * false_negatives / total_positive.to_f}%)"
      puts
    end
    
    def test_each(file, &blk)
      i = 0
      File.read(file).each_line do |line|
        l = line.strip
        unless l.empty?
          r = TWSS(l)
          puts l + ' => ' + r.to_s
          blk.call(l, r)
          i += 1
        end
      end
    end
    
  end

end