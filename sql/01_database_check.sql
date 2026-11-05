SELECT
    current_database() AS database_name,
    current_user AS username,
    version() AS postgresql_version;

    SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;