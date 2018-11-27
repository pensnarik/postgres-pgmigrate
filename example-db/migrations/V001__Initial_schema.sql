create table public.test (id serial, val text);

insert into test (val) select n::text from generate_series(1, 100000) n;
