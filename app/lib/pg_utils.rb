class PgUtils
  
  PG_VIEW_QUERY   = "SELECT cmname, date, mktname, currency, price FROM food_prices WHERE cmname = 'Eggs (white, AA) - Wholesale' AND mktname = 'Medellin' ORDER BY date ASC"
  PG_VIEW_QUERY_2 = "SELECT cmname, date, mktname, currency, price FROM food_prices WHERE cmname = 'Eggs (white, AA) - Wholesale' AND mktname = 'Bogota' ORDER BY date ASC"
  PG_MAT_VIEW_QUERY = PG_VIEW_QUERY

  def self.import_csv(file_path = nil)
    csv_file    = File.open('csv_data/colombia-food-prices-1.csv')
    absolute_path = File.expand_path csv_file
    ActiveRecord::Base.connection.execute("COPY food_prices FROM '#{absolute_path}' DELIMITER ',' CSV HEADER;")
  end

  def self.execute(sql_query)
    ActiveRecord::Base.connection.execute sql_query
  end

  def self.results(sql_query)
    pg_results = ActiveRecord::Base.connection.select_all sql_query
    pg_results.rows.map{|e| p e}
    return
  end


  ### POSTGRESQL VIEWS ###

  # CREATE VIEW defines a view of a query. 
  # The view is not physically materialized. 
  # Instead, the query is run every time the view is referenced in a query.
  def self.create_view
    execute "CREATE VIEW medellin_egg_evolution AS #{PG_VIEW_QUERY}"
  end

  def self.query_view
    results "SELECT * FROM medellin_egg_evolution"
  end

  def self.change_view
    execute "CREATE OR REPLACE VIEW medellin_egg_evolution AS #{PG_VIEW_QUERY_2}"
  end

  def self.change_view_name
    execute "ALTER VIEW medellin_egg_evolution RENAME TO bogota_egg_evolution"
  end

  def self.drop_view
    execute "DROP VIEW IF EXISTS medellin_egg_evolution"
  end

  def self_updatable_view
    # https://www.postgresqltutorial.com/postgresql-updatable-views/
  end



  ### POSTGRESQL MATERIALIZED VIEWS

  def self.create_mat_view
    # ActiveRecord::Base.connection.select_all sql_query
    # _.rows.map{|e| p e}
    
    execute "CREATE MATERIALIZED VIEW mat_medellin_egg_evolution AS #{PG_MAT_VIEW_QUERY} WITH NO DATA"
  end

  # When you refresh data for a materialized view, PostgreSQL locks the entire table therefore you cannot query data against it.
  def self.refresh_mat_view
    execute "REFRESH MATERIALIZED VIEW mat_medellin_egg_evolution"
  end

  # With CONCURRENTLY option, PostgreSQL creates a temporary updated version of the materialized view, compares two versions, and performs INSERT and UPDATE only the differences.
  def self.refresh_concurrently_mat_view
    execute "CREATE UNIQUE INDEX egg_evolution ON mat_medellin_egg_evolution (date)"
    execute "REFRESH MATERIALIZED VIEW CONCURRENTLY mat_medellin_egg_evolution"
  end

  def self.query_mat_view
    results "SELECT * FROM mat_medellin_egg_evolution"
  end

  def self.drop_mat_view
    execute "DROP MATERIALIZED VIEW IF EXISTS mat_medellin_egg_evolution"
  end


  # def self.benchmark
  #   puts "Query View: " + Benchmark.measure { query_view }.to_s
  #   puts "Query Materialized View: " + Benchmark.measure { query_mat_view }.to_s
  # end

end
