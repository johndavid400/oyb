class Import

  def self.set_values
    Day.all.each do |day|
      day.day_of_month = day.date.strftime("%-d")
      day.month_of_year = day.date.strftime("%-m")
      day.save if day.changed?
    end
  end

  def convert_passages
    self.ot = convert_passage(ot)
    self.nt = convert_passage(nt)
    self.psalm = convert_passage(psalm)
    self.proverb = convert_passage(proverb)
    save if changed?
    puts id
  end

  def convert_passage(str)
    return "SNG.1.1-SNG.4.16" if id == 249
    return "SNG.5.1-SNG.8.14" if id == 250

    v1, v2 = str.split("-")
    book1, verse1, prefix1 = v1.split(" ")
    book2, verse2, prefix2 = v2.split(" ") if v2.present?
    if prefix1.present?
      book1 = "#{book1} #{verse1}"
      verse1 = prefix1
    end
    if prefix2.present?
      book2 = "#{book2} #{verse2}"
      verse2 = prefix2
    end
    if v2.present? && verse2.nil?
      verse2 = book2
      book2 = book1
    end
    verse2 = "#{verse1.split(":").first}:#{verse2}" unless v2.nil? || verse2.match(":").present?
    new1 = "#{table[book1]}.#{verse1.gsub(':', '.')}"
    new2 = "#{table[book2]}.#{verse2.gsub(':', '.')}" if v2.present?
    if v2.present?
      [new1, new2].join("-")
    else
      new1
    end
  rescue
    puts "FAILED ON #{id}"
  end

  def table
    # Bible.new.books("de4e12af7f28f599-02")["data"].map{|s| [s["name"], s["id"]] }.to_h
    {"Genesis"=>"GEN",
     "Exodus"=>"EXO",
     "Leviticus"=>"LEV",
     "Numbers"=>"NUM",
     "Deuteronomy"=>"DEU",
     "Joshua"=>"JOS",
     "Judges"=>"JDG",
     "Ruth"=>"RUT",
     "1 Samuel"=>"1SA",
     "2 Samuel"=>"2SA",
     "1 Kings"=>"1KI",
     "2 Kings"=>"2KI",
     "1 Chronicles"=>"1CH",
     "2 Chronicles"=>"2CH",
     "Ezra"=>"EZR",
     "Nehemiah"=>"NEH",
     "Esther"=>"EST",
     "Job"=>"JOB",
     "Psalm"=>"PSA",
     "Psalms"=>"PSA",
     "Proverbs"=>"PRO",
     "Ecclesiastes"=>"ECC",
     "SNG"=>"SNG",
     "Isaiah"=>"ISA",
     "Jeremiah"=>"JER",
     "Lamentations"=>"LAM",
     "Ezekiel"=>"EZK",
     "Daniel"=>"DAN",
     "Hosea"=>"HOS",
     "Joel"=>"JOL",
     "Amos"=>"AMO",
     "Obadiah"=>"OBA",
     "Jonah"=>"JON",
     "Micah"=>"MIC",
     "Nahum"=>"NAM",
     "Habakkuk"=>"HAB",
     "Zephaniah"=>"ZEP",
     "Haggai"=>"HAG",
     "Zechariah"=>"ZEC",
     "Malachi"=>"MAL",
     "Matthew"=>"MAT",
     "Mark"=>"MRK",
     "Luke"=>"LUK",
     "John"=>"JHN",
     "Acts"=>"ACT",
     "Romans"=>"ROM",
     "1 Corinthians"=>"1CO",
     "2 Corinthians"=>"2CO",
     "Galatians"=>"GAL",
     "Ephesians"=>"EPH",
     "Philippians"=>"PHP",
     "Colossians"=>"COL",
     "1 Thessalonians"=>"1TH",
     "2 Thessalonians"=>"2TH",
     "1 Timothy"=>"1TI",
     "2 Timothy"=>"2TI",
     "Titus"=>"TIT",
     "Philemon"=>"PHM",
     "Hebrews"=>"HEB",
     "James"=>"JAS",
     "1 Peter"=>"1PE",
     "2 Peter"=>"2PE",
     "1 John"=>"1JN",
     "2 John"=>"2JN",
     "3 John"=>"3JN",
     "Jude"=>"JUD",
     "Revelation"=>"REV"
    }
  end

end
