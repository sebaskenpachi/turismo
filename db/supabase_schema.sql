-- Rutas Panamá — esquema inicial Supabase

create table if not exists tourist_routes (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  description text not null,
  city text not null default 'Panamá',
  latitude double precision not null,
  longitude double precision not null,
  estimated_minutes integer,
  budget_level text check (budget_level in ('low', 'medium', 'high')) default 'medium',
  difficulty text check (difficulty in ('easy', 'medium', 'hard')) default 'easy',
  image_url text,
  active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists route_stops (
  id uuid primary key default gen_random_uuid(),
  route_id uuid references tourist_routes(id) on delete cascade,
  name text not null,
  description text,
  latitude double precision not null,
  longitude double precision not null,
  stop_order integer not null default 1,
  category text,
  audio_text text,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists sponsored_places (
  id uuid primary key default gen_random_uuid(),
  route_id uuid references tourist_routes(id) on delete set null,
  name text not null,
  category text not null,
  description text,
  latitude double precision not null,
  longitude double precision not null,
  sponsor_level integer default 0,
  website_url text,
  phone text,
  image_url text,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists user_favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  route_id uuid references tourist_routes(id) on delete cascade,
  created_at timestamptz default now()
);

insert into tourist_routes (slug, name, description, city, latitude, longitude, estimated_minutes, budget_level, difficulty)
values
('cerro-ancon', 'Ruta Cerro Ancón', 'Naturaleza, historia y una de las mejores vistas de la Ciudad de Panamá.', 'Ciudad de Panamá', 8.9574, -79.5496, 120, 'low', 'medium'),
('cinta-costera', 'Ruta Cinta Costera', 'Camina frente a la bahía, conecta gastronomía, vistas y vida urbana.', 'Ciudad de Panamá', 8.9744, -79.5226, 90, 'low', 'easy'),
('casco-viejo', 'Ruta Casco Viejo', 'Historia, arquitectura, plazas, cafés, rooftops y cultura panameña.', 'Ciudad de Panamá', 8.9525, -79.5353, 180, 'medium', 'easy')
on conflict (slug) do nothing;
