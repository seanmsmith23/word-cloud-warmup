require 'json'
require 'awesome_print'

def parse(filepath)
  opened = File.open(filepath)
  text = File.read(opened)
  JSON.parse(text)
end

def words_into_array(hash)
  output = {}
  hash.each do |key, value|
    words = []
    value.each do |string|
      string.split.each do |word|
        words << word.downcase
      end
    end
    output[key] = words
  end
  output
end

def all_words(hash)
  words = []
  hash.map do |key, value|
    words << value
  end
  words.flatten
end

def count_words(all_words)
  array = all_words
  output = {}
  array.each do |word|
    unless output.has_key?(word)
      output[word] = {count: array.count(word), people: []}
    end
  end
  output
end

def associate_names_and_words(counted, which_words)
  final = counted
  which_words.each do |key, value|
    value.each do |word|
      if final.has_key?(word)
        unless final[word][:people].include?(key)
          final[word][:people] << key
        end
      end
    end
  end
  final
end

def word_cloud_output(filepath)
  parsed = parse(filepath)
  words_as_array = words_into_array(parsed)
  master_list_words = all_words(words_as_array)
  counted = count_words(master_list_words)
  associate_names_and_words(counted, words_as_array)
end

ap word_cloud_output('/Users/seansmith/gSchoolWork/warmups/word-cloud/data/quotes.json')

