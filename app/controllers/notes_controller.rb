class NotesController < ApplicationController

  def self.code_samples
    @@code_samples
  end

  CREATE_SYMBOL_HASH = 'hsh = { name: "Wallace", dob: Date.new(1955,2,14), lang: "British English", favourite: "Vegan Captain Kirk" }'
  CREATE_STRING_HASH = 'hsh2 = { "name" => "Wallace", "dob" => Date.new(1955,2,14), "lang" => "British English", "favourite" => "Vegan Captain Kirk" }'
  CREATE_SYMBOL_HASH_GROMIT = 'gromit = { name: "Gromit", dob: Date.new(2001,7,4) ,address: {street: "100 Main Road", town: "Wensleydale", postcode: "WCH 33Z" } }'
  CREATE_SYMBOL_HASH_WITH_DEFAULT = 'hsh = Hash.new("N/A")'

  #TODO: Move these to a Model class
  @@code_samples =
      {
          declare_empty_hash_braces: 'hsh = {}',
          declare_empty_hash_new: 'hsh = Hash.new',
          declare_with_symbols: CREATE_SYMBOL_HASH,
          declare_with_strings: CREATE_STRING_HASH,

          symbols_vs_strings:[CREATE_SYMBOL_HASH,
                              'p hsh[:name]',
                              'p hsh["name"]'
          ],
          symbols_vs_strings_advanced:[CREATE_SYMBOL_HASH, CREATE_STRING_HASH,
            'p hsh','p hsh2',
            'puts "Hash with symbols as keys"',
            'p hsh[:name]',    
            'p hsh["name"]',    
            'puts "Hash with strings as keys"',
            'p hsh2[:name]',    
            'p hsh2["name"]',    
            'hsh3 = hsh2.deep_symbolize_keys  #Provided By Active Support core extentions',
            'puts "Hash with strings as keys converted to symbols"',
            'p hsh3[:name]',    
            'p hsh3["name"]',
            'puts "Hash with strings as keys with_indifferent_access (active_support/hash_with_indifferent_access)"',
            'p hsh2.with_indifferent_access[:name]',    
            'p hsh2.with_indifferent_access["name"]'
            ],

          hash_get_value: [CREATE_SYMBOL_HASH ,'hsh[:name]'].join("\n"),
          hash_set_value: [CREATE_SYMBOL_HASH ,'hsh[:age]=42','hsh[:age]'].join("\n"),
          hash_has_key: [CREATE_SYMBOL_HASH ,'hsh.has_key? :age'].join("\n"),
      
          hash_empty: [CREATE_SYMBOL_HASH ,'hsh.empty?'].join("\n"),
          hash_length: [CREATE_SYMBOL_HASH ,'hsh.length'].join("\n"),
          hash_each: [CREATE_SYMBOL_HASH ,'results = Array.new',
              'hsh.each {|key,value| results << "#{key} refers to #{value}"}',
              'results'].join("\n"),
          hash_clear: [CREATE_SYMBOL_HASH ,'hsh.clear'].join("\n"),
          hash_delete: [CREATE_SYMBOL_HASH ,'p hsh.delete :favourite','hsh'].join("\n"),
          hash_merge: [CREATE_SYMBOL_HASH , CREATE_SYMBOL_HASH_GROMIT,  'result = hsh.merge gromit', 'p hsh', 'result'].join("\n"),
          hash_destructive_merge_with_result: [CREATE_SYMBOL_HASH , CREATE_SYMBOL_HASH_GROMIT,  'p hsh.merge! gromit', 'hsh'].join("\n"),

          hash_select: [CREATE_SYMBOL_HASH,  'result = hsh.select {|key,value| value.is_a? String }', 'p hsh', 'result'].join("\n"),
          hash_keys: [CREATE_SYMBOL_HASH_GROMIT,  'gromit.keys'].join("\n"),
          hash_values: [CREATE_SYMBOL_HASH_GROMIT,  'gromit.values'].join("\n"),
          hash_values: [CREATE_SYMBOL_HASH_GROMIT,  'gromit.values'].join("\n"),

          hash_with_default: [CREATE_SYMBOL_HASH_WITH_DEFAULT,'p hsh','p hsh[:name]','hsh[:name]="Shawn"','hsh[:name]'],
          hash_fetch: [CREATE_SYMBOL_HASH_WITH_DEFAULT,'p hsh.fetch(:name,nil)','hsh[:name]="Shawn"','hsh.fetch(:name,nil)'],

          declare_empty_hash_with_array: 'hsh = Hash[1,2,3,4,5,6,7,8]',
          declare_empty_hash_with_odd: 'hsh = Hash["one","two","three"]',
          hash_from_to_h: ['hsh = {flavour: "Strawberry"}',
                           'puts "hsh(#{hsh.class}) = ";p hsh.to_h',
                           'puts "NIL(#{nil.class}) = "; p nil.to_h',
                           'puts "ENV(#{ENV.class}) = ";p ENV.to_h'
                           ],

          hash_delete_if:  [CREATE_SYMBOL_HASH, 'p hsh', 'p hsh.delete_if{|key,value| :favourite == key}','p hsh'],

          hash_default_proc: [CREATE_SYMBOL_HASH, 'hsh.default_proc=proc {|hash,key| "\'#{key}\' is missing"}', 'hsh[:customer_since]'],
          hash_hash: [CREATE_SYMBOL_HASH, 'hsh.hash'],

          hash_to_param: [CREATE_SYMBOL_HASH, 'hsh.to_param'],
          hash_flatten: [CREATE_SYMBOL_HASH_GROMIT, 'gromit.flatten'],
          hash_slice: [CREATE_SYMBOL_HASH_GROMIT, 'gromit.slice(:name,:address)'],
          hash_rehash: ['k1 = ["a","b"]','k2 = ["c","d"]','hsh=Hash[k1 => "value1", k2 => "value2"]', 'p hsh[k1]','k1[0]="x"', 'p k1', 'p hsh[k1]','hsh.rehash','p hsh[k1]'],
          hash_invert: [CREATE_SYMBOL_HASH, 'hsh[:nickname]="Wallace"', 'p hsh.invert','hsh'],
          hash_replace: [CREATE_SYMBOL_HASH,CREATE_SYMBOL_HASH_GROMIT, 'p hsh.object_id','hsh.replace gromit','p hsh', 'p hsh.object_id'],
          hash_shift: [CREATE_SYMBOL_HASH, 'p hsh.shift','hsh'],
          hash_to_a: [CREATE_SYMBOL_HASH_GROMIT,'gromit.to_a'],
          hash_diff: [CREATE_SYMBOL_HASH, CREATE_SYMBOL_HASH_GROMIT,'p gromit.diff hsh','p hsh.diff gromit'],

          code_sample_syntax_error_demo: [CREATE_SYMBOL_HASH, 'p hsh', 'hsh.sze']
    }




  def index
  end

  def ancestry(object)
    ancs = lambda { |kl, ancs|
      return kl.superclass.nil? ? [kl] : ancs.call(kl.superclass, ancs) << kl
    }
    ancs.call(object.class, ancs)
  end

  def sandwich
    @formvalues = params[:sandwich_form]
    @ancestry = ancestry(@formvalues)

    # Pre-populate the form values to save time in demo
    unless @formvalues.nil?
      defaults = @formvalues.to_h
    else
      defaults = {sandwich: 'Meatless Mike'}
    end

    @sandwiches = [
        "Al Bundy",
        "Backstabber",
        "Barry B.",
        "Barry Z.",
        "Bella",
        "Blind Date",
        "Brutus",
        "Captain Kirk",
        "Change",
        "Chipper's Fave",
        "Curtis",
        "Doomsday",
        "Elvis Kieth",
        "Everett Middle School",
        "Fat Bastard",
        "Forty!??",
        "Going Home For Thanksgiving",
        "Green Goblin",
        "Handsome Owl",
        "Heath Ledger",
        "Hollywood's SF Cheesesteak",
        "Holy Name Panthers",
        "Hot Momma Huda",
        "Jaymee Sirewich",
        "Jessica Rabbit",
        "Jim Rome",
        "Kryptonite",
        "Lex Luthor",
        "Lincecum",
        "Lizzy's Lips",
        "Love Triangle",
        "Matt Cain",
        "Mayoose's CA-BLT",
        "Meatless Mike",
        "Menage A Trois",
        "Nacho Boy",
        "Nacho Girl",
        "Pastrami-Charmed Life",
        "Paul Reubens",
        "Pee Wee",
        "Peg Bundy",
        "Pilgrim",
        "Pizzle",
        "Purple B's Veggie CA-BLT",
        "Sabrina's Smile",
        "Sanchez College Prep",
        "Say Hey",
        "SF Giants",
        "Sometimes I'm a Vegetarian",
        "Spiffy Tiffy",
        "Stephan Jenkins",
        "Stupid Eggplant Sandwich",
        "Super Mario",
        "The Count of Monte Chase-o",
        "The Damon Bruce",
        "The Gramps",
        "The Joker",
        "Tom Brady",
        "Tony Soprano",
        "Vegan Brutus",
        "Vegan Bud Bundy",
        "Vegan Captain Kirk",
        "Vegan Everett Middle School",
        "Vegan Gramps",
        "Vegan Green Goblin",
        "Vegan Handsome Owl",
        "Vegan Meatless Mike",
        "Vegan Pilgrim",
        "Vegan Reuben",
        "Vegan Sabrina's Smile",
        "Vegan Sometimes I'm a Vegan",
        "Vegan Strawberry Girl",
        "Vegan Tom Brady",
        "Vegan Womanizer",
        "Vegan XXXtina",
        "Vegan Your Favorite Sesame Street Character",
        "Wario",
        "We're JUST Friends",
        "Womanizer",
        "XXXtina",
        "Your Favorite Sesame Street Character",
    ]

    @sandwich = SandwichForm.new (defaults)
  end

  def beautify_code_sample(sample)
    sample #sample.gsub(/{/,"{\n ").gsub(/}/,"\n}")
  end

  def code_sample
    @code_sample_options = @@code_samples.keys.map{|key| [key, "codesample/" + key.to_s]}
    @sample_name = params.require('name')
    @sample_path = "codesample/" + @sample_name.to_s
    @code_sample = @@code_samples.fetch @sample_name.to_sym, nil
    if @code_sample.nil?
      redirect_to notes_home_path, :alert => "Code Sample Missing"
    else
      @code_sample = @code_sample.join("\n") if @code_sample.is_a? Array

      eval_current_code_sample

      @code_sample = beautify_code_sample(@code_sample)
    end
  end


  def run_code_sample sample
    #Kernel.eval(sample)

    sandbox = Shikashi::Sandbox.new
    privileges = Shikashi::Privileges.new
    privileges.allow_all
    sandbox.run(privileges, sample)

  end

  def eval_current_code_sample
    std_output = StringIO.new;
    std_error = StringIO.new;

    begin
      $stdout = std_output
      $stderr = std_error
      @code_result = run_code_sample @code_sample
    rescue SyntaxError => se
      @syntax_error = se
    rescue NameError => ne
      @syntax_error = ne
    rescue TypeError => te
      @syntax_error = te
    rescue ArgumentError => ae
      @syntax_error = ae
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end

    @std_error = std_error.string
    @std_output = std_output.string

  end

end
